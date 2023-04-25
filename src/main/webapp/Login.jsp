<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="Header.jsp"%>
<!DOCTYPE html>
<html class="myhtml">
<head>
<link rel="stylesheet" href="myStyles.css">
<meta charset="UTF-8">
<title>User Login Page</title>
</head>
<body class = "mybody">
	<div class="container">
		<div class="box">
			<p>
			<h2>Existing User??</h2>
			<form name="myForm" action="UserValidation" onsubmit="return ValidateLog()">
				UserName : <input type="text" name="usrName" value=""><br> <br>
				Password : <input type="password" name="passwd"><br> <br>
				Type of User?? <br> <br> Customer : <input type="radio"
					name="usrType" value="Customer"> ShopKeeper : <input
					type="radio" name="usrType" value="ShopKeeper"><br> <br>
				<input type="submit" value="Log In"><br> <br>
			</form>
			<button onclick="newUser()">Sign Up</button>
			</p>
		</div>
	</div>

</body>

<script>
	
	function newUser(){
		
		
		document.getElementsByClassName("box")[0].innerHTML = `<h2>New to GrocStore??</h2>
			<form name="RegForm" action="CreateAccount" onsubmit="return ValidateReg()">
			Set your UserName <br><br>
			UserName : <input type="text" name="usrName" id="usrName"><br><br>
			Set your Password <br><br>
			Password : <input type="password" name="passwd" id="passwd"><br><br>
			Phone no. : <input type="text" name="phno" id="phno"><br><br>
			Type of User ? <br><br>
			Customer : <input type="radio" name="usrType" value="Customer">
			ShopKeeper : <input type="radio" name="usrType" value="ShopKeeper"><br><br>
			<input type="submit" value="Create Account"><br><br>
		</form>`;
	}
	
	function ValidateLog(){
		//alert("Hi");
		var usrName = document.forms["myForm"]["usrName"].value;
		var passwd = document.forms["myForm"]["passwd"].value;
		var type = document.forms["myForm"]["usrType"].value;
		if(usrName == "" || passwd == "" || type == ""){
			alert("Enter all fields");
			return false;
		}		
		return true;
	}
	
	
	function ValidateReg(){
		var usrName = document.forms["RegForm"]["usrName"].value;
		var passwd = document.forms["RegForm"]["passwd"].value;
		var phno = document.forms["RegForm"]["phno"].value;
		var type = document.forms["RegForm"]["usrType"].value;
		if(usrName == "" || passwd == "" || phno == "" || type == ""){
			alert("Enter all fields");
			return false;
		}		
		return true;
	}

</script>

<%@ include file="Footer.jsp"%>
</html>



