<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>

<%@ include file="Header.jsp"%>

<meta charset="UTF-8">
	<link rel="stylesheet" href="myStyles.css">
<title>Insert title here</title>
</head>
<body Class="NotHeaderBody">

	<%
		String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	    String user = "root";
	    String password = "Alpha@123";
	    
		try (Connection myConn = DriverManager.getConnection(url, user, password);){
			
			String search;
			if(request.getParameter("search") == null){
				search = "";
			}
			else{
				search = "WHERE itemName LIKE '%" +  request.getParameter("search") + "%'";
			}
			
			int pages = 10;
			int start = 0;
			if(request.getParameter("view") != null){
				pages = Integer.parseInt(request.getParameter("view"));
			}
			if(request.getParameter("start") != null){
				pages = Integer.parseInt(request.getParameter("view"));
				start = Integer.parseInt(request.getParameter("start"));
			}
			String toLimit = "LIMIT " + pages + " OFFSET " + start;
			//out.println(pages + " " + start);
		    Statement st = myConn.createStatement();
		    
		    ResultSet rs = st.executeQuery("SELECT * FROM Items " + search + " " + toLimit);
		    //int i = 0;
		
		%>
		<br>
		<div class="searchPage">
			<div>
				
				<form>
					<input type="text" name="search" placeHolder="Search" style="width: 80%">
					<input type="submit" value="Search">
				</form>
			</div>
			<div>
			
				<form name="myForm" onsubmit="return Validate()">
					
					Items per page?: <input list="view" name="view" value=<% out.print(pages); %>>
					<datalist id ="view">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="20">20</option>
					</datalist>
					<input type="submit" value="get">
				</form>
			</div>
		</div>
	<div class="custContainer">
		<%
			 while(rs.next()){
			%><div class="items">
			<%
				
			   		int itemId = rs.getInt("itemId");
					int qtyAvlbl = rs.getInt("qty"); 
					%>
			<img class="products" src=<%=rs.getString("itemImage") %>><br>
			<b>Item Name</b> :
			<%=rs.getString("itemName") %><br>
			<br> <b>Item Description</b> :
			<%=rs.getString("itemDesc")%><br>
			<br> <b>Item Price</b> :
			<%=rs.getInt("price")%><br>
			<br> <b>Quantity Available</b> :
			<%=qtyAvlbl%><br>
			<br>


			<form action="myCart">


				<select id="number<%out.print(itemId); %>" name="qty" placeholder="0">
					<%for(int i = 1; i <= qtyAvlbl; i++){
					   		
					   			out.println("<option value=\""+ i +"\" >"+ i +"</option>");
					   		
					   	}
					%>
				</select>
				<input type="hidden" name="itemId" value=<%out.print(itemId); %>>
				<input type="submit" value="AddToCart">
			</form>
		</div>
		
		<%
			   		
			   	}
			
		%>
		</div>
		
		<div>
			<form  class="nextDivCheckOut" >
				<input type="hidden" name="start" value=<%out.print(start + pages); %>>
				<input type="hidden" name="view" value=<%out.print(pages); %>>
				<input id="next" type="submit" value="Next">
			</form>
		</div>
		<%
			}catch(SQLException ex) {
		    	out.println("JDBC CANNOT BE OPENED");
		    }
		
		%>

	
	<br><br><br>

</body>

<script type="text/javascript">
	function Validate(){
		//alert("Hi");
		var view = document.forms["myForm"]["view"].value;
		if(view == ""){
			alert("Enter all fields");
			return false;
		}	
		if(isNaN(view)){
			alert("Only numbers are allowed");
			return false;
		}
		if(view < 0){
			alert("Only positive numbers are allowed");
			return false;
		}
		return true;
	}


</script>
<%@ include file="Footer.jsp"%>
</html>