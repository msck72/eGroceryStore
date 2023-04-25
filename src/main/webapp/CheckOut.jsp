<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, java.time.*, java.time.format.DateTimeFormatter" %>
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
	    ResultSet rs = st.executeQuery("SELECT * FROM Cus_Cart WHERE cId = " + session.getAttribute("cId"));
	    Statement toAdd = myConn.createStatement();
	    
	    LocalDate dateObj = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String date = dateObj.format(formatter);
	    
	    
	    myConn.setAutoCommit(false);
	    
	    while(rs.next()){
	    	toAdd.executeUpdate("INSERT INTO Orders VALUES(" + session.getAttribute("cId") + "," + rs.getInt("itemId") + "," +rs.getInt("qty") + ",'" + date + "')");
	    }
	    
	    st.executeUpdate("DELETE FROM Cus_Cart WHERE cId = " + session.getAttribute("cId"));
	    
	    myConn.commit(); 
	    %>
	    
	    <script>
	    	alert(`Order successfull`);
	    </script>
	    
	    <meta http-equiv="Refresh" content="0.5;url=CustomerHomePage.jsp">
	    
	    <%
	    
	}
	catch(SQLException ex) {
		System.err.println(ex.getMessage());
    }   
	
	%>
</body>
</html>