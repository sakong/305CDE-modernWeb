// var rootURL = "http://10.0.24.94/test/modernweb/html/api/";
var rootURL = "./api/";
// var rootURL = "http://localhost/html/api/";

$(document).on('pageinit', "#login, #register", function(){
    if(localStorage.username) $.mobile.changePage("myaccount.html");
});

$(document).on('pagebeforeshow', '[data-role="page"]', function(event, data){ // not using document ready
  var curPage = $.mobile.activePage.attr("id"); // get the current page id
    var url = $.url();
    console.log(curPage);
    console.log("user status: "+localStorage.uid);

    // load header and footer
    $.mobile.activePage.find('[data-role="header"]').load("include/templates/header.html", function(){ 
        $(this).parent().trigger('create');
        if (localStorage.username) {
          $(".loginbtn").html("Setting").attr("href", "myaccount.html");
      }
      else {
          $(".loginbtn").html("Sign In").attr("href", "login.html");
      }
  }); 
    $.mobile.activePage.find('[data-role="footer"]').load("include/templates/footer.html", function(){ 
        $(this).parent().trigger('create');
        curPage = $.mobile.activePage.attr("id");
        $(this).find("a[href='"+curPage+".html']").addClass('ui-btn-active ui-state-persist'); // footer menu active class
        if (curPage == "informationitem") {
            $(this).find("a[href='information.html']").addClass('ui-btn-active ui-state-persist');
        }
        if (curPage == "topic") {
            $(this).find("a[href='forum.html']").addClass('ui-btn-active ui-state-persist');
        }
    });  


    var redirect = false;
  // load page
  switch (curPage){

  case 'myaccount':
  getMyAccount();
  break;

  case 'login':
  case 'register':
  if(localStorage.uid) {
    redirect = true; // quit
    window.location.href="myaccount.html"; // no ajax
  }
  break;

  case 'index':
  getIndex(); // run index page content
  break;

  case 'information':
  getInformation();
  break;

  case 'informationitem':
  getInformationItem();
  break;

  case 'forum':
  if(!localStorage.uid) {
    redirect = true; // quit
    window.location.href="login.html"; // no ajax
  } else {
    $.mobile.activePage.find("form#addtopic #Username").val(localStorage.username);
    getForum();
  }
  break;

  case 'topic':
  if(!localStorage.uid) {
    redirect = true; // quit
    window.location.href="login.html"; // no ajax
  } else {
    if (url.param('id')){
      $.mobile.activePage.find("form#replytopic #Username").val(localStorage.username);
      viewTopic(url.param('id'));
    } else { // no topic id
      redirect = true; // quit
      window.location.href="forum.html"; // no ajax
    }
  }
  break;

  case 'contact':
  goContact();
  break;

  }

  // load global setting

  if (redirect===false){
      runSetting();
  }

  function getForum(){
    $.ajax({
      type: 'GET',
      url: rootURL+'getForum',
        dataType: "json", // data type of response
        success: function(data){
          var str = "";
            $.each(data.forum, function(index, item) {
                str += '<tr><td>'+item.category+'</td><th><a href="topic.html?id='+item.topicid+'">'+item.title+'</a></th>';
                str += '<td>'+item.created_date+'</td>';
                str += '<td>'+item.username+'</td></tr>';
            });
            $.mobile.activePage.find("tbody#forumBody").empty().append(str);
            $.mobile.activePage.find("#table-forum").table("refresh").trigger("create").enhanceWithin();
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert('error: ' + textStatus);
        }
    });
  }

  function viewTopic($id){
    $.ajax({
      type: 'GET',
      url: rootURL+'topic/'+$id,
        dataType: "json", // data type of response
        success: function(data){
          $.mobile.activePage.find("h1").html(data.title);
          $.mobile.activePage.find("#category").html(data.category);
          $.mobile.activePage.find("#date").html(data.created_date);
          $.mobile.activePage.find("#postedby").html(data.username);
          $.mobile.activePage.find("#addReply input[name='topicid']").val($id);
          $.mobile.activePage.find("#addReply input[name='uid']").val(localStorage.uid);
          $.mobile.activePage.find("#addReply input[name='username']").val(localStorage.username);
          $.mobile.activePage.find("#mainContent").html(data.content);
          if (data.uid == localStorage.uid) $.mobile.activePage.find("#manage").show();
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert('error: ' + textStatus);
        }
    });
    // get comments
    $.ajax({
      type: 'GET',
      url: rootURL+'comments/'+$id,
        dataType: "json", // data type of response
        success: function(data){
          var str="";
        
          $.each(data, function(index, item) {
              str += '<div style="border: 1px solid #eee; padding: 15px 10px; font-size:70%;margin:10px 0;">';
              str += '<b>Name: '+item.username+'</b><br/>';
              str += '<p>'+item.content+' -- <i>@ '+item.created_date+'</i></p></div>';
          });
          $.mobile.activePage.find("#comments").html(str);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert('error: ' + textStatus);
        }
    });
  }

  $(document).on("click", "#deleteTopic",function(){
    if (url.param('id')){
      $.ajax({
        type: 'DELETE',
        url: rootURL+'deleteTopic/'+url.param('id'),
        success: function(data){
          alert ("Topic deleted successfully");
          window.location.href="forum.html";
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert('error: ' + textStatus);
        }
      });
    }
  });

function goContact(){

}

function runSetting(){
  $.ajax({
      type: 'GET',
      url: rootURL+'setting',
          dataType: "json", // data type of response
          success: function(data){
              $.each(data.setting, function(index, item) {
                  $.mobile.activePage.find("#"+index).html(item); // need specify which page you are in, cos JQ using ajax
              });
          },
          error: function(jqXHR, textStatus, errorThrown){
              alert('error: ' + textStatus);
          }
      });
}

function getIndex(){
    $.ajax({
        type: 'GET',
        url: rootURL+curPage,
            dataType: "json", // data type of response
            success: function(data){
                $.mobile.activePage.find('[data-role="content"]').html("<h2>"+data.index[0]['title']+"</h2>"+data.index[0]['content']);
            },
            error: function(jqXHR, textStatus, errorThrown){
                alert('error: ' + textStatus);
            }
        });
}

function getInformation(){
    $.ajax({
        type: 'GET',
        url: rootURL+curPage,
            dataType: "json", // data type of response
            success: function(data){
                var str = '<h1>Useful Informations</h1>';
                str += '<ul data-role="listview" data-inset="true"><li data-role="list-divider" data-theme="a">Latest articles</li>';
                $.each(data.information, function(index, item) {
                    str += '<li data-theme="c"><a class="infoDetail" href="informationitem.html?infoId='+item['information_id']+'">'+item['title']+'</a></li>';
                });
                $.mobile.activePage.find('[data-role="content"]').html(str+'</ul>').trigger('create');
                $.mobile.resetActivePageHeight();
            },
            error: function(jqXHR, textStatus, errorThrown){
                alert('error: ' + textStatus);
            }
        });
}

function getInformationItem(){
    var infoId = url.param('infoId');
    if (infoId != 'undefined'){
        $.ajax({
            type: 'GET',
            url: rootURL+curPage+"/"+infoId,
                dataType: "json", // data type of response
                success: function(data){
                    var str = '<h1>'+data.title+'</h1>';
                    str += '<p style="text-align:right;"><a href="#" class="addToFav" data-role="button" data-icon="flat-heart" data-iconpos="notext" data-theme="c" data-inline="true" alt="Add To Favourite" title="Add To Favourite">Add To Favourite</a></p>';
                    str += data.content;
                    str += '<p><a href="information.html" data-ajax="false" class="ui-btn-b ui-btn ui-btn-inline ui-shadow ui-corner-all">Back to Information List</a></p>';
                    $.mobile.activePage.find('[data-role="content"]').html(str).trigger('create');
                    $.mobile.resetActivePageHeight();
                },
                error: function(jqXHR, textStatus, errorThrown){
                    alert('error: ' + textStatus);
                }
            });
        if (localStorage.uid){
            console.log(rootURL+'user'+"/"+localStorage.uid);
            $.ajax({
                type: 'GET',
                url: rootURL+'user'+"/"+localStorage.uid,
                    dataType: "json", // data type of response
                    success: function(data){
                        console.log("#"+$.inArray(infoId, data.fav));
                        if ($.inArray(infoId, data.fav) > -1){
                          $.mobile.activePage.find(".addToFav").hide();
                          setTimeout(function(){ 
                            $.mobile.activePage.find(".addToFav").addClass('removeFav ui-btn-d').removeClass('addToFav ui-btn-c').attr({
                              "data-theme": "d",
                              "alt" : "Remove from your favourite list.",
                              "title": "Remove from your favourite list."}).show();
                        }, 500);

                      }
                  },
                  error: function(jqXHR, textStatus, errorThrown){
                    alert('error: ' + textStatus);
                }
            });
        }

    }

}

$(document).off("vclick", ".addToFav").on("vclick", ".addToFav",function(e){
    var infoId = url.param('infoId');
    var $this = $(this);
    if(localStorage.uid){
            // ajax
            $.ajax({
                type: 'PUT',
                url: rootURL+"addfav"+"/"+localStorage.uid+"/"+infoId,
                success: function(data){
                    $this.removeClass('addToFav ui-btn-c').addClass('removeFav ui-btn-d').attr({
                      "data-theme": "d",
                      "alt" : "Remove from your favourite list.",
                      "title": "Remove from your favourite list."});
                },
                error: function(jqXHR, textStatus, errorThrown){
                    alert('error: ' + textStatus);
                }
            });
        } else {
            alert ("Please login first!");
        }
    });

$(document).off("vclick", ".removeFav").on("vclick", ".removeFav",function(e){
    var infoId = url.param('infoId');
    var $this = $(this);
    if(localStorage.uid){
            // ajax
            $.ajax({
                type: 'DELETE',
                url: rootURL+"removeFav"+"/"+localStorage.uid+"/"+infoId,
                success: function(data){
                    $this.removeClass('removeFav ui-btn-d').addClass('addToFav ui-btn-c').attr({
                      "data-theme": "c",
                      "alt" : "Add to Favourite",
                      "title": "Add to Favourite"});
                },
                error: function(jqXHR, textStatus, errorThrown){
                    alert('error: ' + textStatus);
                }
            });
        } else {
            alert ("Please login first!");
        }
    });

function getMyAccount(){
    if(localStorage.uid){
        $.mobile.activePage.find("h1").html("Hello "+localStorage.username+"!");

        $.ajax({
          type: 'GET',
          url: rootURL+"favlist/"+localStorage.uid,
              dataType: "json", // data type of response
              success: function(data){
                if (data.information.length>0){
                  var str = '<ul data-role="listview" data-inset="true"><li data-role="list-divider" data-theme="f">My favourite list</li>';

                  $.each(data.information, function(index, item) {
                      str += '<li data-theme="c"><a class="infoDetail" href="informationitem.html?infoId='+item['information_id']+'">'+item['title']+'</a></li>';
                  });
                  $.mobile.activePage.find('[data-role="content"] #favList').append(str+'</ul>').trigger('create');
                  $.mobile.activePage.find('[data-role="content"] #favList > i').hide();
                  $.mobile.resetActivePageHeight();
              }                  
          },
          error: function(jqXHR, textStatus, errorThrown){
              alert('error: ' + textStatus);
          }
      });
    }
}

// for registration page
$("#signupForm").validate({
  rules: {
    username: {
      required: true,
      minlength: 5,
      maxlength: 32
    },
    password: {
        required: true,
        minlength: 5,
        maxlength: 32
    },
    password2: {
        required: true,
        equalTo: "#password"
    },
    email: {
        required: true,
        email: true
    }
  },
  messages: {
    username: {
      required: "Please enter a username",
      minlength: "Your username must consist of at least 5 characters",
      maxlength: "Your username must be less than 32 characters long"
    },
    password: {
        required: "Please provide a password",
        minlength: "Your password must be at least 5 characters long",
        maxlength: "Your username must be less than 32 characters long"
    },
    password2: {
        required: "Please verify your password",
        equalTo: "Please enter the same password as above"
    },
    email: "Please enter a valid email address",
  },
  submitHandler: function() {
    var v = grecaptcha.getResponse();
    if (v.length == 0){
     $("#signupForm").find("#reCaptcha").after('<label for="reCaptcha" class="error">You must complete the antispam verification</label>');
    } else {
        var data = JSON.stringify($('#signupForm').serializeObject());
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: rootURL+"register",
            dataType: "json",
            data: data,
            success: function(data, textStatus, jqXHR){
                $.mobile.changePage("#success");
            },
            error: function(jqXHR, textStatus, errorThrown){
                $("#signupForm h3").after('<p class="error">Error: <b>' + textStatus+'</b></p>');
            }
        });
    }
  },
  errorPlacement: function( error, element ) {
    error.insertAfter( element.parent() );
  }
});

