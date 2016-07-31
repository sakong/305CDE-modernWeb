<?php
require_once 'db.php';
require_once 'Slim/Slim.php';
 
\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

// setting
$app->get('/setting', 'getSettings');
// index
$app->get('/index', 'getIndexContent');
// information
$app->get('/information', 'getinformationContent');
$app->get('/informationitem/:id', 'getinformationItem');
// users
$app->get('/user/:uid', 'getUserinfo');
$app->post('/register', 'addUser');
$app->post('/login', 'checkLogin');
$app->post('/changepassword', 'changePassword');
// favourite
$app->get('/favlist/:uid', 'getMyFavList');
$app->put('/addfav/:uid/:id', 'addfav');
$app->delete('/removeFav/:uid/:id', 'removeFav');
// forum
$app->get('/getForum', 'getForum');
$app->get('/topic/:id', 'viewTopic');
$app->get('/comments/:id', 'getComments');
$app->post('/addTopic', 'addNewTopic');
$app->post('/addReply', 'addReply');
$app->put('/updateTopic', 'updateTopic');
$app->delete('/deleteTopic/:id', 'deleteTopic');
$app->delete('/deleteComment/:id', 'deleteComment');
// contact
$app->post('/contact', 'sendContact');


$app->run();

function getMyFavList($uid){
  global $db;

  $sql = "SELECT * FROM tc_users WHERE userid=:uid";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("uid", $uid);
      $stmt->execute();
      $user = $stmt->fetchObject();
      
      // prepare fav array list
      if ($user->fav != NULL) {// have fav record
        $fav = json_decode($user->fav, true);
        if (count($fav)>0){
          $sql = "select * FROM tc_information WHERE FIND_IN_SET (information_id, :ids) AND status='active' ORDER BY created_date DESC, information_id DESC";
          $ids = implode(",", $fav);
          try {
              $stmt = $db->prepare($sql);
              $stmt->bindParam("ids", $ids);
              $stmt->execute();
              $info = $stmt->fetchAll(PDO::FETCH_OBJ);
              $db = null;
              echo '{"information": ' . json_encode($info) . '}';
          } catch(PDOException $e) {
              echo '{"error":{"text":"getMyFavList 1'. $e->getMessage() .'"}}';
          }
        } else {
        echo '{"information": []}';
        }
      } else {
        echo '{"information": []}';
        }

      
  } catch(PDOException $e) {
      echo '{"error":{"text": "getMyFavList 2:'. $e->getMessage() .'"}}';
  }
}

