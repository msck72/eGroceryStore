<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<style>
		.logOut{
		
			position: relative;
		}
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(request.getParameter("logout") != null){
			session.invalidate();
			response.sendRedirect("Login.jsp");
		}
	%>
	<form class="logOut" action="LogOut">
		<input type="submit" name="logout" value="logout" onclick="">
	</form>
	
</body>
</html>