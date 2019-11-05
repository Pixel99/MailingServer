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
<title>DynaMail</title>
<style type="text/css">
body,td,th {
	color: #000;
}
body {
	background-color: #FFF;
}
</style>
</head>

<body>
<table width="208" height="219" border="1" align="left">
  <tr>
    <th scope="col"><div align="center" style=color:#cc0000><a href=compose.html>Compose</a></div></th>
  </tr>
  <tr>
    <td><div align="center" style=color:#cc0000><a href=afterlogin.jsp>Inbox</a></div></td>
  </tr>
  <tr>
    <td><div align="center" style=color:#cc0000><a href=sentmails.jsp>Sent Mails</a></div></td>
  </tr>
  <tr>
    <td><div align="center" style=color:#cc0000><a href=drafts.jsp>Drafts</a></div></td>
  </tr>
  <tr>
    <td><div align="center" style=color:#cc0000><a href=trash.jsp>Trash</a></div></td>
  </tr>
</table>
<table width="1291" border="1" align="center">
  <tr>
    <th width="1364" scope="col"><div align="center">
      <h1>DynaMail Server</h1>
    </div></th>
  </tr>
  <%
	String name = (String)session.getAttribute("email");
	out.println("<tr>");
	out.println("<td><div align=center>Welcome "+name+" </div></td>");
	out.println("</tr>");
	
	try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","admin");
		st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from userdata_inbox");
		if(rs!=null)
		{
			while(rs.next())
			{
				if(rs.getString(2).equals(session.getAttribute("email")))
				{
					String sender=rs.getString(1);
					String subject=rs.getString(3);
					out.println("<tr><td>"+sender+"&emsp; <a href=inbox.jsp?subject="+subject+">"+rs.getString(3)+"</a></td></tr>");
				}
			}
		}
		else
		{
			out.println("<tr><td align=center>Inbox is empty</td></tr>");
		}
	}
	catch(Exception e)
	{
		out.println(e);
		e.printStackTrace();
	}
  %>
  <tr>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>


  <tr>
    <td height="26"><div align="center"> 
      <p>Developed by Jatin Soni    </p>
    </div></td>
  </tr>
</table>
<table width="208" height="342" border="1" align="left">
  <tr>
    <th height="280" colspan="2" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <td><div align="center"><a href=setting.jsp style=color:#cc0000>Settings</a></div></td>
    <td><div align="center"><a href=logout.jsp style=color:#cc0000>Logout</div></td>
  </tr>
</table>
<div align="right"></div>
</body>
</html>