function getIndexContent(){
	global $db;
  $sql = 'select * FROM tc_content WHERE type="index" LIMIT 1';
  try {
      $stmt = $db->query($sql);
      $content = $stmt->fetchAll(PDO::FETCH_OBJ);
      $db = null;
      echo '{"index": ' . json_encode($content) . '}';
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function getinformationContent(){
	global $db;
  $sql = 'select * FROM tc_information WHERE status="active" ORDER BY created_date DESC, information_id DESC';
  try {
      $stmt = $db->query($sql);
      $content = $stmt->fetchAll(PDO::FETCH_OBJ);
      $db = null;
      echo '{"information": ' . json_encode($content) . '}';
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function getinformationItem($id){
  global $db;
  $sql = "SELECT * FROM tc_information WHERE information_id=:id";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("id", $id);
      $stmt->execute();
      $info = $stmt->fetchObject();
      $db = null;
      echo json_encode($info);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function getSettings(){
	global $db;
  $sql = 'select * FROM tc_setting';
  try {
      $stmt = $db->query($sql);
      $content = $stmt->fetchAll(PDO::FETCH_OBJ);
      $db = null;
      $ary = array();
      foreach ($content as $val){
      	$ary[$val->key] = $val->value;
      }
      echo '{"setting": ' . json_encode($ary) . '}';
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}
function addUser(){
  global $db;

  $request = \Slim\Slim::getInstance()->request();
  $user = json_decode($request->getBody());

  $sql = "SELECT COUNT(*) FROM tc_users WHERE username = '".$user->username."' OR email ='".$user->email."'";
  
  if ($db->query($sql)->fetchColumn() != 0) {
    echo '{"error":{"text":"Username OR Email is already in use, please try another."}}';
  }
  else
  {
    $sql = "INSERT INTO tc_users (username, email, password, code) VALUES (:username, :email, :password, :code)";
    try {
        $stmt = $db->prepare($sql);
        $stmt->bindParam("username", $user->username);
        $stmt->bindParam("email", $user->email);
        $stmt->bindParam("password", md5($user->password));
        $stmt->bindParam("code", generateRandomString(10));
        $stmt->execute();
        $user->id = $db->lastInsertId();
        $db = null;
        echo json_encode($user);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $user.$e->getMessage() .'}}';
    }
  }
}

function getUserinfo($uid){
  global $db;

  $sql = "SELECT * FROM tc_users WHERE userid=:uid";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("uid", $uid);
      $stmt->execute();
      $user = $stmt->fetchObject();
      $db = NULL;
      echo json_encode($user);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function addfav($uid, $id){
  global $db;

  $sql = "SELECT * FROM tc_users WHERE userid=:uid";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("uid", $uid);
      $stmt->execute();
      $user = $stmt->fetchObject();
      
      // prepare fav array list
      if ($user->fav != NULL) {
        $fav = json_decode($user->fav, true);
        $fav[] = $id;
        $fav = array_unique($fav);
      }
      else $fav = array($id);

      $fav = json_encode($fav);

      $sql = "UPDATE tc_users SET fav=:fav WHERE userid=:uid";
      try {
          $stmt = $db->prepare($sql);
          $stmt->bindParam("fav", $fav);
          $stmt->bindParam("uid", $uid);
          $stmt->execute();
          $db = null;
          $user->fav = $fav;
          echo json_encode($user);
      } catch(PDOException $e) {
          echo '{"error":{"text":'. $e->getMessage() .'}}';
      }
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function removeFav($uid, $id){
  global $db;

  $sql = "SELECT * FROM tc_users WHERE userid=:uid";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("uid", $uid);
      $stmt->execute();
      $user = $stmt->fetchObject();
      
      // prepare fav array list
      if ($user->fav != NULL) {
        $fav = json_decode($user->fav, true);
        if (count($fav)>0){
          $pos = array_search($id, $fav);
          unset($fav[$pos]);
          $fav = array_values($fav);
        }
      }
      $fav = json_encode($fav);

      $sql = "UPDATE tc_users SET fav=:fav WHERE userid=:uid";
      try {
          $stmt = $db->prepare($sql);
          $stmt->bindParam("fav", $fav);
          $stmt->bindParam("uid", $uid);
          $stmt->execute();
          $db = null;
          echo json_encode($user);
      } catch(PDOException $e) {
          echo '{"error":{"text":'. $e->getMessage() .'}}';
      }
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function checkLogin(){
  global $db;

  $request = \Slim\Slim::getInstance()->request();
  $user = json_decode($request->getBody());

  $sql = "SELECT * FROM tc_users WHERE username =:username AND password =:password";

  try{
    $sth = $db->prepare($sql);
    $sth->bindParam("username", $user->username);
    $sth->bindParam("password", md5($user->password));
    $sth->execute();
    $db = null;
    $user = $sth->fetchObject();
    echo json_encode($user);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function changePassword(){
  global $db;

  $request = \Slim\Slim::getInstance()->request();
  $pwd = json_decode($request->getBody());


  $sql = "SELECT * FROM tc_users WHERE userid=:id AND password=:password";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("password", md5($pwd->oldpassword));
      $stmt->bindParam("id", $pwd->uid);
      $stmt->execute();

      $sql = "UPDATE tc_users SET password=:password WHERE userid=:id";
      try {
          $stmt = $db->prepare($sql);
          $stmt->bindParam("password", md5($pwd->password));
          $stmt->bindParam("id", $pwd->uid);
          $stmt->execute();
          $db = null;
          echo '{"success":{"text": "Password update successfully"}}';
      } catch(PDOException $evt) {
          echo '{"error":{"text":'. $evt->getMessage() .'}}';
      }

  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }

  
}

function getForum(){
  global $db;
  $sql = 'select f.*, u.username FROM tc_forum f, tc_users u WHERE f.uid = u.userid ORDER BY updated_date DESC';
  try {
      $stmt = $db->query($sql);
      $content = $stmt->fetchAll(PDO::FETCH_OBJ);
      $db = null;
      foreach ($content as $key=>$v){
      $content[$key]->created_date = date("j\<\s\u\p\>S\<\/\s\u\p\> M, Y H:i", strtotime($content[$key]->created_date));
      $content[$key]->updated_date = date("j\<\s\u\p\>S\<\/\s\u\p\> M, Y", strtotime($content[$key]->updated_date));
      }
      echo '{"forum": ' . json_encode($content) . '}';
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function viewTopic($id){
  global $db;
  $sql = "SELECT f.*, u.username FROM tc_forum f, tc_users u WHERE f.topicid=:id AND f.uid = u.userid";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("id", $id);
      $stmt->execute();
      $topic = $stmt->fetchObject();
      $db = null;
      $topic->content = nl2br($topic->content);
      $topic->created_date = date("j\<\s\u\p\>S\<\/\s\u\p\> M, Y H:i:s", strtotime($topic->created_date));
      $topic->updated_date = date("j\<\s\u\p\>S\<\/\s\u\p\> M, Y", strtotime($topic->updated_date));
      
      echo json_encode($topic);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function getComments($id){
  global $db;
  $sql = 'select f.*, u.username FROM tc_forumcomments f, tc_users u WHERE f.uid = u.userid AND f.topicid=:id ORDER BY created_date DESC';
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("id", $id);
      $stmt->execute();
      $comments = $stmt->fetchAll(PDO::FETCH_OBJ);
      $db = null;
      foreach ($comments as $key=>$v){
      $comments[$key]->created_date = date("j\<\s\u\p\>S\<\/\s\u\p\> M, Y H:i:s", strtotime($comments[$key]->created_date));
      $comments[$key]->updated_date = date("j\<\s\u\p\>S\<\/\s\u\p\> M, Y", strtotime($comments[$key]->updated_date));
      }
      
      echo json_encode($comments);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function addNewTopic(){
  global $db;

  $request = \Slim\Slim::getInstance()->request();
  $topic = json_decode($request->getBody());

  $sql = "INSERT INTO tc_forum (uid, category, title, content) VALUES (:uid, :category, :title, :content)";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("uid", $topic->uid);
      $stmt->bindParam("category", $topic->category);
      $stmt->bindParam("title", $topic->title);
      $stmt->bindParam("content", $topic->content);
      $stmt->execute();
      $topic->id = $db->lastInsertId();
      $db = null;
      echo json_encode($topic);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $topic.$e->getMessage() .'}}';
  }
}

function addReply(){
  global $db;

  $request = \Slim\Slim::getInstance()->request();
  $reply = json_decode($request->getBody());

  $sql = "INSERT INTO tc_forumcomments (topicid, uid, content) VALUES (:topicid, :uid, :content)";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("topicid", $reply->topicid);
      $stmt->bindParam("uid", $reply->uid);
      $stmt->bindParam("content", $reply->content);
      $stmt->execute();
      $reply->id = $db->lastInsertId();
      $db = null;
      echo json_encode($reply);
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function updateTopic(){

}

function deleteTopic($id){
  global $db;
  $sql = "DELETE FROM tc_forum WHERE topicid=:id";
  try {
      $stmt = $db->prepare($sql);
      $stmt->bindParam("id", $id);
      $stmt->execute();
      $db = null;
  } catch(PDOException $e) {
      echo '{"error":{"text":'. $e->getMessage() .'}}';
  }
}

function deleteComment($id){
  // comment table has been set a foreign key, comments will be deleted when Topic is deleted.
}

function sendContact(){
  $request = \Slim\Slim::getInstance()->request();
  $contact = json_decode($request->getBody());

  $to = "blingblingthree@outlook.com";
  $headers = "MIME-Version: 1.0" . "\r\n";
  $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
  $headers .= "From: ".$contact->email;
  $subject = "Website Enquiry";
  $message = $contact->message."<br/><br/>-- from<br/>".$contact->txtName."<br/>".$contact->email;

  if (mail($to,$subject,$message,$headers)){
    echo '{"success":{"text": "Email sent."}}';
  } else {
    echo '{"error":{"text": "cannot send email."}}';
  }

}

// HELPERS
// http://stackoverflow.com/questions/4356289/php-random-string-generator
function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}
?>