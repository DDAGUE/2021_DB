<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEAM_놀러가조</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
        <style>
		body{
        	background-color : #fff;
        }
		</style>
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String rid = request.getParameter("rid");
	String fid = request.getParameter("fid");
	
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "COMPANY";
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
	
	Savepoint p1 = conn.setSavepoint();
	   
	pstmt = conn.prepareStatement(sql);
	   
	int s = pstmt.executeUpdate();
	   
	if(s == 0)
	{
	   out.print("삭제중 에러가 발생했습니다. ");
	   conn.rollback(p1);
	}
	   
	conn.commit();
	   
	pstmt.close();
	conn.close();
	   
	out.print("<h3> 리뷰 삭제가 완료되었습니다. </h3>");
	
	out.print("<button type=\"button\" onClick=\"location.href='getting.jsp?&fid="+fid+"'\"> 돌아가기  </button>");
%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
</body>
</html>