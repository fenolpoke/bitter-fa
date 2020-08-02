<%@page import="java.util.Date, java.text.SimpleDateFormat"%>
<%@include file="connect.jsp"%>

<%
	//initialization
	int userid=0, id=0;

	//check user logoin
	if(session.getAttribute("username") == null){
		response.sendRedirect("loginRegister.jsp");
		return;
	}else{
		//get user id
		resultSet = statement.executeQuery("SELECT id FROM member WHERE username='"+session.getAttribute("username").toString()+"'");
		resultSet.next();
		userid = resultSet.getInt("id");
		//if user looks another user's profile
		if(request.getParameter("id") != null){
			id = Integer.parseInt(request.getParameter("id").toString());
		}else id = userid;

%>
	<style type="text/css">
		body{
			background: lightblue;
			font-family: leelawadee;
		}
		li{
			width: 12%;
		}
		#searchbar{
			width: 20%;
		}
		ul li, a, input{
			text-decoration: none;
			color: royalblue;
			list-style-type: none;
			display: inline-block;
		}
		.tweet{
			float:left;
		}
		.profile{	
			float: right;
			display: inline;
		}
		.tweet-list input{
			float:left;
			background: none;
			border:none;
		}
		.edit-profile, .edit-profile form table{
			width:100%;
			text-align: center;
		}

	</style>

	<!--Menu bar-->
	<ul>
		<li>Bitter</li>
		<li><%= new SimpleDateFormat("MMM dd, yyyy").format(new Date()) %></li>
		<li><%=application.getAttribute("online")%> online user</li>
		<li id="searchbar">
			<form action="search.jsp" method="POST">
				<input type="text" name="search" placeholder="Search tweets or @user"/>
				<input type="submit" value="Search" />
			</form>		
		</li>
		<li><a href="actions/doLogout.jsp">Logout</a></li>
		<li><a href="home.jsp">Home</a></li>
		<li><a href="profile.jsp">Profile</a></li>
	</ul>


<%
	}
%>