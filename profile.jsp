<%@include file="headerMember.jsp"%>

<title>Bitter - Profile</title>


<div class="profile">

	<!-- Profile here -->

	<%@include file="userprofile.jsp"%>

</div>


<%
	//set source
	String source = "profile.jsp?id="+id+"&";
	//check if user is looking its own profile
	if(userid == id){
%>

	<div class="new-tweet">
		<form method="POST" action="actions/doTweet.jsp">
			<input type="hidden" name="source" value="profile.jsp" />
			<textarea name="tweet" placeholder="Let's hear what you say"></textarea>		
			<input type="submit" value="Tweet"></input>
		</form>	
	</div>

<%
	}
%>

<div class="tweet">
	<!--Filter tweet-->
	<a href="profile.jsp?id=<%=id%>">All</a> &nbsp | &nbsp <a href="profile.jsp?favorited=&id=<%=id%>">Favorited</a>
	<br/>
	<!-- Tweets here -->
	<%@include file="tweet.jsp"%>
	
</div>
