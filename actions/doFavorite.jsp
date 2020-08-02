<%@include file="../connect.jsp"%>
<%
	//get member id from database
	resultSet = statement.executeQuery("SELECT id FROM member WHERE username='"+session.getAttribute("username").toString()+"'");
	resultSet.next();
	int userid = resultSet.getInt("id");
	String tweetid = request.getParameter("tweetid").toString();
	
	//toggle delete/insert from favorite in database
	if(statement.executeQuery("SELECT * FROM favorite WHERE memberid="+userid+" AND tweetid="+tweetid+"").next() == true){
		statement.executeUpdate("DELETE FROM favorite WHERE memberid="+userid+" AND tweetid="+tweetid+"");
	}else{
		statement.executeUpdate("INSERT INTO favorite VALUES("+userid+","+tweetid+")");	
	}
	response.sendRedirect("../"+request.getParameter("source").toString());
%>