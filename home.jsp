<%@page import="java.lang.Math"%>
<%@include file="headerMember.jsp"%>

<title>Bitter - Home</title>



<div class="profile">

	<!-- Profile here -->
	<%@include file="userprofile.jsp"%>

</div>

<%
	//setting source
	String source = "home.jsp?id="+id+"&";
	//check if looking at user
	if(userid == id){
%>

	<div class="new-tweet">
		<form method="POST" action="actions/doTweet.jsp">

			<input type="hidden" name="source" value="home.jsp" />
			<textarea name="tweet" placeholder="Let's hear what you say"></textarea>		
			<input type="submit" value="Tweet"></input>
		</form>	
	</div>

<%
	}
%>

<div class="tweet">

	<!-- Tweets here -->
	<%@include file="tweet.jsp"%>
	
</div>