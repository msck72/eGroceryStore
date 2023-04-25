<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ page import="java.sql.*, java.util.logging.*" %>
<meta charset="UTF-8">
<title>ShopKeeper Validation</title>
</head>
<body>
	
	<% String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    String user = "root";
    String password = "Alpha@123";
    
    session = request.getSession();
    
    try (Connection myConn = DriverManager.getConnection(url, user, password);) {

    	if(request.getParameter("usrType").equals("Customer")){
    		Statement st = myConn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Customer WHERE name = \"" + request.getParameter("usrName") + "\"" + "AND password = \"" + request.getParameter("passwd") + "\"");
            
//            out.println(request.getParameter("usrName") + " " + request.getParameter("passwd"));
//            while(rs.next()) {
//            	out.println(rs.getString("UserName") + " " + rs.getString("Password"));
//            }
            
            if(rs.next()) {
            	session.setAttribute("user", request.getParameter("usrName"));
            	session.setAttribute("cId", rs.getInt("cId"));
            	
            	%><script>alert("login successful")</script>
            	<meta http-equiv="Refresh" content="0.5;url=CustomerHomePage.jsp">
            	<%
            	
            	//response.sendRedirect("CustomerHomePage.jsp");
            	
            }
            else {
            	out.println("<script>alert(`login unsuccessful`)</script>");
            	%><meta http-equiv="Refresh" content="0.5;url=Login.jsp"><%
            	
            }
            
    	}
    	else{
    		Statement st = myConn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM ShopKeeper WHERE name = \"" + request.getParameter("usrName") + "\"" + "AND password = \"" + request.getParameter("passwd") + "\"");
            
//            out.println(request.getParameter("usrName") + " " + request.getParameter("passwd"));
//            while(rs.next()) {
//            	out.println(rs.getString("UserName") + " " + rs.getString("Password"));
//            }
            
            if(rs.next()) {
            	
            	session.setAttribute("user", request.getParameter("usrName"));
            	session.setAttribute("skId" , rs.getInt("skId"));
            	%><script>alert("login successful")</script>
            	<meta http-equiv="Refresh" content="0.5;url=GSHomePage.jsp">
            	<%
            	//response.sendRedirect("GSHomePage.jsp");
            	
            }
            else {
            	out.println("<script>alert(`login unsuccessful`)</script>");
            	%><meta http-equiv="Refresh" content="0.5;url=Login.jsp"><%
            }
            
    	}
    	
    	myConn.close();
    
    }
    catch(SQLException ex) {
    	out.println("JDBC CANNOT BE OPENED");
    } %>
    
</body>
</html>