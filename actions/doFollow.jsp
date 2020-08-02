<%@include file="../connect.jsp"%>
<%
	//get member id from database
	resultSet = statement.executeQuery("SELECT id FROM member WHERE username='"+session.getAttribute("username").toString()+"'");
	resultSet.next();
	int userid = resultSet.getInt("id");
	int id = Integer.parseInt(request.getParameter("id").toString());
	
	//toggle insert/delete from follow database
	if(statement.executeQuery("SELECT * FROM follow WHERE followerid="+userid+" AND followedid="+id).next() == true){
		statement.executeUpdate("DELETE FROM follow WHERE followerid="+userid+" AND followedid="+id);
	}else{
		statement.executeUpdate("INSERT INTO follow VALUES("+userid+","+id+")");	
	}
	response.sendRedirect("../profile.jsp?id="+id);
%>