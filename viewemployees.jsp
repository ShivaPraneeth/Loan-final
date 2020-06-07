<%@page import="java.util.Iterator"%>
<%@page
	import="com.sun.xml.internal.bind.v2.runtime.reflect.ListIterator"%>
<%@page import="com.voidmain.fm.dao.AppDAO"%>
<%@page import="com.voidmain.fm.form.Employee"%>
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
			<div >
				<ul id="menu">
					<!-- put class="current" in the li tag for the selected page - to highlight which page you're on -->
					<li><a class="current" href="bankhome.jsp">Home</a></li>
					<li><a class="current" href="viewcustomerloans.jsp">Loans</a></li>
					<li><a class="current" href="addbank.jsp">Add Bank</a></li>
					<li><a class="current" href="viewbanks.jsp">View Bank</a></li>
					<li class="hvr-sweep-to-bottom"><a href="addemployee.jsp">Add Employee</a></li>
					<li class="hvr-sweep-to-bottom"><a href="viewemployees.jsp">View Employees</a></li>
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
				<h1>View Employees</h1>
				<%
					}
				%>

				<table class="imagetable">
					<tr>
						<th>UserName</th>
						<th>Address</th>
						<th>Mobile</th>
						<th>Email</th>
						<th>Type</th>
						<th>Activate</th>
						<th>DeActivate</th>

					</tr>
					<%
						List<Employee> userForms = AppDAO.getEmployees();

						Iterator<Employee> iterator = userForms.iterator();

						while (iterator.hasNext()) {

							Employee userForm = iterator.next();

							String status1 = "activated";
							String status2 = "waiting";
					%>
					<tr>
						<td><%=userForm.getUserName()%></td>
						<td><%=userForm.getAddress()%></td>
						<td><%=userForm.getMobile()%></td>
						<td><%=userForm.getEmail()%></td>
						<td><%=userForm.getType()%></td>
						<td><a
							href="viewemployees.jsp?username=<%=userForm.getUserName()%>&status=<%=status1%>">Activate</a>
						</td>
						<td><a
							href="viewemployees.jsp?username=<%=userForm.getUserName()%>&status=<%=status2%>">Deactivate</a>
					</tr>
					<%
						}
					%>
					<%
						String username = request.getParameter("username");
						String status = request.getParameter("status");

						if (username != null && status != null) {
							int result = AppDAO.activateUser(username, status);

							if (result == 1) {
								response.sendRedirect("viewemployees.jsp?status=Employee is activated");
							} else {
								response.sendRedirect("viewemployees.jsp?status=failed");
							}
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


