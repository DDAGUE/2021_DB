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
<title>Search List for Festival</title>
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
 
 request.setCharacterEncoding("utf-8");
 String searchFestival = request.getParameter("searchFestival");
 out.println(searchFestival);

out.println("<h2>'" + searchFestival + "' 관련 축제 목록" + "</h2>");

String query = "SELECT NAME, ID "
	 + "FROM FESTIVAL "
	 + "WHERE FESTIVAL.NAME LIKE '%" + searchFestival + "%'";

pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
out.println("<table border=\"1\">");
ResultSetMetaData rsmd = rs.getMetaData();
int cnt = rsmd.getColumnCount();
for(int i=1; i <= 1; i++){
 out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
int number = 1;
while(rs.next()){
 out.println("<tr>");
 out.println("<td>" + number + ". <a href='getting.jsp?&fid="+rs.getInt(2)+"'>"+rs.getString(1)+"</a></td>");
 out.println("</tr>");
 number++;
}
out.println("</table>");
%>
</body>
</html>