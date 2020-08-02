
	<%

		//get user's data from database
		resultSet = statement.executeQuery("SELECT picture, fullname, birthdate, COUNT(followerid) FROM `follow` f JOIN `member` m ON f.followerid = m.id WHERE m.id = '"+(id == 0 ? userid : id)+"' GROUP BY picture,fullname,birthdate");
		if(!resultSet.next()){
			resultSet = statement.executeQuery("SELECT picture,fullname,birthdate,0 FROM member WHERE member.username='"+session.getAttribute("username").toString()+"'");
			resultSet.next();
		}
	%>

	<!--Default image if there is no image filename in database that matches image filename in the folder images-->
	<img src="images/<%=resultSet.getString(1)%>" width="50" height="50" onerror="this.src='images/default.png';"/>
	<p>
		<%=resultSet.getString(2)%>
		<br/>
		Born <%= new SimpleDateFormat("MMM dd, yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(resultSet.getObject(3).toString()))%>
		<br/>
		Following <%= resultSet.getInt(4)%>
	</p>

	<%
		//check if user is looking its own profile
		if(userid == id){
	%>
		<a href="editProfile.jsp"> <button>Edit Profile</button> </a>
	<%
		}else{
	%>
		<!--Toggle follow unfollow button-->
		<a href="actions/doFollow.jsp?id=<%=id%>"> <button><%= statement.executeQuery("SELECT * FROM follow WHERE followerid="+userid+" AND followedid="+id).next() == true ? "Unfollow" : "Follow" %></button> </a>
	<%
		}
	%>
