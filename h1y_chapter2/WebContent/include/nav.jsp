<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
   	<div class="navbar-nav left">
   		<a class="navbar-brand" href="#">B O A R D</a>
   	</div>
    <div class="collapse navbar-collapse justify-content-md-center" id="navbarNavAltMarkup">
    	<a class="navbar-brand" href="#">Board</a>
    	<div class="navbar-nav center">
        	<a class="nav-link" aria-current="page" href="/board/board_list.jsp">List</a>
        	<a class="nav-link" href="/board/board_modify.jsp?IUD=I">Writing</a>
       		<!--  <a class="nav-link active" href="#">Pricing</a>
        	<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a> -->
      	</div>
      	<a class="navbar-brand" href="#" style="margin-left: 50px;">Member</a>
      	<div class="navbar-nav center">
      	<% 
      	if ( session.getAttribute("login_Id") == null ) {
      	%>
      		<a class="nav-link" aria-current="page" href="/member/member_login.jsp">Login</a>
        	<a class="nav-link" href="/member/member_join.jsp">Join</a>
      	<%
      	} else {
      	%>
      		<a class="nav-link" aria-current="page" href="/member/member_login_action.jsp?IO=O">Logout</a>
      	<%
      	}
      	%>
      	</div>
    </div>
    <div class="navbar-nav right">
   	<%
   	if ( session.getAttribute("login_Id") != null ) {
   	%>
    	<a class="navbar-brand" href="#">( <%= session.getAttribute("login_auth").equals("normal") ? "Normal" : "Admin" %> ) <%= session.getAttribute("login_Id") %></a>
   	<%
   	} else {
   	%>
   		<a class="navbar-brand" href="#">Login ID</a>
   	<%
   	}
   	%>
   	</div>
  </div>
</nav>