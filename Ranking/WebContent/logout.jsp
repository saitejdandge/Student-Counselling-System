<%
session.setAttribute("email", null);
session.invalidate();
response.sendRedirect("Login_page.html");
%>