<%@include file="../connect.jsp"%>
<%
	//get member id from database
	resultSet = statement.executeQuery("SELECT id FROM member WHERE username='"+session.getAttribute("username").toString()+"'");
	resultSet.next();
	int userid = resultSet.getInt("id");
	String tweet =  request.getParameter("tweet").toString();

	//initializing variable for tweet purposes
	Statement tweetStatement = connection.createStatement(1004,1008);
	ResultSet tweetSet;	
	Vector<String> hashtags = new Vector<String>();

	//change every hashtag to link
	for (String hashtag : tweet.split("#") ) {
		if(tweet.contains(("#"+hashtag)) && !hashtag.isEmpty()) {
			hashtag = hashtag.indexOf(" ") < 0 ? hashtag : hashtag.substring(0,hashtag.indexOf(" "));
			tweet = tweet.replace(("#"+hashtag),"<a href=\"search.jsp?hashtag=true&search="+hashtag+"\">"+("#"+hashtag)+"</a>");

			//insert into hashtag if not exist in database
			Statement hashtagStatement = connection.createStatement(1004,1008);
			ResultSet hashtagSet = hashtagStatement.executeQuery("SELECT * FROM hashtag WHERE name='"+hashtag+"'");
			if(!hashtagSet.next()) hashtagStatement.executeUpdate("INSERT INTO hashtag VALUES(NULL,'"+hashtag+"')");
			hashtags.add(hashtag);
		}
	}


	//insert tweet in database
	statement.executeUpdate("INSERT INTO tweet VALUES(NULL,"+userid+",'"+tweet+"',NOW())");


	//get tweet id from databse
	tweetSet = tweetStatement.executeQuery("SELECT * FROM tweet WHERE tweet='"+tweet+"'");
	tweetSet.next();
	String tweetid = tweetSet.getString(1);

	//insert into hashtag detail
	for (String hashtag : hashtags ) {
		Statement hashtagStatement = connection.createStatement(1004,1008);
			ResultSet hashtagSet = hashtagStatement.executeQuery("SELECT * FROM hashtag WHERE name='"+hashtag+"'");
		if(hashtagSet.next()) hashtagStatement.executeUpdate("INSERT INTO hashtagDetail VALUES("+hashtagSet.getString(1)+","+tweetid+")");
	}

	//return
	response.sendRedirect("../"+request.getParameter("source"));
%>