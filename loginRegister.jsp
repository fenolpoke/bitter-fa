<%@ include file="headerGuest.jsp"%>

<title>Bitter - Login / Register</title>

<div class="banner">
	<!--Banner-->
	<p>
		<h3>Welcome to Bitter</h3>

		Connect with your friends in the most fascinating way possible.
		<br>
		Ever wanted to passive-aggresively saying what's in your mind
		<br>
		about someone else, but don't have the courage to say it? just
		<br>
		bite it!
	</p>
</div>
<%
	//Check cookie
	String username = "";
	for(Cookie cookie : request.getCookies()){
		if(cookie.getName().toString().equals("username")){
			username = cookie.getValue();
		}
	}	

%>

<div class="loginRegister">
	<div class="login">	
		<!--Login Form-->
		<form action="actions/doLogin.jsp" method="GET">
			<table>
				<tr>
					<!--Put username in cookie in textbox-->
					<td><input type="text" name="username" value="<%=username%>" placeholder="Username"></td>
				</tr>
				<tr>
					<td><input type="password" name="password" placeholder="Password"></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="rememberMe" id="rememberMe"><label for="rememberMe">Remember me!</label></td>
				</tr>
				<tr>
					<!--Error message-->
					<td style="color:red;"><%=(request.getParameter("errorLogin") != null ? request.getParameter("errorLogin") : "" )%></td>
				</tr>
				<tr>
					<td><input type="submit" value="Login"></td>
				</tr>
			</table>
		</form>

	</div>

	<div class="register">
		<!--Register Form-->
		<form action="actions/doRegister.jsp" method="POST">
			<table>
				<tr>
					<td><input type="text" name="username" placeholder="Username"></td>
				</tr>
				<tr>
					<td><input type="password" name="password" placeholder="Password"></td>
				</tr>
				<tr>
					<td><input type="text" name="fullName" placeholder="Full Name"></td>
				</tr>
				<tr>
					<td>Birthdate: <input type="text" name="birthdate" value="mm/dd/yyyy"></td>
				</tr>
				<tr><td style="color:red;"><%=(request.getParameter("errorRegister") != null ? request.getParameter("errorRegister") : "" )%></td></tr>
				<tr>
					<!--Error message-->
					<td style="color:green;"><%=(request.getParameter("successRegister") != null ? request.getParameter("successRegister") : "" )%></td>
				</tr>
				<tr>
					<td><input type="submit" value="Register"></td>
				</tr>
			</table>
		</form>
	</div>
</div>