<!--
gyeongseob_seo
2015114219
 -->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://unpkg.com/mvp.css">
<meta charset="UTF-8">
<title>Korea Festival List_Local</title>
</head>
<body>
<%
 String serverIP = "localhost";
 String strSID = "XE";
 String portNum = "1521";
 String user = "university";
 String pass = "comp322";
 String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
 
 Connection conn = null;
 PreparedStatement pstmt = null;
 ResultSet rs = null;
 Class.forName("oracle.jdbc.driver.OracleDriver");
 conn = DriverManager.getConnection(url, user, pass);
 
 String enumStr = "";
 Enumeration paramEnum = request.getParameterNames();
 while(paramEnum.hasMoreElements()){
	 enumStr = (String)paramEnum.nextElement();
 }
 String localStr = "";
 switch(enumStr){
 case "seoul": localStr = "서울특별시"; break;
 case "sejong": localStr = "세종특별'||CHR(13)||CHR(10)||'자치시청"; break;
 case "incheon": localStr = "인천광역시"; break;
 case "daejeon": localStr = "대전광역시"; break;
 }
 
 String Seoul = request.getParameter("seoul");
 String Sejong = request.getParameter("sejong");
 String Incheon = request.getParameter("incheon");
 String Daejeon = request.getParameter("daejeon");
 String Gwangju = request.getParameter("gwangju");
 String Daegu = request.getParameter("daegu");
 String Ulsan = request.getParameter("ulsan");
 String Busan = request.getParameter("busan");
 String Gyeonggi = request.getParameter("gyeonggi-do");
 String Gangwon = request.getParameter("gangwon-do");
 String Chungcheongbuk = request.getParameter("chungcheongbuk-do");
 String Chungcheongnam = request.getParameter("chungcheongnam-do");
 String Jeollabuk = request.getParameter("jeollabuk-do");
 String Jeollanam = request.getParameter("jeollanam-do");
 String Gyeongsangbuk = request.getParameter("gyeongsangbuk-do");
 String Gyeongsangnam = request.getParameter("gyeongsangnam-do");
 String Jeju = request.getParameter("jeju-do");
%>

<h4>Test for Click Seoul</h4>
<!-- Click Seoul -->
<%
String query = "SELECT NAME "
	 + "FROM FESTIVAL, LOCATION "
	 + "WHERE FESTIVAL.ID = LOCATION.LID "
	 + "AND LOCATION.STATE = '" + localStr + "'";
System.out.println(enumStr);
System.out.println(localStr);
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
out.println("<table border=\"1\">");
ResultSetMetaData rsmd = rs.getMetaData();
rsmd = rs.getMetaData();
int cnt = rsmd.getColumnCount();
for(int i=1; i <= cnt; i++){
 out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while(rs.next()){
 out.println("<tr>");
 out.println("<td>"+rs.getString(1)+"</td>");
 out.println("</tr>");
}
out.println("</table>");
%>
</body>
</html>