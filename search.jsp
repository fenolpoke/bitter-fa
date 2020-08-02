<%@include file="headerMember.jsp"%>

<title>Bitter - Search Result</title>

<!-- Search result here -->

<%
	//get search parameter
	String search = request.getParameter("search").toString();

	//paging
	int count = 1;
	int maxTweet = 5;
	int currentPage = (request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage").toString()));	
	if(currentPage < 0 ) currentPage++;


	if(search.startsWith("@")){
		resultSet = statement.executeQuery("SELECT id,username,birthdate FROM member WHERE username LIKE '%"+search.substring(1)+"%'");
	}else if(request.getParameter("hashtag") != null){
		resultSet = statement.executeQuery("SELECT m.id,username,tweet FROM member m JOIN tweet t ON m.id = t.memberid WHERE tweet LIKE '%"+search+"%'");
		
	}else{
		resultSet = statement.executeQuery("SELECT m.id,username,tweet FROM member m JOIN tweet t ON m.id = t.memberid WHERE tweet LIKE '%"+search+"%'");
		
	}

	while(resultSet.next()){
		if(count > maxTweet * (currentPage-1) && count <= maxTweet * currentPage){
	%>
			<table>
				<tr>
					<td><form method="POST" action="profile.jsp" class="tweet-list"><input type="hidden" name="id" value="<%=resultSet.getString(1)%>"><input type="submit" value="<%=resultSet.getString(2)%>"/> </form></td>
				</tr>
				<tr>
					<td><%=resultSet.getString(3)%></td>
				</tr>
			</table>
	<%
		}
		count++;
	}
	count--;	
	//show page number
	if(count * 1.0f / maxTweet * 1.0f > 1){
		for (int i = 1; i <= Math.ceil(count * 1.0f / maxTweet * 1.0f); i++) {
			if(i != currentPage){
	%>
				<a href="search.jsp?search=<%=search%>&currentPage=<%=i%>"><%=i%></a>
	<%
			}else
				out.println(i);
		}
	}

%>