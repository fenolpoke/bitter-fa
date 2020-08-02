<%@include file="../connect.jsp"%>

<%
	//get user data from database
	String username = session.getAttribute("username").toString();
	resultSet = statement.executeQuery("SELECT * FROM member WHERE username='"+username+"'");
	resultSet.next();
	String id = resultSet.getString(1);
	//delete from follow, favorite, hashtagdetail, tweet and member table
	statement.executeUpdate("DELETE FROM follow WHERE followerid="+id+" OR followedid="+id);
	statement.executeUpdate("DELETE FROM favorite WHERE memberid="+id);
	statement.executeUpdate("DELETE hd FROM hashtagDetail hd JOIN tweet t ON hd.tweetid = t.id WHERE t.memberid="+id);
	statement.executeUpdate("DELETE FROM tweet WHERE memberid="+id);	
	statement.executeUpdate("DELETE FROM member WHERE username='"+username
		+"'");
%>
<!--logout-->
<%@include file="doLogout.jsp"%>