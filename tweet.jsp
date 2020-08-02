
	<%
		//Paging
		int count = 1;
		int maxTweet = 5;
		int currentPage = (request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage").toString()));	
		if(currentPage < 0 ) currentPage = 1;

		Statement tweetStatement = connection.createStatement(1004,1008);


		//Differentiate profile, favorite or home
		String query = "SELECT DISTINCT username,date,tweet,m.id,t.id FROM `tweet` t JOIN `member` m ON t.memberid=m.id WHERE t.memberid="+id+" ORDER BY date DESC";
		if(request.getParameter("favorited") != null) query = "SELECT DISTINCT username,date,tweet,m.id,t.id FROM `tweet` t JOIN `favorite` f ON t.id = f.tweetid JOIN `member` m ON t.memberid=m.id  WHERE f.memberid="+userid+" AND t.memberid="+id+" ORDER BY date DESC";
		else if(source.contains("home")) query = "SELECT DISTINCT username,date,tweet,m.id,t.id FROM `tweet` t JOIN `follow` f ON t.memberid = f.followedid JOIN `member` m ON t.memberid=m.id WHERE f.followerid="+id+" OR t.memberid="+id+" ORDER BY date DESC";

		ResultSet tweetSet = tweetStatement.executeQuery(query);

		while(tweetSet.next()){
			String username = tweetSet.getString(1);
			String tweetDate = tweetSet.getString(2);
			String tweet = tweetSet.getString(3);
			String memberid = tweetSet.getString(4);
			String tweetid = tweetSet.getString(5);

			if(count > maxTweet * (currentPage-1) && count <= maxTweet * currentPage){
	%>
				<table>
					<tr>
						<td><form method="POST" action="profile.jsp" class="tweet-list"><input type="hidden" name="id" value="<%=memberid%>"><input type="submit" value="<%=username%>"/> </form></td>
					</tr>
					<tr>
						<td>
							<%=tweetDate%>
							<!--Toggle follow unfollow button-->
							<a href="actions/doFavorite.jsp?tweetid=<%=tweetid%>&source=<%=source%>?currentPage=<%=currentPage%>"><%= statement.executeQuery("SELECT * FROM favorite WHERE memberid="+userid+" AND tweetid="+tweetid+"").next() == true ? "Unfavorite" : "Favorite" %></a>

							<%
								String pureTweet = tweet;
								if(userid == Integer.parseInt(memberid)){
									pureTweet = "";
									for(String partTweet : tweet.split("<a")){
										if(partTweet.contains(">")){
											partTweet = partTweet.substring(partTweet.indexOf(">")+1);
											partTweet = partTweet.replace("</a>","");
										}	
										pureTweet += partTweet;
									}
							%>
								<a href="actions/doDelete.jsp?tweetid=<%=tweetid%>&source=<%=source%>?currentPage=<%=currentPage%>">Delete</a>
								<button onclick="show('update#<%=tweetid%>')">Update tweet</button>

							<%
								}
							%>

						</td>
					</tr>
					<tr>
						<td>  
							<%
								out.println(tweet);		
								if(userid == Integer.parseInt(memberid)){
							%>

								<form id="update#<%=tweetid%>" style="display:none;" action="actions/doUpdate.jsp"> 

								<br/>

									<input type="text" name="newTweet" value="<%=pureTweet%>">

									<input type="hidden" name="source" value="<%=source%>?currentPage=<%=currentPage%>"/>
									<input type="hidden" name="id" value="<%=memberid%>"/>
									<input type="hidden" name="tweetid" value="<%=tweetid%>"/>
									<input type="submit" value="Update"/>
								</form>
							<%
								}
							%>
						</td>
					</tr>
				</table>
	<%
			}
			count++;
		}
		count--;
		//Show page numbers
		if(count * 1.0f / maxTweet * 1.0f > 1){
			for (int i = 1; i <= Math.ceil(count * 1.0f / maxTweet * 1.0f); i++) {
				if(i != currentPage){
		%>
					<a href="<%=source%>currentPage=<%=i%>"><%=i%></a>
		<%
				}else
					out.println(i);
			}
		}

	%>
<script type="text/javascript">
	//Function to toggle show
	function show(id){
		var element = document.getElementById(id);
		element.style.display= element.style.display == 'none' ? 'block' : 'none';
	} 
</script>