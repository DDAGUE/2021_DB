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
 
 request.setCharacterEncoding("utf-8");
 String searchFestival = request.getParameter("searchFestival");

out.println("<h2 class=\"mt-4 text-white\">'" + searchFestival + "' 관련 축제 목록" + "</h2>");
%>
	<div class="card mb-4">
<%
out.println("<div class = \"card-header\">");
out.println("</div>");
String query = "SELECT NAME, ID "
	 + "FROM FESTIVAL "
	 + "WHERE FESTIVAL.NAME LIKE '%" + searchFestival + "%'";

pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
%>

		<div class = "card-body">
			<div class="dataTable-container">

<%
out.println("<table class=\"dataTable-table\" border=\"1\">");
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
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
</body>
</html>