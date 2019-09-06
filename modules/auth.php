<?php

function signup($fname, $lname, $email, $password, $type)
{	
global $db;
	switch($type){
		case 1: 
		$insql = "INSERT INTO users (email, u_type, password) VALUES('$email', '$type', '$password')";
		$inres = $db->prepare($insql);
		$inres->execute();
		$uid = $db->lastInsertId();
		
		$psql = "INSERT INTO player_details (user_id, f_name, l_name) VALUES('$uid', '$fname', '$lname')";
		$pres = $db->prepare($psql);
		$pres->execute();
		$uid = $db->lastInsertId();
		
		$randonval = generateToken();
		$vsql = "INSERT INTO user_verify(user_id, token, expr_time) VALUES('$uid', '$randonval', TIMESTAMPADD(HOUR, 1, NOW()))";
		$vres = $db->prepare($vsql);
		$vres->execute();
		
		//send email
		$msg = "Hello ".$fname.", Welcome to Scout A Champ!<br>
				Your Verification Code is $randonval";
		
		sendMail($email, $username, $msg, 'Verification Email (scoutachamp.com)');
		return $uid;
	break;
		case 2: 
		$insql = "INSERT INTO users (email, u_type, password) VALUES('$email', '$type', '$password')";
		$inres = $db->prepare($insql);
		$inres->execute();
		$uid = $db->lastInsertId();
		
		$psql = "INSERT INTO clubs (user_id, f_name, l_name) VALUES('$uid', '$fname', '$lname')";
		$pres = $db->prepare($psql);
		$pres->execute();
		$uid = $db->lastInsertId();
		
		$randonval = generateToken();
		$vsql = "INSERT INTO user_verify(user_id, token, expr_time) VALUES('$uid', '$randonval', TIMESTAMPADD(HOUR, 1, NOW()))";
		$vres = $db->prepare($vsql);
		$vres->execute();
		
		//send email
		$msg = "Hello ".$fname.", Welcome to Scout A Champ!<br>
				Your Verification Code is $randonval";
		
		sendMail($email, $username, $msg, 'Verification Email (scoutachamp.com)');
		return $uid;
	break;
		case 3: 
		$insql = "INSERT INTO users (email, u_type, password) VALUES('$email', '$type', '$password')";
		$inres = $db->prepare($insql);
		$inres->execute();
		$uid = $db->lastInsertId();
		
		$psql = "INSERT INTO coaches (user_id, f_name, l_name) VALUES('$uid', '$fname', '$lname')";
		$pres = $db->prepare($psql);
		$pres->execute();
		$uid = $db->lastInsertId();
		
		$randonval = generateToken();
		$vsql = "INSERT INTO user_verify(user_id, token, expr_time) VALUES('$uid', '$randonval', TIMESTAMPADD(HOUR, 1, NOW()))";
		$vres = $db->prepare($vsql);
		$vres->execute();
		
		//send email
		$msg = "Hello ".$fname.", Welcome to Scout A Champ!<br>
				Your Verification Code is $randonval";
		
		sendMail($email, $username, $msg, 'Verification Email (scoutachamp.com)');
		return $uid;
	break;
	}
		
}

function validateToken($uid, $token)
{
	global $db;
	$usql = "SELECT * FROM user_verify WHERE user_id = '$uid' AND status = '1'  ";
	$ures = $db->prepare();
	$ures->execute();
	
	$urow = $ures->fetch(PDO::FETCH_ASSOC);
	$rtoken = (int)$urow['token'];
	$rtime = $urow['expr_time'];
	$valtime = strtotime($rtime);
	$currtime = time();
	
	if($currtime > $valtime)
	{
		return 1;
	}
	
	if($token != $rtoken)
	{
		return 2;
	}
	
		
	$nsg = "Hello, Welcome to MarvelEarners";
	
	addNotification($uid, $nsg, 1);
	
	return true;
}

function resendToken($uid)
{
	$token = generateToken();
	$usql = "UPDATE verify SET token = '$token', expr_time = DATE_ADD(now(), INTERVAL 1 HOUR) WHERE user_id = '$uid'";
	$ures = $db->prepare();
	$ures->execute();
	
	//send sms
	
	//send email
}

//logout function
// return true on success
function logout()
{
	global $db;
	if(isset($_SESSION['user']) OR isset($_COOKIE['username']))
	{
		setcookie("username", "", time() - (3600 * 24), "/");
		setcookie("email", "", time() - (3600 * 24), "/");
		setcookie("id", "", time() - (3600 * 24), "/");
		
		session_unset();
		session_destroy();
		return true;
	}
	else
	{
		return true;
	}
}
//login function
//the parameters are post variables $field1 for username or email, $field2 for password, $db is the PDO conection object
//return 1 or 2 for success; 0 for failure
function login($field1, $field2)
{
	global $db;
	$field = $field1;
	$password = $field2;
	
	if((strcmp($field, '') == 0) OR (strcmp($password, '') == 0))
	{
		return 0;
	}
	
	$sql = "";
	$password = OPENSSL::encrypt($password);
	if(filter_var($field, FILTER_VALIDATE_EMAIL))
	{
		$sql = "SELECT * FROM users WHERE email = '$field' AND password = '$password'";
	}
	else
	{
		$sql = "SELECT * FROM users WHERE username = '$field' AND password = '$password'";
	}
	
	$res = $db->prepare($sql);
	$res->execute();
	
	$num = (int)$res->rowCount();
	if($num == 0)
	{
		return false;
	}
	elseif($num == 1)
	{
		$row = $res->fetch(PDO::FETCH_ASSOC);
		$uid = $row['id'];
		$username = $row['username'];
		$email = $row['email'];
		$l_date = date("Y-m-d h:i:s", time());
		
		$upsql = "UPDATE users SET last_login = '$l_date' WHERE id = '$uid'";
		$upres = $db->prepare($upsql);
		$upres->execute();
		
		$retarr = array("id" => $uid, "email" => $email, "username" => $username);
		
		return $retarr;
	}
}

//isLoggedIn function checks if the user is loggedin
//return true is logged in and false if not
function isLoggedIn()
{
	if(isset($_SESSION['user']) OR isset($_COOKIE['username']))
	{
		return true;
	}
	else
	{
		return false;
	}
}


function checkAvailabiity($field, $val)
{
	global $db;
	$sesql = "SELECT id FROM users WHERE $field = '$val'";
	$seres = $db->prepare($sesql);
	$seres->execute();
	
	$senum = (int)$seres->rowCount();
	if($senum == 0)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function getSessionId()
{
	return $_SESSION['user']['id'];
}


function getSessionUsername()
{
	return $_SESSION['user']['username'];
}

function guard()
{
	if(isLoggedIn() == false)
	{
		redirect("../login/?alert=2");
	}
	return true;
}
?>