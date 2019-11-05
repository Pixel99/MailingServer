<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>

<%!
	Connection con;
	Statement st;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Inbox</title>
</head>

<body>
<table width="100%" border="1">

<%
	String sender,subject;
	String reciever="";
	String msg="";
	sender=(String)session.getAttribute("email");
	subject=request.getParameter("subject");
	
	try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","admin");
		st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from userdata_inbox where subject='"+subject+"'");
		while(rs.next())
		{
			reciever=rs.getString(2);
			msg=rs.getString(4);
		}
	}
	catch(Exception e)
	{
		out.println("Page failed to load due to: "+e+"\nPlease try again");
	}
%>

  <tr>
    <th width="15%" scope="col">To:</th>
    <th width="85%" scope="col">
      <div align="left">
	  <%=
        "<input type='text' name='reciever' id='reciever' value='"+reciever+"' size='200'/>"
		%>
    </div></th>
  </tr>
  <tr>
    <td><div align="center">Subject</div></td>
	<%=
		"<td><input type='text' name='subject' id='subject' value='"+subject+"' size='200' /></td>"
	%>
  </tr>
  <tr>
    <td height="333"><div align="center">Message</div></td>
	<%=
    "<td><textarea name='message' id='message' cols='180' rows='20'>"+msg+"</textarea></td>"
	%>
  </tr>
</table>
<form id="form1" name="form1" method="post" action="">
	<BR/>
<a href=afterlogin.jsp>Click to go back to Inbox</a>
</form>
</body>
</html>
