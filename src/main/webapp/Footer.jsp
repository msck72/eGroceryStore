<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

.myFoot {
	
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
  	background-color: #003399;
  	overflow: hidden;
 	height: auto;
}

.myFoot a {
  float: right;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.myFoot a:hover {
  background-color: #ddd;
  color: black;
}

.myFoot a.active {
  background-color: #04AA6D;
  color: white;
}

html{
	height: 100%;
	width: 100%;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="myFoot">
	  <a href="#home">About Us</a>
	  <a href="#news">Follow Us</a>
	  <a href="#contact">Contact</a>
	  <a href="#about">Support Us</a>
	</div>
</body>
</html>



<!-- <!DOCTYPE html>
<html>
	<head>
		<title>Position a div at bottom</title>
		<style>
			
			.sub_div {
				position: absolute;
				bottom: 0px;
			}
			
		</style>
	</head>
	<body>
		
			<h1>GeeksforGeeks</h1>
			<div class="sub_div">
				A computer science portal for geeks
			</div>
		
	</body>
</html>			
-->