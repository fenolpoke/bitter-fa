<%@ include file="../connect.jsp"%>
<%
	//get all parameter
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String fullName = request.getParameter("fullName");
	String birthdate = request.getParameter("birthdate");

	//check if username existed in database
	resultSet = statement.executeQuery("SELECT * FROM member WHERE username = '"+username+"'");
	
	//check if password is alphanumeric
	boolean isDigit = false, isLetter = false;
	for(char character : password.toCharArray()){
		if(Character.isDigit(character)) isDigit = true;
		else if(Character.isLetter(character)) isLetter = true;
		else { isDigit = isLetter = false; break; }
	}

	//check if fullname is letter and whitespace only
	boolean isValid = true;
	for(char character : fullName.toCharArray()){
		if(!Character.isLetter(character) && !Character.isWhitespace(character)) isValid = false;
	}

	//check if date is as format
	boolean isFormat = true;
	Calendar birth = Calendar.getInstance(), now = Calendar.getInstance(); 
	try{
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");

		simpleDateFormat.setLenient(false);

		birth.setTime(simpleDateFormat.parse(birthdate));
		now.setTime(new java.util.Date());
	}catch(Exception e){
		out.print(e.getMessage());
		isFormat = false;
	};

	//sending response as the error found
	if(username == null || username.isEmpty()){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Username must be filled!");
	}else if(password == null || password.isEmpty()){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Password must be filled!");
	}else if(!isDigit || !isLetter){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Password must be alphanumeric!");
	}else if(fullName == null || fullName.isEmpty()){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Full Name must be filled!");
	}else if(fullName.length() < 8){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Full Name must be more than 8 characters!");
	}else if(!isValid){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Full Name can only contain alphabet and whitespace!");
	}else if(birthdate == null || birthdate.isEmpty()){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Birth Date must be filled!");
	}else if(!isFormat){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Birth Date must be filled with mm/dd/yyyy format!");
	}else if(now.get(Calendar.YEAR) - birth.get(Calendar.YEAR) - (now.get(Calendar.MONTH) - birth.get(Calendar.MONTH) > 0 ? 0 : 1) < 17){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Minimal current age is 17 years old!");
	}else if(resultSet.next()){
		response.sendRedirect("../loginRegister.jsp?errorRegister=Username already existed in the database!");
	}else{
		//insert into database
		statement.executeUpdate("INSERT INTO member(username,password,fullname,birthdate) VALUES('"+username+"','"+password+"','"+fullName+"','"+birth.get(Calendar.YEAR)+"-"+birth.get(Calendar.MONTH)+"-"+birth.get(Calendar.DAY_OF_MONTH)+"')");
		//setting follow in the follow table to follow oneself
		resultSet = statement.executeQuery("SELECT * FROM member WHERE username='"+username+"'");
		if(resultSet.next()){
			statement.executeUpdate("INSERT INTO follow VALUES("+resultSet.getString(1).toString()+","+resultSet.getString(1).toString()+")");
			response.sendRedirect("../loginRegister.jsp?successRegister=Register Success! Please try login!");
		}
	}

%>