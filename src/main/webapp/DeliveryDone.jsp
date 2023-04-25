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
			
		    
		   	PreparedStatement inserter = myConn.prepareStatement("INSERT INTO DoneDelivery VALUES (? , ? , ? , ?, ?)");
		   	inserter.setInt(1, Integer.parseInt(request.getParameter("cId")));
		   	inserter.setInt(2, Integer.parseInt(request.getParameter("skId")));
		   	inserter.setInt(3, Integer.parseInt(request.getParameter("itemId")));
		   	inserter.setInt(4, Integer.parseInt(request.getParameter("qtySel")));
		   	inserter.setString(5, request.getParameter("OrderDate"));
		   	
		   	myConn.setAutoCommit(false);
		   	inserter.executeUpdate();
		   	
		   	Statement st = myConn.createStatement();
		    st.executeUpdate("DELETE FROM Orders WHERE itemId = " + request.getParameter("itemId"));
		    ResultSet rs = st.executeQuery("SELECT * FROM Items WHERE itemId = " + request.getParameter("itemId"));
		    rs.next();
		    int qtyPres = rs.getInt("qty");
		    
		    st.executeUpdate("UPDATE Items SET qty = " + (qtyPres - Integer.parseInt(request.getParameter("qtySel"))) + " WHERE itemId = " + request.getParameter("itemId"));
		    
		    myConn.commit(); 
		    
		    response.sendRedirect("SKHomePage");
		}
		catch(SQLException ex){
	        System.err.println(ex.getMessage());
	    } 
	
	%>
</body>
</html>