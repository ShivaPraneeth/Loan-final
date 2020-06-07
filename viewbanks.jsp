<%@page import="java.util.Iterator"%>
<%@page
	import="com.sun.xml.internal.bind.v2.runtime.reflect.ListIterator"%>
<%@page import="com.voidmain.fm.dao.AppDAO"%>
<%@page import="com.voidmain.fm.form.Bank"%>
<%@page import="java.util.List"%>

<!DOCTYPE HTML>
<html>

<head>
<title></title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252" />
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Tangerine&amp;v1" />
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz" />
<link rel="stylesheet" type="text/css" href="style/style.css" />

</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<div class="slogan">Loan Automation</div>
			</div>
			<div>
				<ul id="menu">
					<!-- put class="current" in the li tag for the selected page - to highlight which page you're on -->
					<li><a class="current" href="bankhome.jsp">Home</a></li>
					<li><a class="current" href="addbank.jsp">Add Bank</a></li>
					<li><a class="current" href="viewbanks.jsp">View Bank</a></li>
					<li class="hvr-sweep-to-bottom"><a href="addemployee.jsp">Add
							Employee</a></li>
					<li class="hvr-sweep-to-bottom"><a href="viewemployees.jsp">View
							Employees</a></li>
					<li class="hvr-sweep-to-bottom"><a href="logout.jsp">Logout</a></li>
				</ul>
			</div>
		</div>
		<div id="site_content">
			<div id="content">

				<%
					String status3 = request.getParameter("status");

					if (status3 != null) {
				%>
				<h1><%=status3%></h1>
				<%
					} else {
				%>
				<h1>View Banks</h1>
				<%
					}
				%>

				<table class="imagetable">
					<tr>
						<th>Bank Id</th>
						<th>Name</th>
						<th>Address</th>
						<th>Mobile</th>
						<th>Email</th>
						<th>Delete</th>
						<th>Add Plan</th>
					</tr>
					<%
						List<Bank> bank = AppDAO.getBanks();

						Iterator<Bank> iterator = bank.iterator();

						while (iterator.hasNext()) {

							Bank userForm = iterator.next();

							String status1 = "activated";
							String status2 = "waiting";
					%>
					<tr>
						<td><%=userForm.getUserName()%></td>
						<td><%=userForm.getName()%></td>
						<td><%=userForm.getAddress()%></td>
						<td><%=userForm.getMobile()%></td>
						<td><%=userForm.getEmail()%></td>
						<td><a href="viewbanks.jsp?bid=<%=userForm.getUserName()%>&delete=1">delete</a>
						</td>
						<td><a href="viewbanks.jsp?bid=<%=userForm.getUserName()%>">Add
								Plan</a></td>
					</tr>
					<%
						}
					%>
					
					<%
						String bid = request.getParameter("bid");
						String delete=request.getParameter("delete");
						if(delete!=null )
						{
							int result=AppDAO.deleteBank(bid);
							
							if(result==1)
							{
								response.sendRedirect("viewbanks.jsp?status=success");
							}
							else
							{
								response.sendRedirect("viewbanks.jsp?status=failed");
							}
						}
						else if (bid != null) {
					%>
					<form action="AddPlanServlet" name="ff" method="post">

						<input type="hidden" name="bankname" value="<%=bid%>" />

						<div class="form_settings">
							
							<p>
								<span>Bank Name</span><input type="text" name="bankname" value="<%=bid%>" readonly="readonly"/>
							</p>
							
							<p>
								<span>Select Loan Type</span> <select name="loantype">
									<option value="home">Home Loan</option>
									<option value="gold">Gold Loan</option>
									<option value="education">Education Loan</option>
									<option value="vehicle">Vehicle Loan</option>
								</select>
							</p>

							<p>
								<span>Interest Rate</span><input type="text" name="irate" />
							</p>

							<p style="padding-top: 15px">
								<span>&nbsp;</span><input class="submit" type="submit"
									name="contact_submitted" value="submit" />
							</p>

						</div>
					</form>
					<%
						}
					%>
				</table>
			</div>
		</div>
		<div id="footer">
			
		</div>
	</div>
</body>
</html>


