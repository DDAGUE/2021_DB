<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String rid = request.getParameter("rid");
	String fid = request.getParameter("fid");
	
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	String sql = "delete from review where rid = " + rid; 
	
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	conn.setAutoCommit(false);
	
	pstmt = conn.prepareStatement(sql);
	
	pstmt.executeUpdate();
	
	conn.commit();
	
	pstmt.close();
	conn.close();
	
	out.print("<h3> 리뷰 삭제가 완료되었습니다. </h3>");
	
	out.print("<button type=\"button\" onClick=\"location.href='getting.jsp?&fid="+fid+"'\"> 돌아가기 </button>");
%>

</body>
</html>