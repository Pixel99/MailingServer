<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>

<%!
	Connection con;
	Statement st;
%>

<%
	String sender,reciever,subject,message;
	sender=(String)session.getAttribute("email");
	reciever=request.getParameter("reciever");
	subject=request.getParameter("subject");
	message=request.getParameter("message");
	
	try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","admin");
		st = con.createStatement();
		int status = st.executeUpdate("insert into userdata_drafts values ('"+sender+"', '"+reciever+"', '"+subject+"', '"+message+"')");
		
		if(status>0)
		{
			out.println("Draft Saved");
			response.sendRedirect("afterlogin.jsp");
		}
		else
			out.println("Failed to save Draft\nPlease try again");
	}
	catch(Exception e)
	{
		out.println("Draft failed to save due to: "+e+"\nPlease try again");
	}
%>