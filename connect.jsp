<%@ page import = "java.sql.*, java.util.*, java.text.SimpleDateFormat"%>
<%
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/prk","prk","prk");
		statement = connection.createStatement(1004,1008);
	}catch(Exception e){
		e.printStackTrace();
		if(e.getMessage().contains("Access denied")){
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/prk","root","");
			statement = connection.createStatement(1004,1008);
		}
	}
%>