// for login page
$("#signinForm").validate({
  rules: {
    username: {
      required: true,
      minlength: 5,
      maxlength: 32
    },
    password: {
        required: true,
        minlength: 5,
        maxlength: 32
    }
  },
  messages: {
    username: {
      required: "Please enter a username",
      minlength: "Your username must consist of at least 5 characters",
      maxlength: "Your username must be less than 32 characters long"
    },
    password: {
        required: "Please provide a password",
        minlength: "Your password must be at least 5 characters long",
        maxlength: "Your username must be less than 32 characters long"
    }
  },
  submitHandler: function() {
    var v = grecaptcha.getResponse();
    if (v.length == 0){
      $("#signinForm").find("#reCaptcha").after('<label for="reCaptcha" class="error">You must complete the antispam verification</label>');
    } else {
      var data = JSON.stringify($('#signinForm').serializeObject());
      $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: rootURL+"login",
        dataType: "json",
        data: data,
        success: function(data, textStatus, jqXHR){
          if(data !== false){
            // login successful
            localStorage.setItem('uid',data.userid);
            localStorage.setItem('username',data.username);
            window.location.href="myaccount.html"; // no ajax
          } else {
              $("#signinForm h3").after('<p class="error">Username OR password is incorrect, please try again.</p>');
          }
        },
        error: function(jqXHR, textStatus, errorThrown){
            $("#signinForm h3").after(jqXHR.responseText +'<p class="error">Error: <b>' + textStatus+'</b></p>');
        }
      });
    }
  },
  errorPlacement: function( error, element ) {
    error.insertAfter( element.parent() );
  }
});


