<%@include file="../connect.jsp"%>

<%
	//initializing variable for tweet purposes
	Vector<String> hashtags = new Vector<String>();
	Statement tweetStatement = connection.createStatement(1004,1008);
	ResultSet tweetSet;
	
	//change every hashtag to link
	String tweet =  request.getParameter("newTweet").toString();
	for (String hashtag : tweet.split("#") ) {
		if(tweet.contains(("#"+hashtag)) && !hashtag.isEmpty()) {
			hashtag = hashtag.substring(0,hashtag.indexOf(" "));
			out.println(hashtag+"<br/>");
			tweet = tweet.replace(("#"+hashtag),"<a href=\"search.jsp?hashtag=true&search=#"+hashtag+"\">"+("#"+hashtag)+"</a>");

			//insert hashtag to database if not exist
			Statement hashtagStatement = connection.createStatement(1004,1008);
			ResultSet hashtagSet = hashtagStatement.executeQuery("SELECT * FROM hashtag WHERE name='"+hashtag+"'");
			if(!hashtagSet.next()) hashtagStatement.executeUpdate("INSERT INTO hashtag VALUES(NULL,'"+hashtag+"')");
			hashtags.add(hashtag);
		}
	}

	//update tweet in database
	statement.executeUpdate("UPDATE tweet SET tweet='"+tweet+"' WHERE id="+request.getParameter("tweetid").toString());

	//get tweet in database
	tweetSet = tweetStatement.executeQuery("SELECT * FROM tweet WHERE tweet='"+tweet+"'");
	tweetSet.next();
	String tweetid = tweetSet.getString(1);

	//for every hashtag, insert hashtagdetail in database
	for (String hashtag : hashtags ) {
		Statement hashtagStatement = connection.createStatement(1004,1008);
		ResultSet hashtagSet = hashtagStatement.executeQuery("SELECT * FROM hashtag WHERE name='"+hashtag+"'");
		if(hashtagSet.next()) hashtagStatement.executeUpdate("INSERT INTO hashtagDetail VALUES("+hashtagSet.getString(1)+","+tweetid+")");
	}

	//return
	response.sendRedirect("../"+request.getParameter("source").toString());

%>