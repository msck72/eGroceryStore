<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>

<head>
	<link rel="stylesheet" href="myStyles.css">	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body id="cartBody">
	<%
		
		
			%><%@ include file="Header.jsp"%><br>
			
			
			<div>
				
				<form>
					From date: <input type="text" name="from">
					To date: <input type="text" name="to">
					<input type="submit" value="Search">
				</form>
			</div>
			
			
		
			
			<% 
			int totCost = 0;
			String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		    String user = "root";
		    String password = "Alpha@123";
		    int count = 0;
		    
		    
		    
			try (Connection myConn = DriverManager.getConnection(url, user, password);){
				
			    Statement st = myConn.createStatement();
			  
			   String search = "";
			   if(request.getParameter("from") != null && request.getParameter("to") != null){
				   search = "AND OrderDate BETWEEN '" + request.getParameter("from") + "' AND '" + request.getParameter("to") + "'";
			   }
			   //out.println("SELECT cId , OrderDate, Items.itemImage ,Items.itemName, Items.itemId, DoneDelivery.qty FROM DoneDelivery INNER JOIN Items ON Items.itemId = DoneDelivery.itemId AND cId = " + session.getAttribute("cId") + " " + search);
			    ResultSet rs = st.executeQuery("SELECT cId , OrderDate, Items.itemImage ,Items.itemName, Items.itemId, DoneDelivery.qty FROM DoneDelivery INNER JOIN Items ON Items.itemId = DoneDelivery.itemId AND cId = " + session.getAttribute("cId") + " " + search);
			    
			    
			    %>
			<%
			   	while(rs.next()){
			%><div >
					
					<img class ="checkOutImage" class="products" src=<%=rs.getString("itemImage") %>><br>
					<b>Item Name</b> :<%=rs.getString("itemName") %><br>
					<br> <b>OrderDate</b> :
					<%=rs.getString("OrderDate")%><br>
			   		<br><br><br>
			   		<br><br><br>
			   		 <hr>
			   		<%
			   		
			   	}
			    
			    
			}
			catch(SQLException ex){
		        System.err.println(ex.getMessage());
		    } 
			
		
	%>
	
	
	
</body>

<script type="text/javascript">
	function Validate(num){
		//alert("Hi");
		var qty = document.forms["myForm" + num]["qty"].value;
		if(qty == ""){
			alert("Enter all fields");
			return false;
		}	
		if(isNaN(qty)){
			alert("Only numbers are allowed");
			return false;
		}
		if(qty < 0){
			alert("Only positive numbers are allowed");
			return false;
		}
		return true;
	}


</script>

</html>
<%@ include file="Footer.jsp" %>
