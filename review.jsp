<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR" />
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
        	background-color : #2D2D2D;
        }
	</style>
</head>
<body>


<%
	request.setCharacterEncoding("euc-kr");
	String rauthor = request.getParameter("bbsTitle");
	String rcontents= request.getParameter("bbsContent");
	String fid = request.getParameter("fid");
	String rstar = request.getParameter("bbsRating");
	String rpwd = "1234"; 
	
	String serverIP = "localhost";
	String strSID = "XE";
	String portNum = "1521";
	String user = "COMPANY";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	String sql = "insert into review values(rid_sequence.NEXTVAL,'"+ rauthor +"', '"+ rpwd + "',"+ fid +", "+ rstar + ", '" + rcontents+ "' )"; 
	
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	conn.setAutoCommit(false);
	
	pstmt = conn.prepareStatement(sql);
	
	pstmt.executeUpdate();
	
	conn.commit();
	
	pstmt.close();
	conn.close();
	
	out.print("<h3> 리뷰 작성이 완료되었습니다. </h3>");
	
	out.print("<button type=\"button\" onClick=\"location.href='getting.jsp?&fid="+fid+"'\"> 돌아가기 </button>");
%>
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>

</body>
</html>