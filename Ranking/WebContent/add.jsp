<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
<%
	 String P1 = request.getParameter("p1");
	    String P2 = request.getParameter("p2");
	    String P3 = request.getParameter("p3");
	     String email=request.getParameter("email");

	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/rankingdb",
	            "rankinguser", "rankingpass");
	    String sqlStr = "UPDATE studentinfo   SET pre1=?,  pre2 = ?, pre3=? WHERE email = ? ;";
	    
	   
	    PreparedStatement pstmt = con.prepareStatement(sqlStr);
	    pstmt.setString(1,P1);
	    pstmt.setString(2,P2);
	    pstmt.setString(3,P3);
	    pstmt.setString(4,email);
	    
	    int i=pstmt.executeUpdate(); 

		response.sendRedirect("user.jsp?email="+email);
	   
    %>