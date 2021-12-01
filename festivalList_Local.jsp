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
	<style>
        body{
        	background-color : #2D2D2D;
        }
        button {
    		width:100px;
    		background-color: #47C83E;
    		border: none;
    		color:#000;
    		padding: 15px 0;
    		text-align: center;
    		text-decoration: none;
    		display: inline-block;
    		font-size: 15px;
    		margin: 4px;
    		cursor: pointer;
		}
    </style>
</head>
<body>
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <!-- Navbar Brand-->
    	<a class="navbar-brand ps-3" href="main.html">전국 축제 안내</a>
        <!-- Navbar Search-->
        <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" method="POST" action="searchList.jsp">
            <div class="input-group">
                <input name="searchFestival" class="form-control" type="text" placeholder="키워드를 검색해보세요..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                <button class="btn btn-primary" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
            </div>
        </form>
     </nav>

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
 case "gwangju": localStr = "광주광역시"; break;
 case "daegu": localStr = "대구광역시"; break;
 case "ulsan": localStr = "울산광역시"; break;
 case "busan": localStr = "부산광역시"; break;
 case "gyeonggi-do": localStr = "경기도"; break;
 case "gangwon-do": localStr = "강원도"; break;
 case "chungcheongbuk-do": localStr = "충청북도"; break;
 case "chungcheongnam-do": localStr = "충청남도"; break;
 case "jeollabuk-do": localStr = "전라북도"; break;
 case "jeollanam-do": localStr = "전라남도"; break;
 case "gyeongsangbuk-do": localStr = "경상북도"; break;
 case "gyeongsangnam-do": localStr = "경상남도"; break;
 case "jeju-do": localStr = "제주도"; break;
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
//out.println("<div style=\"position: relative\">");
if(localStr == "세종특별'||CHR(13)||CHR(10)||'자치시청")
	out.println("<h2 class = \"mt-4 text-white\">세종특별자치시청 축제 목록</h2>");
else
	out.println("<h2 class = \"mt-4 text-white\">" + localStr + " 축제 목록" + "</h2>");
%>
	<div class = "card mb-4" style="position: relative;">
<%

out.println("<div class = \"card-header\">");
out.println("</div>");

out.println("<div>");
out.println("<Button onclick=\"location.href='traditionalList.jsp?&PALID_STR="+ enumStr +"'\">전통시장 목록</Button>");
out.println("</div>");

String query = "SELECT NAME, ID "
	 + "FROM FESTIVAL, LOCATION "
	 + "WHERE FESTIVAL.ID = LOCATION.LID "
	 + "AND LOCATION.STATE = '" + localStr + "'";

pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
%>
		<div class = "card-body">
			<div class="dataTable-container">
<%
out.println("<table class = \"dataTable-table\" border=\"1\">");
ResultSetMetaData rsmd = rs.getMetaData();
int cnt = rsmd.getColumnCount();
for(int i=1; i <= 1; i++){	
 out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
int number = 1;
while(rs.next()){
 out.println("<tr>");
 out.println("<td>" + number++ + ". <a href='getting.jsp?&fid="+rs.getInt(2)+"'>"+rs.getString(1)+"</a></td>");
 out.println("</tr>");
}
out.println("</table>");
%>
			</div>
	</div> <!-- div card end -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
</body>
</html>