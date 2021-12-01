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
	<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>TEAM_놀러가조</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body>
<%
 String serverIP = "localhost";
 String strSID = "orcl";
 String portNum = "1521";
 String user = "COMPANY";
 String pass = "comp322";
 String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
 
 Connection conn = null;
 PreparedStatement pstmt = null;
 ResultSet rs = null;
 Class.forName("oracle.jdbc.driver.OracleDriver");
 conn = DriverManager.getConnection(url, user, pass);
 
String localStr = "";
int palid = 0;
String palid_str = request.getParameter("PALID_STR");
switch(palid_str){
case "seoul": palid = 1; localStr = "서울특별시"; break;
case "sejong": palid = 0; localStr = "세종특별'||CHR(13)||CHR(10)||'자치시청"; break;
case "incheon": palid = 4; localStr = "인천광역시"; break;
case "daejeon": palid = 6; localStr = "대전광역시"; break;
case "gwangju": palid = 5; localStr = "광주광역시"; break;
case "daegu": palid = 3; localStr = "대구광역시"; break;
case "ulsan": palid = 7; localStr = "울산광역시"; break;
case "busan": palid = 2; localStr = "부산광역시"; break;
case "gyeonggi-do": palid = 8; localStr = "경기도"; break;
case "gangwon-do": palid = 9; localStr = "강원도"; break;
case "chungcheongbuk-do": palid = 10; localStr = "충청북도"; break;
case "chungcheongnam-do": palid = 11; localStr = "충청남도"; break;
case "jeollabuk-do": palid = 12; localStr = "전라북도"; break;
case "jeollanam-do": palid = 13; localStr = "전라남도"; break;
case "gyeongsangbuk-do": palid = 14; localStr = "경상북도"; break;
case "gyeongsangnam-do": palid = 15; localStr = "경상남도"; break;
case "jeju-do": palid = 16; localStr = "제주도"; break;
}
		
if(localStr == "세종특별'||CHR(13)||CHR(10)||'자치시청")
	out.println("<h2>세종특별자치시청 전통시장 목록</h2>");
else
	out.println("<h2>" + localStr + " 전통시장 목록" + "</h2>");

String query = "SELECT MARKET_NAME, MARKET_ADDRESS "
	 + "FROM TRADITIONAL_MARKET, PLACE_AT "
	 + "WHERE TRADITIONAL_MARKET.MID = PLACE_AT.PAMID "
	 + "AND PLACE_AT.PALID = " + palid;

pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
out.println("<table border=\"1\">");
ResultSetMetaData rsmd = rs.getMetaData();
int cnt = rsmd.getColumnCount();
for(int i=1; i <= cnt; i++){
 out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
int number = 1;
while(rs.next()){
 out.println("<tr>");
 out.println("<td>"+ number++ + ". " + rs.getString(1) + "</td>");
 out.println("<td>"+ rs.getString(2) + "</td>");
 out.println("</tr>");
}
out.println("</table>");
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
</body>
</html>