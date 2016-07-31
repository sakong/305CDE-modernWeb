-- phpMyAdmin SQL Dump
-- version 4.6.0
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 17, 2016 at 06:25 PM
-- Server version: 5.6.29
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `littlefine_tc01`
--

-- --------------------------------------------------------

--
-- Table structure for table `tc_content`
--

CREATE TABLE `tc_content` (
  `content_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tc_content`
--

INSERT INTO `tc_content` (`content_id`, `type`, `title`, `content`, `created_date`, `updated_date`) VALUES
(2, 'index', 'Beware of Technology Crimes', '<p>As technology is advancing rapidly, computer and information technology have not only brought convenience to citizens in modern life, but also encouraged lawbreakers to take advantage of advanced technology to commit crimes through various modus operandi.  The Cyber Security and Technology Crime Bureau (CSTCB) has been dedicated to fighting technology crime, striving to maintain law and order in cyberspace so as to ensure that Hong Kong remains a digitally safe city.</p>\r\n\r\n    <p>The Hong Kong Police Force is committed to combating technology crime. The Cyber Security and Technology Crime Bureau (CSTCB) is responsible for handling cyber security issues and carrying out technology crime investigations, computer forensic examinations and prevention of technology crime.  CSTCB will also establish close liaison with local and overseas law enforcement agencies for combating cross-border technology crime and experience exchange.</p>\r\n\r\n    <p>The CSTCB web page can help you learn more about information on technology crime.</p>', '2016-07-07 17:05:21', '2016-07-07 09:05:39');

-- --------------------------------------------------------

--
-- Table structure for table `tc_forum`
--

CREATE TABLE `tc_forum` (
  `topicid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tc_forum`
--

INSERT INTO `tc_forum` (`topicid`, `uid`, `category`, `title`, `content`, `created_date`, `updated_date`) VALUES
(4, 1, 'Opinions', 'This is a great website!', 'This is a great website! Awesome!\r\n\r\nIt would be great if you have Traditional Chinese!', '2016-07-17 05:35:13', '2016-07-17 05:35:13'),
(5, 4, 'Questions', 'First questions', 'Answer later.... ', '2016-07-17 08:08:55', '2016-07-17 08:08:55');

-- --------------------------------------------------------

--
-- Table structure for table `tc_forumcomments`
--

CREATE TABLE `tc_forumcomments` (
  `replyid` int(11) NOT NULL,
  `topicid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tc_forumcomments`
--

INSERT INTO `tc_forumcomments` (`replyid`, `topicid`, `uid`, `content`, `created_date`, `updated_date`) VALUES
(11, 4, 1, 'Further to this topic, I would like to say you have provided a very useful platform!', '2016-07-17 05:37:56', '2016-07-17 05:37:56'),
(12, 4, 4, 'Cool! total agree with you!', '2016-07-17 08:25:12', '2016-07-17 08:25:12');

-- --------------------------------------------------------

--
-- Table structure for table `tc_information`
--

CREATE TABLE `tc_information` (
  `information_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tc_information`
--

INSERT INTO `tc_information` (`information_id`, `title`, `content`, `status`, `created_date`, `updated_date`) VALUES
(1, 'E-Banking Fraud ', '<p>In recent years, some  culprits send suspicious emails to victims to induce them to open the  attachments contained.&nbsp; When the files  are opened, the victims’ computers are infected by malicious programmes.</p>\r\n                      <p>When the victims log  in their online banking accounts on the Internet, fraudsters will make use of  computer technology to display a series of bogus web page interfaces on victims’  computers that entice the victims to input important information (such as login  name, password and one-time password issued by a security device).&nbsp; </p>\r\n                      <p>Then the fraudsters  will use the above gathered information (including one-time password) to  complete the double authentication process, and cheat money out of the victims  through online banking transfers.</p>\r\n                      <p><strong>The Police appeal  to the public:</strong></p>\r\n                      <p>                        Users of the  Internet should stay alert whenever they are using computers so as to prevent  from being infected by virus or any other malicious programmes.&nbsp; If the website of the bank seems suspicious  in any way, or if there is any abnormality when you log in the web page, then  no data should be entered (including user name, password and one-time  password).&nbsp; Users should contact the bank  immediately.&nbsp; </p>\r\n                      <p>Furthermore, users  of the Internet should install in their personal computers anti-virus software  and personal firewalls, and update them from time to time for receiving the  latest warning on viruses.&nbsp; Users should  also build up the following good habits:</p>\r\n                      <ul>\r\n<li>Never open any attachment of unidentified emails, and avoid logging  in suspicious website or download from which any software.</li>\r\n                        <li>Do not log in online services (such as e-banking) via hyperlinks  attached in emails, online search engines, suspicious pop-up windows or other  suspicious channels.&nbsp; Input the genuine  network address of the bank in the address box at the top of the browser or  record the network address at the Bookmark of the browser to link to the bank  website. </li>\r\n                        <li>Do not tell anyone your login password or one-time password through  email, telephone or in person.</li>\r\n                        <li>Check transactions in accounts regularly and the details of  transactions in notifications from banks (such as short messages sent through  mobile phones).&nbsp; Once any suspicious  transaction of bank accounts or web page is identified, the bank should be  notified immediately.</li>\r\n                        <li>Follow the security instructions given by the bank when online  banking transactions are made.</li>\r\n                      </ul>\r\n', 'active', '2016-07-07 17:03:00', '0000-00-00 00:00:00'),
(2, 'Social Media Deception', '<p><b>How does it work?</b></p>\r\n<p>Examples:</p>\r\n	<ol>\r\n		<li><p>Swindlers logged in social media accounts with login names or email addresses and passwords acquired by illegal means.  They then posed as the users of these accounts and sent deceptive messages to the users’ friends on the contact lists, requesting them to buy virtual point cards or reload cards on their behalf.  They also asked for the serial numbers/authorization codes and passwords on the cards, and then could not be reached after getting such information.</p></li>\r\n		<li><p>The victim befriended someone (the swindler) online via a social medium and was asked to meet each other in person.  When they met, the swindler made up various reasons to borrow the smartphone from the victim and then fled.</p></li>\r\n		<li><p>The victim met a female (the swindler) online via a social medium.  When the victim asked her out, the female swindler asked for a deposit as a guarantee of her personal safety.  Swindlers mostly asked victims to buy online game virtual point cards or reload cards, obtained the serial numbers/authorization codes and the passwords as guarantees, and could not be contacted thereafter.</p></li>\r\n	</ol>\r\n<p><b>What is our advice?</b></p>\r\n	<ul>\r\n		<li><p>Do not casually open emails, attachments and links from unknown sources, so as to avoid being infected by malicious software (malware) that can be used to steal your email passwords and other information.</p></li>\r\n		<li><p>Avoid using the same password in different social media or platforms.</p></li>\r\n		<li><p>Set proper passwords and change passwords regularly.</p></li>\r\n		<li><p>Change the default password set for you by a social medium, such as the personal identification number (PIN) for carrying over your social media account to a new smartphone.</p></li>\r\n		<li><p>Keep your smartphone’s operation system and applications (apps) up-to-date.  Update your social media apps as well.</p></li>\r\n		<li><p>If you receive any request via social media for money transactions or buying virtual point cards or reload cards, verify the identity of the sender and the validity of the request.</p></li>\r\n		<li><p>Remember to be cautious when making friends via social media, and remain vigilant at any time.</p></li>\r\n	</ul>\r\n', 'active', '2016-07-07 17:03:00', '0000-00-00 00:00:00'),
(3, 'Email Scam ', '<p>Nowadays, email is a common form of communication channel for liaising  with relatives and friends as well as commercial partners. &nbsp;Culprits would hack email accounts and cheat victims  by all possible means to make remittances. &nbsp;Some victims have suffered significant amount  of losses in some cases. &nbsp;&nbsp;Here are some common  scenarios:</p>\r\n                      <p><strong>Example 1 (Corporate level): “Change of supplier bank details”</strong> <br>\r\n                        Fraudsters knew from stolen emails about the transactions of Company A  (the seller, the consignor) and Company B (the buyer, the paying company).&nbsp; Later, fraudsters, pretending to be Company  A, sent fictitious emails (which are very similar to genuine emails) to Company  B, claiming that the email address and payment receiving bank account number  have changed, and requesting Company B to credit the amount payable to the  designated account. &nbsp;Afterwards, when  contacting Company A by phone, Company B found out that it had been deceived by  fictitious emails and suffered losses both in money and business reputation.</p>\r\n                      <p><strong>Example 2 (Personal level): “Overseas relatives/ friends  need immediate money remittance”</strong><br>\r\n                        After hacking into a personal email account, fraudsters sent out  deceptive emails to all persons on the contact list of the account. &nbsp;The email defrauded that the sender had  encountered an accident overseas and requested the victims to transfer money to  accounts designated by the fraudsters as a matter of emergency. &nbsp;Some victims made the remittance without  further verification and only realised that they had been cheated when  contacting their relatives or friends.</p>\r\n                      <p><strong>Police appeal:</strong><br>\r\n                        The Police call on all members of the public to be alert of suspicious  emails, and raise their awareness in preventing this kind of scam, such as  taking the initiative to confirm the true identities of recipients or the  genuineness of the requests by telephone, facsimile or other means before  remittances, so as to prevent such kind of scam.</p>\r\n                      <p><strong>IT security tips to prevent hacking:</strong></p>\r\n                      <table class="table_01" border="1" cellpadding="0" cellspacing="0">\r\n<tbody><tr>\r\n<th valign="top" width="50%">Email and password security </th>\r\n                          <th valign="top" width="50%">Computer system security</th>\r\n                        </tr>\r\n<tr>\r\n<td valign="top"><ul>\r\n<li>Safeguard personal data, including　personal and commercial email accounts to    prevent from being stolen by culprits; </li>\r\n                            <li>Do not use computers in public places to    access personal email box, use instant messaging software and e-banking, or    carry out other operations involving sensitive data;</li>\r\n                            <li>Set proper passwords and change them    regularly;</li>\r\n                            <li>Do not open emails of dubious origins;</li>\r\n                            <li>Do not download attachments of suspicious    origin or nature;</li>\r\n                            <li>Use anti-virus software to scan for virus    before opening attachments.</li>\r\n                          </ul></td>\r\n                          <td valign="top"><ul>\r\n<li>Use    genuine software;</li>\r\n                            <li>Update    software with patches provided by software developers;</li>\r\n                            <li>Install    and turn on firewall and intrusion detection system;</li>\r\n                            <li>Update    virus and spyware definition files;</li>\r\n                            <li>Use    anti-virus software to scan computers regularly;</li>\r\n                            <li>Do not    download software of suspicious origin or nature;</li>\r\n                            <li>Protect    wireless networks.</li>\r\n                          </ul></td>\r\n                        </tr>\r\n</tbody></table>\r\n', 'active', '2016-07-07 17:03:00', '0000-00-00 00:00:00'),
(4, 'Social Networking Traps ', '<p>As technology is advancing rapidly, computer and information  technology have brought convenience to the community by allowing people from  all walks of life and different age groups to obtain information from the  Internet and have closer liaison with friends and relatives.&nbsp; While the use of the Internet by young people  and children is increasingly common, they will have contact with the people  they know by emails, social networking websites and messaging software as well  as making friends online by these means.</p>\r\n                      <p>In recent years, swindlers use online social networking as a pretext  for committing crimes such as rape, indecent assault, criminal intimidation,  theft and fraud.</p>\r\n                      <p>The modus operandi of this type of cases emerges invarious forms.</p>\r\n                      <p>Example  (1) The female victim met a male online friend on social networking  platform.&nbsp; Later on, they became online  friends and even lovers.&nbsp; The male made  use of the relationship to borrow money from the victim with different excuses  and then flee.</p>\r\n                      <p>Example  (2) There was also a woman who was induced into going out with a male online  friend.&nbsp; The man borrowed the smart phone  from the victim by claiming that his phone was out of battery, then taking an  opportunity, the man ran away.</p>\r\n                      <p>Example  (3)&nbsp; A teenage girl sent her naked photo  to a male online friend, believing he is a female doctor who would use the  photo for medical use.&nbsp; Later on, the  girl was threatened to have sex with the man or the naked photo would be made  public.</p>\r\n                      <p>Example  (4)&nbsp; There was a female being blackmailed  as she exposed her body in response to the request of a new friend in an online  chat.</p>\r\n                      <p>Example (5)&nbsp; The  female online friend (the swindler) asked for guarantee money to ensure her  personal safety when the male (the victim) suggested going out together with  the female whom he met online.&nbsp; Swindlers  mostly asked victims to purchase online game token card and obtained the serial  number and password as guarantee.&nbsp; After  getting the serial number and the password, the swindlers then disappeared. </p>\r\n                      <p><strong>The Police appeal to the public:</strong></p>\r\n                      <ul>\r\n<li>Bear in mind that it is unsafe to make friends via the  Internet.&nbsp; Online friends are only for  chatting in the cyber world;</li>\r\n                        <li>Don’t go out with strangers you know online without concern;</li>\r\n                        <li>Don’t disclose personal information and photos on the Internet  causally;</li>\r\n                        <li>Don’t respond to inappropriate requests from strangers whom you met  online, such as borrowing money, meeting in private places or sending personal  photos of a private nature;</li>\r\n                        <li>Set up Internet privacy control to protect personal information.</li>\r\n                      </ul>\r\n', 'active', '2016-07-07 17:03:00', '0000-00-00 00:00:00'),
(5, 'Online Naked Chat Blackmail ', '<p>As technology is advancing rapidly,  computer and information technology have brought convenience to the public,  facilitating people from all walks of life and different age groups to obtain  information and make contact with friends and relatives on the Internet. &nbsp;It is increasingly common for the public to  use the Internet on which they connect with people they know by emails, social  networking websites and messaging software.&nbsp;  Also, the public would make new friends online by these means.</p>\r\n                      <p>In  recent years, there are swindlers approaching victims on the Internet through  social networking platforms or instant messaging software in the name of  ‘making friends’. &nbsp;The swindlers would  then induce the victims to be naked or make some indecent exposures in front of  network cameras.&nbsp; Later on, the swindlers  would claim that they have the video clips of the victims’ naked bodies on hand  and blackmail the victims into remitting money to a foreign bank account;  otherwise they would upload the video clips to the Internet. </p>\r\n                      <p>The Police appeal to the  public of the following:</p>\r\n                      <p>When you make friends  on the Internet, remember to adopt a prudent attitude to avoid falling into the  traps set by culprits and thus incurring losses: “Don’t trust people in the  cyber world; Be vigilant when meeting new friends”.&nbsp; Anyone who blackmails on the Internet may  have committed “Blackmail” and shall be liable on conviction to a maximum  penalty of imprisonment for 14 years.</p>\r\n', 'active', '2016-07-07 17:03:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tc_setting`
--

CREATE TABLE `tc_setting` (
  `setting_id` int(11) NOT NULL,
  `key` varchar(200) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tc_setting`
--

INSERT INTO `tc_setting` (`setting_id`, `key`, `value`) VALUES
(1, 'site_title', 'Technology Fraud'),
(2, 'site_email', 'blingblingthree@outlook.com'),
(3, 'text_home', 'Home'),
(4, 'text_information', 'Information'),
(5, 'text_forum', 'Forum'),
(6, 'text_quiz', 'Quiz'),
(7, 'text_contact', 'Contact');

-- --------------------------------------------------------

--
-- Table structure for table `tc_users`
--

CREATE TABLE `tc_users` (
  `userid` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `fav` text,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tc_users`
--

INSERT INTO `tc_users` (`userid`, `username`, `email`, `password`, `code`, `fav`, `created_date`, `updated_date`) VALUES
(1, 'user1', 'sdf@sdg.com', '827ccb0eea8a706c4c34a16891f84e7b', '0', '["2","3"]', '2016-07-11 15:14:37', '2016-07-17 05:31:52'),
(2, 'user2', 'sdf@sdg.com', '827ccb0eea8a706c4c34a16891f84e7b', '0', NULL, '2016-07-11 15:14:37', '2016-07-17 05:31:52'),
(3, 'user3', 'test3@test3.com', '827ccb0eea8a706c4c34a16891f84e7b', '4ii1xQTJht', NULL, '2016-07-16 19:54:32', '2016-07-17 05:31:52'),
(4, 'user4', 'user@user.com', '827ccb0eea8a706c4c34a16891f84e7b', '8a7XPVZuME', '["1"]', '2016-07-17 15:28:53', '2016-07-17 08:31:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tc_content`
--
ALTER TABLE `tc_content`
  ADD PRIMARY KEY (`content_id`);

--
-- Indexes for table `tc_forum`
--
ALTER TABLE `tc_forum`
  ADD PRIMARY KEY (`topicid`);

--
-- Indexes for table `tc_forumcomments`
--
ALTER TABLE `tc_forumcomments`
  ADD PRIMARY KEY (`replyid`),
  ADD KEY `topicid` (`topicid`);

--
-- Indexes for table `tc_information`
--
ALTER TABLE `tc_information`
  ADD PRIMARY KEY (`information_id`);

--
-- Indexes for table `tc_setting`
--
ALTER TABLE `tc_setting`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `tc_users`
--
ALTER TABLE `tc_users`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tc_content`
--
ALTER TABLE `tc_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tc_forum`
--
ALTER TABLE `tc_forum`
  MODIFY `topicid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tc_forumcomments`
--
ALTER TABLE `tc_forumcomments`
  MODIFY `replyid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `tc_information`
--
ALTER TABLE `tc_information`
  MODIFY `information_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tc_setting`
--
ALTER TABLE `tc_setting`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tc_users`
--
ALTER TABLE `tc_users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `tc_forumcomments`
--
ALTER TABLE `tc_forumcomments`
  ADD CONSTRAINT `comment` FOREIGN KEY (`topicid`) REFERENCES `tc_forum` (`topicid`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