// for forum page, add new topic
$("#addtopic").validate({
  rules: {
    title: {
      required: true,
      minlength: 5,
      maxlength: 200
    },
    content: {
        required: true,
        minlength: 5,
        maxlength: 5000
    }
  },
  messages: {
    title: {
      required: "Please input the title",
      minlength: "Title must consist of at least 5 characters",
      maxlength: "Title must be less than 200 characters long"
    },
    content: {
        required: "Please input the content",
        minlength: "Content must be at least 5 characters long",
        maxlength: "Content must be less than 5000 characters long"
    }
  },
  submitHandler: function() {
    $.mobile.activePage.find('input[name="uid"]').val(localStorage.uid);
    var data = JSON.stringify($('#addtopic').serializeObject());
    $.ajax({
      type: 'POST',
      contentType: 'application/json; charset=utf-8',
      url: rootURL+"addTopic",
      dataType: "json",
      data: data,
      success: function(data, textStatus, jqXHR){
        getForum();
      },
      error: function(jqXHR, textStatus, errorThrown){
          $.mobile.activePage.find("h3").after(jqXHR.responseText +'<p class="error">Error: <b>' + textStatus+'</b></p>');
      }
    });
  },
  errorPlacement: function( error, element ) {
    error.insertAfter( element.parent() );
  }
});

