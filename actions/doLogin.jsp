<%@ include file="../connect.jsp"%>
<%
	//get all parameter
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String remember = request.getParameter("rememberMe");

	//check if username already listed
	resultSet = statement.executeQuery("SELECT * FROM member WHERE username='"+(username==null?"":username)+"' AND password='"+(password==null?"":password)+"'");

	//giving response as the error found
	if(username == null || username.isEmpty()){
		response.sendRedirect("../loginRegister.jsp?errorLogin=Username must be filled!");
	}else if(password == null || password.isEmpty()){
		response.sendRedirect("../loginRegister.jsp?errorLogin=Password must be filled!");
	}else if(!resultSet.next()){
		response.sendRedirect("../loginRegister.jsp?errorLogin=Wrong username or password combination!");
	}else{
		session.setAttribute("username",username);
		application.setAttribute("online",application.getAttribute("online") == null ? 1 : Integer.parseInt(application.getAttribute("online").toString())+1);

		if(remember != null){
			Cookie cookie = new Cookie("username",username);
			cookie.setPath("/");
			cookie.setMaxAge(60 * 60 * 24);
			response.addCookie(cookie);
		}

		response.sendRedirect("../loginRegister.jsp");

	}

%>