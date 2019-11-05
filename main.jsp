<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>

<%!
	Statement st;
	Connection con;
%>

<% 
	String email = request.getParameter("email");
	String pass = request.getParameter("pass");
	
	try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","admin");
		st = con.createStatement();
		ResultSet rs= st.executeQuery("select * from userinfo");
	
		session.setAttribute("email",email);
		session.setAttribute("pass",pass);
	
		if(session.isNew())
		{
			boolean status=false;
			while(rs.next())
			{
				if(email.equals(rs.getString(1))&&pass.equals(rs.getString(2)))
				{
					status=true;
					break;
				}	
			}
			if(status)
				response.sendRedirect("afterlogin.jsp");
			else
				out.println("Please login with valid credentials or Sign Up");
		}
		else
		{
			response.sendRedirect("afterlogin.jsp");
		}
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>