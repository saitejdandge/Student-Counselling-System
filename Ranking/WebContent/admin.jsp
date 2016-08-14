<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://code.getmdl.io/1.1.1/material.indigo-pink.min.css">
<script defer src="https://code.getmdl.io/1.1.1/material.min.js"></script>

</head>
<body>
	<%!private static class CollegeItem {
		String name;
		int rank;

		CollegeItem(String st, int rank) {
			name = st;
			this.rank = rank;
		}
	}%>
	<%!private static class StudentItem {
		String name;
		int rank;
		String college_alloted;
		String email;
String p1;
String p2;
String p3;

		StudentItem(String st, String clg, int v,String email,String p1,String p2,String p3) {
			name = st;
			this.rank = v;
			this.college_alloted = clg;
			this.email=email;
			this.p1=p1;
			this.p2=p2;
			this.p3=p3;
			
		}
	}%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%
		String name = new String();
		Integer rank = new Integer(0);
		String College = new String();
		List<CollegeItem> college = new ArrayList<CollegeItem>();
		List<StudentItem> studentlist = new ArrayList<StudentItem>();
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/rankingdb", "rankinguser",
				"rankingpass");
		PreparedStatement ps = con
				.prepareStatement("select * from studentinfo where email !="+"'"+"admin@gmail.com"+"'");

		ResultSet rs = ps.executeQuery();

		PreparedStatement cs = con
				.prepareStatement("select * from collegeinfo");

		ResultSet rs2 = cs.executeQuery();

		while (rs.next()) {
			name = rs.getString("name");
			College = rs.getString("college_alloted");
			studentlist.add(new StudentItem(rs.getString("name"), rs
					.getString("college_alloted"), rs.getInt("rank"),rs.getString("email"),rs.getString("pre1"),rs.getString("pre2"),rs.getString("pre3")));

		}

		while (rs2.next()) {
			college.add(new CollegeItem(rs2.getString("name"), rs2
					.getInt("rank")));

		}
	%>


	<!-- Simple header with scrollable tabs. -->
	<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
		<header class="mdl-layout__header">
			<div class="mdl-layout__header-row">
				<!-- Title -->
				<span class="mdl-layout-title">Admin Control</span>
				<a
					href="logout.jsp"
					class="mdl-layout-spacer mdl-textfield--floating-label mdl-textfield--align-right">
					<span>Log Out</span>
				</a>
			</div>
			<!-- Tabs -->
			<div class="mdl-layout__tab-bar mdl-js-ripple-effect">
				<a href="#scroll-tab-1" class="mdl-layout__tab is-active">Allot
					Seats</a> <a href="#scroll-tab-2" class="mdl-layout__tab">College
					List</a> <a href="#scroll-tab-3" class="mdl-layout__tab">Add
					College </a>
			</div>
		</header>
		<div class="mdl-layout__drawer">
			<span class="mdl-layout-title">Title</span>
		</div>
		<main class="mdl-layout__content">
		<section class="mdl-layout__tab-panel is-active" id="scroll-tab-1">
			<div class="page-content">
				<!-- Your content goes here -->
				<form method="post" action="allot.jsp">
					<table class="mdl-data-table mdl-js-data-table"
						style="position: fixed;
	/* set position */ top: 150px; right: 400px;">
						<thead>
							<tr>
								<th class="mdl-data-table__cell--non-numeric">Student ID</th>

								<th class="mdl-data-table__cell--non-numeric">Student Name</th>

								<th class="mdl-data-table__cell--non-numeric">Student Rank</th>

								<th class="mdl-data-table__cell--non-numeric">Allot College</th>


								<th class="mdl-data-table__cell--non-numeric">College
									Alloted</th>

								<th class="mdl-data-table__cell--non-numeric">Priority 1</th>

								<th class="mdl-data-table__cell--non-numeric">Priority 2</th>
								<th class="mdl-data-table__cell--non-numeric">Priority 3</th>

							</tr>
						</thead>
						<tbody>
							<%
								for (int i = 0; i < studentlist.size(); i++) {
									out.println("<tr>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).name);
									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).name);
									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).rank);
									out.print("</td>");

									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");

									out.println("<select "+"name="+studentlist.get(i).email+"p>");

									for (int ij = 0; ij < college.size(); ij++)
										out.print("<option value=" + college.get(ij).name + ">"
												+ college.get(ij).name + "</option>");

									out.println("</select>");

									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).college_alloted);
									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).college_alloted);
									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).college_alloted);
									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(studentlist.get(i).college_alloted);
									out.print("</td>");


									out.println("</tr>");
								}
							%>
						</tbody>
					</table>
					<!-- Colored FAB button with ripple -->



					<!-- Colored raised button -->
					<button
						class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored"
						onclick="updatepre"
						style="position: fixed;
	/* set position */ top: 400px; right: 800px;">
						Submit</button>
				</form>


			</div>
		</section>
		<section class="mdl-layout__tab-panel" id="scroll-tab-2">
			<div class="page-content">
				<!-- Your content goes here -->

				<div class="page-content"
					style="margin-top: 100px; margin-left: 600px">
					<!-- Your content goes here -->
					<table class="mdl-data-table mdl-js-data-table">
						<thead>
							<tr>
								<th class="mdl-data-table__cell--non-numeric">College Name</th>
								<th class="mdl-data-table__cell--non-numeric">College Rank</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (int i = 0; i < college.size(); i++) {
									out.println("<tr>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(college.get(i).name);
									out.print("</td>");
									out.println("<td class=\"mdl-data-table__cell--non-numeric\">");
									out.println(college.get(i).rank);
									out.print("</td>");
									out.println("</tr>");
								}
							%>
						</tbody>
					</table>
				</div>




			</div>
		</section>
		<section class="mdl-layout__tab-panel" id="scroll-tab-3">
			<div class="page-content">
				<!-- Your content goes here -->
				<center>
	<div class="demo-card-wide mdl-card mdl-shadow--2dp">
				<div class="mdl-card__title">
					<h2 class="mdl-card__title-text">Add College</h2>
				</div>


	<form method="post" action="AddCollege.jsp">
					<!-- Simple Textfield -->
					<div
						class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
						<input class="mdl-textfield__input" id="username"	name="cname"> 
						<label class="mdl-textfield__label" for="sample1">College Name...</label> 
					</div>
					<!-- Simple Textfield -->
					<div
						class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
						<input class="mdl-textfield__input"  pattern="-?[0-9]*(\.[0-9]+)?"  id="username"	name="crank"> 
						<label class="mdl-textfield__label" for="sample1">College Rank...</label> 
						<span class="mdl-textfield__error">Not a Valid Rank !</span>
					</div>
					<button type="submit" id="boya"class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent">Add College</button>

				</form>



			</div>
			<center>




			
			</div>
		</section>
		</main>
	</div>
</body>
</html>
