<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %> 
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	    String user = "root";
	    String password = "Alpha@123";
	    
		try (Connection myConn = DriverManager.getConnection(url, user, password);){
			
		    Statement st = myConn.createStatement();
		   	int qty = Integer.parseInt(request.getParameter("qty"));
		   	int qtyNow = Integer.parseInt(request.getParameter("qtyNow"));
		    
		   	myConn.setAutoCommit(false);
		   	
		   	if(qty - qtyNow != 0){
		    	
		    	st.executeUpdate("UPDATE Cus_Cart SET qty = " + "" +  (qtyNow - qty) + "" + " WHERE itemId = " + request.getParameter("itemId"));
		    }
		    else{
		    	
		    	st.executeUpdate("DELETE FROM Cus_Cart WHERE itemId = " + request.getParameter("itemId"));
		    }
		    
		   	
		   	Statement mySt = myConn.createStatement();
		    ResultSet myRs = mySt.executeQuery("SELECT * FROM Items WHERE itemId = " + request.getParameter("itemId"));
		    myRs.next();
		    int qtyAtPres =  myRs.getInt("qty");
		    st.executeUpdate("UPDATE Items SET qty = " + (qtyAtPres + Integer.parseInt(request.getParameter("qty"))) + " WHERE itemId = " + request.getParameter("itemId"));
		   	
		    myConn.commit(); 
		    
		   	%><script>alert(`selected qunatity of items removed from cart`)</script>
		   	<meta http-equiv="Refresh" content="0.5;url=http://localhost:8080/ITLabAssignment/showCart?getCart=cart">
		   	<%
		 
		}
		catch(SQLException ex){
	        System.err.println(ex.getMessage());
	    } 
	
	%>
</body>
</html>