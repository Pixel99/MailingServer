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
		int status = st.executeUpdate("insert into userdata_inbox values ('"+sender+"', '"+reciever+"', '"+subject+"', '"+message+"')");
		int status1 = st.executeUpdate("insert into userdata_sentmails values ('"+sender+"', '"+reciever+"', '"+subject+"', '"+message+"')");
		if(status>0&&status1>0)
		{
			out.println("Email sent");
			response.sendRedirect("afterlogin.jsp");
		}
		else
			out.println("Email failed to send\nPlease try again");
	}
	catch(Exception e)
	{
		out.println("Email failed to send due to: "+e+"\nPlease try again");
	}
%>