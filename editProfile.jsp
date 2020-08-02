<%@include file="headerMember.jsp"%>
<title>Bitter - Edit Profile</title>



<!-- Edit profile form -->
<div class="edit-profile">
	<form method="POST" action="actions/doEditProfile.jsp">
		<table>
			<tr>
				<td><input type="text" name="fullname" placeholder="Full Name" /></td>
			</tr>
			<tr>
				<td><input type="password" name="password" placeholder="Password" /></td>
			</tr>
			<tr>
				<td>Birthdate</td>
			</tr>
			<tr>
				<td><input type="text" name="birthdate" value="mm/dd/yyyy" /></td>
			</tr>
			<tr>
				<td>Profile Picture</td>
			</tr>
			<tr>
				<td><input type="file" name="picture" /></td>
			</tr>
			<tr>
				<td><input type="submit" value="Update Profile" /></td>
			</tr>

		</table>

	</form>
	<a href="actions/doDeactivateAccount.jsp">
		<button> Deactivate Account </button>
	</a>

	<br>

	<div style="color:red;">
		<!--Show error message-->
		<%=request.getParameter("error") == null ? "" : request.getParameter("error")%>
	</div>
	
</div>