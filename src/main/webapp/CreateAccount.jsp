<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%@ page import="java.sql.*, java.util.*" %>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		boolean flag = false;
		
		String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	    String user = "root";
	    String password = "Alpha@123";
	    
	    try (Connection myConn = DriverManager.getConnection(url, user, password);) {
	
	    	if(request.getParameter("usrType").equals("Customer")){
	    		Statement st = myConn.createStatement();
	            ResultSet rs = st.executeQuery("SELECT * FROM Customer WHERE name = \"" + request.getParameter("usrName") + "\"");
	            
	            if(rs.next()) {		          
	            	%><script>alert("login Unsuccessful username aldready exists")</script>
	            	<meta http-equiv="Refresh" content="0.5;url=Login.jsp">
	            	<%
	            }
	            else {
	            	flag = true;
	            	myConn.setAutoCommit(false);
	            	st.executeUpdate("INSERT INTO Customer(name , password , phno) VALUES(\"" + request.getParameter("usrName") + "\",\"" + request.getParameter("passwd") + "\",\"" + request.getParameter("phno") + "\")");
	            	myConn.commit(); 
	            	out.println("create account successful for customer");
	            }
	            
	    	}
	    	else{
	    		Statement st = myConn.createStatement();
	            ResultSet rs = st.executeQuery("SELECT * FROM ShopKeeper WHERE name = \"" + request.getParameter("usrName") + "\"");
	            
				//out.println(request.getParameter("usrName") + " " + request.getParameter("passwd"));
	            //while(rs.next()) {
	            //	out.println(rs.getString("UserName") + " " + rs.getString("Password"));
	            //}
	            
	            if(rs.next()) {		            	
	            	%><script>alert("login Unsuccessful username aldready exists")</script>
	            	<meta http-equiv="Refresh" content="0.5;url=Login.jsp">
	            	<%
	            }
	            else {
	            	flag = true;
	            	myConn.setAutoCommit(false);
	            	st.executeUpdate("INSERT INTO ShopKeeper(name , password, phno) VALUES(\"" + request.getParameter("usrName") + "\",\"" + request.getParameter("passwd") + "\",\"" + request.getParameter("phno") + "\")");
	            	myConn.commit(); 
	            	out.println("create account successful for ShopKeeper");
	            }
	            
	    	}
	    	
	    	myConn.close();
	    	
	    
	    }
	    catch(SQLException ex) {
	    	out.println("JDBC CANNOT BE OPENED");
	    } 
		
		if(flag){
			request.getRequestDispatcher("/SKV.jsp").forward(request, response);
		}
		
	%>
</body>
</html>