// for forum page, add reply
$("#addReply").validate({
  rules: {
    content: {
        required: true,
        minlength: 5,
        maxlength: 1000
    }
  },
  messages: {
    content: {
        required: "Please input the content",
        minlength: "Content must be at least 5 characters long",
        maxlength: "Content must be less than 1000 characters long"
    }
  },
  submitHandler: function() {
    var data = JSON.stringify($('#addReply').serializeObject());
    $.ajax({
      type: 'POST',
      contentType: 'application/json; charset=utf-8',
      url: rootURL+"addReply",
      dataType: "json",
      data: data,
      success: function(data, textStatus, jqXHR){
        var str="";
        var comment = $.mobile.activePage.find("#comments");
        if (comment.html()=="No comment yet."){
          // no comment
          comment.empty();
        }
        str += '<div style="border: 1px solid #eee; padding: 15px 10px; font-size:70%;margin:10px 0;">';
        str += '<b>Name: '+localStorage.username+'</b><br/>';
        str += '<p>'+data.content+' -- <i>@ just added</i></p></div>';

        comment.prepend(str);

      },
      error: function(jqXHR, textStatus, errorThrown){
          $.mobile.activePage.find("h3").after(jqXHR.responseText +'<p class="error">Error: <b>' + textStatus+'</b></p>');
      }
    });
  },
  errorPlacement: function( error, element ) {
    error.insertAfter( element.parent() );
  }
});

