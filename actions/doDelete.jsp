<%@include file="../connect.jsp"%>

<%
	//delete tweet from database
	statement.executeUpdate("DELETE FROM tweet WHERE id="+request.getParameter("tweetid").toString());
	response.sendRedirect("../"+request.getParameter("source").toString());

%>