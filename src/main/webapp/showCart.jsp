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
		
		
			%><%@ include file="Header.jsp"%><br><% 
			int totCost = 0;
			String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		    String user = "root";
		    String password = "Alpha@123";
		    int count = 0;
			try (Connection myConn = DriverManager.getConnection(url, user, password);){
				
			    Statement st = myConn.createStatement();
			    Statement nestedst = myConn.createStatement();
			    
			    ResultSet rs = st.executeQuery("SELECT * FROM Items WHERE itemId IN(SELECT itemId FROM Cus_Cart WHERE cId = " + session.getAttribute("cId") + ")");
			    
			    
			    %>
			<%
			   	while(rs.next()){
			%><div ><%
					count++;
			   		int itemId = rs.getInt("itemId");
					%>
					<img class ="checkOutImage" class="products" src=<%=rs.getString("itemImage") %>><br>
					<b>Item Name</b> :<%=rs.getString("itemName") %><br>
					<br> <b>Item Description</b> :
					<%=rs.getString("itemDesc")%><br>
					<br> <b>Item Price</b> :
					<%=rs.getInt("price")%><br>
			   		
			 
			   		<% 
			   		
				   		ResultSet nestedrs = nestedst.executeQuery("SELECT * FROM Cus_Cart WHERE cId = " + session.getAttribute("cId") + " AND itemId = " + itemId);
				   		nestedrs.next();
			   		
			   		%>
			   		<br><b>Number of items chosen : </b><%= nestedrs.getInt("qty")  %> <br><br>
			   		
			   		<% totCost =  rs.getInt("price") * nestedrs.getInt("qty");%>
			   		<b>Effective Price: </b><%= totCost%>
			   		<br><br>
			   		
			   		<form name="myForm<%out.print(itemId); %>" action="RemFromCart" onsubmit="return Validate(<%out.print(itemId); %>)">
			   		 <input list="number<%out.print(itemId); %>" name="qty" placeholder="0">
				   		
				   		<datalist id="number<%out.print(itemId); %>">
						   	<%	
						   		for(int i = 1; i <= nestedrs.getInt("qty"); i++){						   		
						   			out.println("<option value=\""+ i +"\" >"+ i +"</option>");
						   		}
					   		%>	
				   		</datalist>
				   		<input type="hidden" name="itemId" value=<%out.print(itemId); %> >
				   		<input type="hidden" name="qtyNow" value=<%out.print(nestedrs.getInt("qty")); %> >
				   		<input type="submit" value="Remove from cart">
			   		 </form> 
			   		 </div>
			   		 <hr>
			   		<%
			   		
			   	}
			    
			
			    
			    
			}
			catch(SQLException ex){
		        System.err.println(ex.getMessage());
		    } 
			
			if(count != 0){
			%>
				<div class="nextDivCheckOut">
					 <h2>Total Price: <%= totCost%></h2>
					<form action="checkOut">
					
						<input type="submit" id="checkOut" value="CheckOut">
					</form>
					</div>
				<br><br><br>
			<%
		
			}
			else{
				
				%><br>Cart is Empty
				<img class="products" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmUtL3sdOk6Ap2uvaudKh7X65q5nAlR13Usg&usqp=CAU">
				<%
			}
		
	%>
	
	<div>
			<form  class="nextDivCheckOut" action="PrevOrders.jsp">
				<input id="next" type="submit" value="PrevOrders">
			</form>
		</div>
	
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
