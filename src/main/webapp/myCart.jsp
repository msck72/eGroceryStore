<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@page import = "java.util.logging.Level" %>
<%@page import = "java.util.logging.Logger" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		if(session.getAttribute("user") == null){
			response.sendRedirect("Login.html");
		}
		
	
		String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	    String user = "root";
	    String password = "Alpha@123";
	    
		try (Connection myConn = DriverManager.getConnection(url, user, password);){
			
		    Statement st = myConn.createStatement();
		    ResultSet rs = st.executeQuery("SELECT itemId FROM Cus_Cart WHERE itemId = " + request.getParameter("itemId") + " AND cId = " + session.getAttribute("cId"));
		    
		    myConn.setAutoCommit(false);
		    
		    if(rs.next()){
		    	st.executeUpdate("UPDATE Cus_Cart SET qty = " + request.getParameter("qty") + " WHERE itemId = " + request.getParameter("itemId") + " AND cId = " + session.getAttribute("cId"));
		    }
		    else{
		    	st.executeUpdate("INSERT INTO Cus_Cart VALUES(" + session.getAttribute("cId") + ","+ request.getParameter("itemId") + "," + request.getParameter("qty")+")");
		    }
		    Statement mySt = myConn.createStatement();
		    ResultSet myRs = mySt.executeQuery("SELECT * FROM Items WHERE itemId = " + request.getParameter("itemId"));
		    myRs.next();
		    int qtyNow =  myRs.getInt("qty");
		    st.executeUpdate("UPDATE Items SET qty = " + (qtyNow - Integer.parseInt(request.getParameter("qty"))) + " WHERE itemId = " + request.getParameter("itemId"));
		    
		    myConn.commit(); 
		    %>
		    
		    <script> alert(`item added to cart`) </script> 
		    <meta http-equiv="Refresh" content="0.5;url=CustomerHomePage.jsp">
		    <%
		}
		catch(SQLException ex){
	        System.err.println(ex.getMessage());
	    } 
		
	%>

</body>
</html>