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
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
	<%!private static class CollegeItem {
		String name;
		int rank;

		CollegeItem(String st, int rank) {
			name = st;
			this.rank = rank;
		}
	}%>

	<%
		String name = new String();
		Integer rank = new Integer(0);
		String College = new String();
		String email = session.getAttribute("email").toString();
		List<CollegeItem> college = new ArrayList<CollegeItem>();
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/rankingdb", "rankinguser",
				"rankingpass");
		PreparedStatement ps = con
				.prepareStatement("select * from studentinfo where email=?");

		ps.setString(1, email);

		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			name = rs.getString("name");
			rank = rs.getInt("rank");
			College = rs.getString("college_alloted");
		}
		PreparedStatement cs = con
				.prepareStatement("select * from collegeinfo");

		ResultSet rs2 = cs.executeQuery();

		while (rs2.next()) {
			college.add(new CollegeItem(rs2.getString("name"), rs2
					.getInt("rank")));

		}
	%>





	<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
		<header class="mdl-layout__header">
			<div class="mdl-layout__header-row">
				<!-- Title -->
				<span class="mdl-layout-title"><%=name%></span> <a
					href="logout.jsp"
					class="mdl-layout-spacer mdl-textfield--floating-label mdl-textfield--align-right">
					<span>Log Out</span>
				</a>

			</div>
			<!-- Tabs -->
			<div class="mdl-layout__tab-bar mdl-js-ripple-effect">
				<a href="#scroll-tab-1" class="mdl-layout__tab is-active">MyPreferences</a>
				<a href="#scroll-tab-2" class="mdl-layout__tab">Allotment</a> <a
					href="#scroll-tab-3" class="mdl-layout__tab">All Colleges
					Details</a>
			</div>
		</header>
		<div class="mdl-layout__drawer">
			<span class="mdl-layout-title">Title</span>
		</div>
		<main class="mdl-layout__content">
		<section class="mdl-layout__tab-panel is-active" id="scroll-tab-1">
			<div class="page-content">
				<!-- Your content goes here -->
				<form method="post" action="add.jsp?email=<%=email%>">
					<div id="outer" style="margin-left: 600px; margin-top: 100px">
						<b>First Preference</b> <select name="p1" id="p1">
							<%
								for (int i = 0; i < college.size(); i++)
									out.print("<option value=" + college.get(i).name + ">"
											+ college.get(i).name + "</option>");
							%>

						</select>
						<div id="middle" style="margin-top: 50px">
							<b>Second Preference</b> <select name="p2" id="p2">
								<%
									for (int i = 0; i < college.size(); i++)
										out.print("<option value=" + college.get(i).name + ">"
												+ college.get(i).name + "</option>");
								%>
							</select>

							<div id="inner" style="margin-top: 50px">
								<b>Third Preference</b> <select name="p3" id="p3">
									<%
										for (int i = 0; i < college.size(); i++)
											out.print("<option value=" + college.get(i).name + ">"
													+ college.get(i).name + "</option>");
									%>
								</select>

							</div>
						</div>
					</div>

					<!-- Colored FAB button with ripple -->
					<button onclick="updatepre"
						class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored"
						style="position: fixed;
	/* set position */ top: 400px; right: 500px;">
						<i class="material-icons">done</i>
					</button>
				</form>

			</div>
		</section>
		<section class="mdl-layout__tab-panel" id="scroll-tab-2">
			<div class="page-content">
				<!-- Your content goes here -->

				<!-- Wide card with share menu button -->
				<style>
.demo-card-wide.mdl-card {
	width: 512px;
}

.demo-card-wide>.mdl-card__title {
	color: #000;
	height: 176px;
	background:
		url(' https://cdn.shopify.com/s/files/1/0154/6225/products/Dee_Lala_RedBalloonGiraffe_WEB_fa7eb797-441f-4b08-8d4c-8d4da7795f54_1024x1024.jpg?v=1424202878')
		center/cover;
}

.demo-card-wide>.mdl-card__menu {
	color: #fff;
}
</style>

				<div class="demo-card-wide mdl-card mdl-shadow--2dp"
					style="margin-top: 100px; margin-left: 600px">
					<div class="mdl-card__title">
						<h2 class="mdl-card__title-text">Welcome</h2>
					</div>
					<div class="mdl-card__supporting-text">
						You have been alloted to
						<%=College%></div>
					<div class="mdl-card__actions mdl-card--border">
						<a
							class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">
							Get Started </a>
					</div>
					<div class="mdl-card__menu">
						<button
							class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect">
							<i class="material-icons">share</i>
						</button>
					</div>
				</div>
			</div>
		</section>
		<section class="mdl-layout__tab-panel" id="scroll-tab-3">
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
		</section>
		</main>
		<footer class="mdl-mini-footer">
			<div class="mdl-mini-footer__left-section">
				<div class="mdl-logo">Title</div>
				<ul class="mdl-mini-footer__link-list">
					<li><a href="#">Help</a></li>
					<li><a href="#">Privacy & Terms</a></li>
					<li><a href="#">Developers</a></li>
				</ul>
			</div>
		</footer>
	</div>
</body>
</html>
