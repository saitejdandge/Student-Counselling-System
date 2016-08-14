<%@ page import ="java.sql.*"
 %>
 <%@  page import="com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException"
 %>
<%
 
    String name = request.getParameter("name");
    String rank = request.getParameter("rank");
    Integer it=Integer.parseInt(rank);
    String email=request.getParameter("email");
    String password=request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/rankingdb",
            "rankinguser", "rankingpass");
    try
    {
    String input="insert into studentinfo(name,rank,email,password,college_alloted) values (?,?,?,?,?)";
    PreparedStatement st = con.prepareStatement(input);
    
    st.setString(1,name);
    st.setInt(2,it);
    st.setString(3,email);
    st.setString(4,password);
    st.setString(5,"NOT AVAILABLE");
    //ResultSet rs;
    int i=st.executeUpdate();  
   if (i > 0) {
        //session.setAttribute("userid", user);
        response.sendRedirect("Login_page.html");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.jsp");
    }
    }
    catch(MySQLIntegrityConstraintViolationException e)
    {
    	out.print("User Name already Exsists !"+"<a href='index.jsp'>Go to Login</a>");
    }
%>