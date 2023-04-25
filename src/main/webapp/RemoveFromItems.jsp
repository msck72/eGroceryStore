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
		   	int qtyNow = Integer.parseInt(request.getParameter("qtyNow"));
		   	
		   	myConn.setAutoCommit(false);
		   	//out.println("UPDATE Items SET qty = " + "" +  qtyNow + "" + " WHERE itemId = " + request.getParameter("itemId"));
		    st.executeUpdate("UPDATE Items SET qty = " + "" +  qtyNow + "" + " WHERE itemId = " + request.getParameter("itemId"));
		    
		    myConn.commit(); 
		    
		    %><script>
	    	alert(`Change was successfull`);
	    	</script>
	    
	    	<meta http-equiv="Refresh" content="0.5;url=SKHomePage">
		    <%
		    //response.sendRedirect("SKHomePage");
		}
		catch(SQLException ex){
	        System.err.println(ex.getMessage());
	    } 
	
	%>
</body>
</html>