// for contact page, send email
$("#contactForm").validate({
  rules: {
    txtName: {
        required: true,
        minlength: 5,
        maxlength: 50
    },
    email: {
        required: true,
        email: true
    },
    message: {
        required: true,
        minlength: 5,
        maxlength: 1000
    }
  },
  messages: {
    txtName: {
      required: "Please enter a name",
      minlength: "Your name must consist of at least 5 characters",
      maxlength: "Your name must be less than 50 characters long"
    },
    email: "Please enter a valid email address",
    message: {
        required: "Please input the message",
        minlength: "message must be at least 5 characters long",
        maxlength: "message must be less than 1000 characters long"
    }
  },
  submitHandler: function() {
    var v = grecaptcha.getResponse();
    if (v.length == 0){
      $("#contactForm").find("#reCaptcha").after('<label for="reCaptcha" class="error">You must complete the antispam verification</label>');
    } else {
      var data = JSON.stringify($('#contactForm').serializeObject());
      $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: rootURL+"contact",
        dataType: "json",
        data: data,
        success: function(data, textStatus, jqXHR){
          var msg = "";
          if(data !== false){
            alert("Email sent successfully.");
          } else {
            alert("Failed to send email.");
          }
          window.location.href="contact.html";
        },
        error: function(jqXHR, textStatus, errorThrown){
          alert(jqXHR.responseText +"Server error: Failed to send email.");
          window.location.href="contact.html";
        }
      });
      
    }
  },
  errorPlacement: function( error, element ) {
    error.insertAfter( element.parent() );
  }
});

  // for myaccount page
$(document).on("click", "#logoutbtn",function(){
  localStorage.removeItem("uid");
  localStorage.removeItem("username");
  window.location.href="index.html"; // change page with ajax
});

$("#changePwdForm").validate({
  rules: {
    oldpassword: {
      required: true,
      minlength: 5,
      maxlength: 32
    },
    password: {
        required: true,
        minlength: 5,
        maxlength: 32
    },
    password2: {
        required: true,
        equalTo: "#password"
    }
  },
  messages: {
    oldpassword: {
      required: "Please provide a password",
      minlength: "Your password must be at least 5 characters long",
      maxlength: "Your username must be less than 32 characters long"
    },
    password: {
        required: "Please provide a password",
        minlength: "Your password must be at least 5 characters long",
        maxlength: "Your username must be less than 32 characters long"
    },
    password2: {
        required: "Please verify your password",
        equalTo: "Please enter the same password as above"
    }

  },
  submitHandler: function() {
      $.mobile.activePage.find('#changePwdForm').find("input[name='uid']").val(localStorage.uid);
      var data = JSON.stringify($.mobile.activePage.find('#changePwdForm').serializeObject());
      console.log(data);
      $.ajax({
          type: 'POST',
          contentType: 'application/json; charset=utf-8',
          url: rootURL+"changepassword",
          dataType: "json",
          data: data,
          success: function(data, textStatus, jqXHR){
              $("#changePwdForm h3").after('<p class="error"><b>Your password is updated!</b></p>');
          },
          error: function(jqXHR, textStatus, errorThrown){
              $("#changePwdForm h3").after(jqXHR.responseText+'<p class="error">Error: <b>' + textStatus+'</b></p>');
          }
      });
  },
  errorPlacement: function( error, element ) {
    error.insertAfter( element.parent() );
  }
});


    $.fn.serializeObject = function()
    {
       var o = {};
       var a = this.serializeArray();
       $.each(a, function() {
           if (o[this.name]) {
               if (!o[this.name].push) {
                   o[this.name] = [o[this.name]];
               }
               o[this.name].push(this.value || '');
           } else {
               o[this.name] = this.value || '';
           }
       });
       return o;
   };

// if (typeof(Storage) !== "undefined") {
//     console.log("support Storage");
// } else {
//     console.log("not support Storage");
// }
}); 