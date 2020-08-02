<%
	//Check if user logon
	if(session.getAttribute("username") != null){
		response.sendRedirect("home.jsp");
	}
%>
<style type="text/css">
	body{
		background: lightblue;
		font-family: leelawadee;
	}
	.loginRegister{	
		float:right;
		margin-top: -9%;
		display: block;
	}
	.loginRegister table{
		width: 100%;
		text-align: right;
	}
	.banner{
		font-size: 1.2em;
	}
</style>