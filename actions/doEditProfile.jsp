<%@ include file="../connect.jsp"%>
<%
	//get all parameter
	String fullName = request.getParameter("fullname");
	String password = request.getParameter("password");
	String birthdate = request.getParameter("birthdate");
	String picture = request.getParameter("picture");

	//check if password is alphanumeric
	boolean isDigit = false, isLetter = false;
	for(char character : password.toCharArray()){
		if(Character.isDigit(character)) isDigit = true;
		else if(Character.isLetter(character)) isLetter = true;
		else { isDigit = isLetter = false; break; }
	}
	//check if fullname is letter and whitespace
	boolean isValid = true;
	for(char character : fullName.toCharArray()){
		if(!Character.isLetter(character) && !Character.isWhitespace(character)) isValid = false;
	}

	//check  if date is as the format
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

	//give error message as the error found
	if(fullName.length() < 8){
		response.sendRedirect("../editProfile.jsp?error=Full Name must be more than 8 characters!");
	}else if(!isValid){
		response.sendRedirect("../editProfile.jsp?error=Full Name can only contain alphabet and whitespace!");
	}else if(!isDigit || !isLetter){
		response.sendRedirect("../editProfile.jsp?error=Password must be alphanumeric!");
	}else if(!isFormat){
		response.sendRedirect("../editProfile.jsp?error=Birth Date must be filled with mm/dd/yyyy format!");
	}else if(now.get(Calendar.YEAR) - birth.get(Calendar.YEAR) - (now.get(Calendar.MONTH) - birth.get(Calendar.MONTH) > 0 ? 0 : 1) < 17){
		response.sendRedirect("../editProfile.jsp?error=Minimal current age is 17 years old!");
	}else if(!picture.endsWith(".jpg")){
		response.sendRedirect("../editProfile.jsp?error=Image extension must be jpg!");
	}else{
		//update member in database
		statement.executeUpdate("UPDATE member SET fullname='"+fullName+"', birthdate='"+birth.get(Calendar.YEAR)+"-"+birth.get(Calendar.MONTH)+"-"+birth.get(Calendar.DAY_OF_MONTH)+"',password='"+password+"',picture='"+picture+"' WHERE username='"+session.getAttribute("username").toString()+"'");
		response.sendRedirect("../home.jsp");
	}
%>