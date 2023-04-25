<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="myStyles.css">
<%@ page import="java.sql.*" %>
<%@ include file="Header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="NotHeaderBody">
	<%		
		if(session.getAttribute("user") == null){
			response.sendRedirect("Login.jsp");
		}
	
	%>
		<br>
		You got the following orders from customers:
		
		<table class="displayItems">
		<tr>
			<th>Item Id</th>
			<th>Item Name</th>
			<th>Item Desc</th>
			<th>By Customer</th>
			<th>Qty Req</th>
			<th>Eff Price</th>
			<th>Delivery ???</th>
		</tr>
	<%	
	
		String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	    String user = "root";
	    String password = "Alpha@123";
	    
		try (Connection myConn = DriverManager.getConnection(url, user, password);){
			
			
		    Statement st = myConn.createStatement();
		    //System.out.println("SELECT * FROM Items WHERE itemId IN(SELECT itemId FROM Cus_Cart WHERE skId = " + (int)session.getAttribute("skId") + ");");
			ResultSet rs = st.executeQuery("SELECT skId , cId , OrderDate , Orders.itemId AS itemId , Orders.qty AS qtySel, itemName, itemDesc , Orders.qty * price AS effPrice FROM Orders INNER JOIN Items ON Orders.itemId = Items.itemId WHERE skId = " + session.getAttribute("skId"));
			int effTotalPrice = 0;
			while(rs.next()){
				effTotalPrice += rs.getInt("effPrice");
			%>
		<tr>
				<td> <%= rs.getInt("itemId")%> </td>
				<td> <%= rs.getString("itemName")%> </td>
				<td>  <%= rs.getString("itemDesc")%> </td>
				<td> <%= rs.getInt("cId")%> </td>
				<td>  <%= rs.getInt("qtySel")%> </td>
				<td> <%= rs.getInt("effPrice")%> </td>
				<td>
					<form action="DeliveryDone">
						<input type="hidden" name = "itemId" value= <%= rs.getInt("itemId")%>>
						<input type="hidden" name = "cId" value= <%= rs.getInt("cId")%>>
						<input type="hidden" name = "skId" value= <%= rs.getInt("skId")%>>
						<input type="hidden" name = "qtySel" value= <%= rs.getInt("qtySel")%>>
						<input type="hidden" name = "OrderDate" value= <%= rs.getString("OrderDate")%>>
						<input type="submit" value="Done ???" >
					</form>
				</td>
		
		</tr>
			<%	
				}
			
			%>
		</table><br>
		<h3 style="text-align: center;">You Sell the following Items:</h3>
			<%
			//out.println("Total Profit if orders done : " + effTotalPrice + "<br>");
			
			Statement mySt = myConn.createStatement();
			ResultSet myRs = mySt.executeQuery("SELECT * FROM Items WHERE skId = " + session.getAttribute("skId"));
			while(myRs.next()){
				%>
					<div>
						<img class ="checkOutImage" class="products" src=<%=myRs.getString("itemImage") %>><br>
						<b>Item Name</b> :<%=myRs.getString("itemName") %><br><br> 
						<b>Item Description</b> :
						<%=myRs.getString("itemDesc")%><br> <br> 
						<b>Item quantity: </b> :
						<%= myRs.getInt("qty") %> <br> <br> 
						<b>Item Price</b> :
						<%=myRs.getInt("price")%><br>
						
						<form name="myForm<%=myRs.getString("itemId")%>" action="RemoveFromItems" onsubmit="return Validate(<%=myRs.getString("itemId")%>)">
							<h4>Update existing items Quantity??</h4>
							<input type="text" name = "qtyNow">
							<input type="hidden" name="itemId" value=<%= myRs.getInt("itemId")%> >
							<input type="hidden" name="itemId" value=<%= myRs.getInt("qty")%> >
							<input type="submit" value="change">
						</form>
					</div>
					<hr>
				<%
			}
			
			
		}
		catch(SQLException ex) {
	    	out.println("JDBC CANNOT BE OPENED");
	    }
		
		if(request.getParameter("submit") != null){
		    
			try (Connection myConn = DriverManager.getConnection(url, user, password);) {
				
				//ResultSet rs = st.executeQuery("SELECT * FROM ShopKeeper WHERE skId = ");
	            PreparedStatement inserter = myConn.prepareStatement("INSERT INTO Items(skId, itemName, itemDesc, qty , price, itemImage) VALUES(? , ? , ? , ? , ? , ?)"); 
	            
	            inserter.setInt(1, (int)session.getAttribute("skId"));
	            inserter.setString(2 , request.getParameter("itemName"));
	            inserter.setString(3, request.getParameter("itemDesc"));
	            inserter.setInt(4, Integer.parseInt(request.getParameter("qty")));
	            inserter.setInt(5, Integer.parseInt(request.getParameter("price")));
	            inserter.setString(6, request.getParameter("itemImage"));
	            inserter.executeUpdate();
	            myConn.close();
			}
			catch(SQLException ex){
		        System.err.println(ex.getMessage());
		    }
		}
		
		%><%
		out.println(".");
		
	%>
	<h2 class="Ask" style="text-align: center;">Want to add items??</h2>
	<form name="itemsForm" action="SKHomePage" onsubmit="return ValidateItems()">
		<table>
			<tr><th>Item Name : </th><td><input type="text" name="itemName" id="itemName"></td></tr>
			<tr><th>Item Description : </th><td><input type="text" name="itemDesc"></td></tr>
			<tr><th>Quantity : </th><td><input type="text" name="qty"></td></tr>
			<tr><th>Price :</th><td><input type="text" name="price"></td></tr>
			<tr><th>Image URL :</th><td><input type="text" name="itemImage"></td></tr>
			
		</table>
		
		<br><input type="submit" name="submit" value="Add Item"> 
	</form>
	<br><br><br>
	
</body>

<script type="text/javascript">
	function Validate(num){
		//alert("Hi");
		var qty = document.forms["myForm" + num]["qtyNow"].value;
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
	
	function ValidateItems(){
		alert(`${document.forms["itemsForm"]["itemName"].value}`);
		var itemName = document.forms["itemsForm"]["itemName"].value;
		var itemDesc = document.forms["itemsForm"]["itemDesc"].value;
		var qty = document.forms["itemsForm"]["qty"].value;
		var price = document.forms["itemsForm"]["price"].value;
		var image = document.forms["itemsForm"]["image"].value;
		
		if(itemName == "" || itemDesc == "" || qty == "" || price == "" || image == ""){
			alert("Enter all fields");
			return false;
		}	
		if(isNaN(qty) || isNaN(price)){
			alert("Only numbers are allowed for qty and price");
			return false;
		}
		if(qty < 0 || price < 0){
			alert("Only positive numbers are allowed for qty and price");
			return false;
		}
		return true;
	}


</script>

</html>

<%@ include file="Footer.jsp"%>