<%@ page import="java.sql.*"%>
<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(
			"jdbc:mysql://localhost/rankingdb", "rankinguser",
			"rankingpass");
	PreparedStatement ps = con
			.prepareStatement("select * from studentinfo where email=?");

	ps.setString(1, email);

	ResultSet rs = ps.executeQuery();
	String original;
	if (rs.next()) {
		original = rs.getString("password");
		//ResultSet rs;

		if (original.equals(password) == true) {
			//session.setAttribute("userid", user);
			//response.sendRedirect("user.jsp");
			if (email.equals("admin@gmail.com")) {

				session.setAttribute("email", email);
				response.sendRedirect("admin.jsp");
			} else

			{
				session.setAttribute("email", email);
				response.sendRedirect("user.jsp");
			}
		}

		else {
			
			
			
		}
	}
%>