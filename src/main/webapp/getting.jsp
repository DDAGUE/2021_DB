<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Phase2</title>
<link rel="stylesheet" href="css/custom.css">

</head>
<body>
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	String sql = "";
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
%>

<%
	String fid = "1";
	
	sql = "select fdate, name, host_name, contact_number, state, town_city, festival_category, contents, holding_term , holding_location" +
	", hosting_method, festival_subject "+
		"from festival f, host h, place p, location l, information i " +
			"where h.hid = f.fhid and p.pfid = f.id and p.plid = l.lid and i.fid = f.id and f.id = " + fid;
	
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	
	String name;
	
	while(rs.next())
	{
		String fdate = rs.getString(1);
		name = rs.getString(2);
		String host_name = rs.getString(3);
		String contact_number = rs.getString(4);
		String state = rs.getString(5);
		String town_city = rs.getString(6);
		String festival_category = rs.getString(7);
		String contents = rs.getString(8);
		String holding_term = rs.getString(9);
		String holding_location = rs.getString(10);
		String holding_method = rs.getString(11);
		String festival_subject = rs.getString(12);
		
		String [] splited_contents = contents.split("○");
		String temp = "";
		
		for(int i = 1; i < splited_contents.length; i++)
		{
			temp += ("&nbsp;&nbsp;&nbsp;○ "+ splited_contents[i] + "</br>");	
		}
		
		contents = "</br></br>"+temp;
		out.print("<p align=\"center\">");
		out.print("<h3>" + name); out.print("</h3></br>");
		out.print("축제 날짜 : " + fdate);out.print("</br>");
		out.print("축제 종류 : " + festival_category);out.print("</br>");
		out.print("축제 기간 : " + holding_term);out.print("</br>");
		out.print("축제 개최법 : " + holding_method);out.print("</br>");
		out.print("축제 위치 : " + state + ", " + town_city + ", " + holding_location);out.print("</br>");
		out.print("축제 주제 : " + festival_subject);out.print("</br>");
		out.print("축제 내용 : " + contents);out.print("</br>");
		out.print("축제 개최 기관 : " + host_name);out.print("</br>");
		out.print("축제 개최자 번호 : " + contact_number);out.print("</br>");
		out.print("</p>");
		
		
	}
	
	out.print("<div>");
	out.print("<form method =\"post\" action=\"review.jsp?&fid="+fid+"\">");
	out.print("<input type=\"text\" class=\"form-control\" placeholder=\"작성자\" name=\"bbsTitle\" maxlength=\"50\">");
	out.print("<textarea class=\"form-control\" placeholder=\"글 내용\" name=\"bbsContent\" maxlength=\"2048\" style=\"height: 200px;\"></textarea>");
	out.print("<input type=\"text\" class=\"form-control\" placeholder=\"평점\" name=\"bbsRating\" maxlength=\"50\">");
	out.print("<input type=\"submit\" class=\"btn btn-primary pull-right\" value=\"글쓰기\"></form></div>");
	
	

	out.print("<div class=\"container\"> <div class=\"row\"> <table class=\"table table-striped\" style=\"text-align: left; border: 1px solid #dddddd\"><thead>"+
			"<tr><th width=\"10%\" style=\"background-color: #eeeeee; text-align: center;\">작성자</th>"+
				"<th width=\"10%\" style=\"background-color: #eeeeee; text-align: center;\">평가</th>"+
				"<th width=\"80%\" style=\"background-color: #eeeeee; text-align: center;\">내용</th></tr></thead><tbody>");
	
	
	String review_sql = "select * from review where fid = " + fid;
	pstmt = conn.prepareStatement(review_sql);
	rs = pstmt.executeQuery();
	while(rs.next()){
		String Rauthor = rs.getString(2);
		String Rpwd = rs.getString(3);
		int Rstar = rs.getInt(5);
		String Rcontent = rs.getString(6);
		out.print("<tr>");
		out.print("<td>" + Rauthor + "</td>");
		out.print("<td>" + Rstar + "</td>");
		out.print("<td>" + Rcontent + "</td>");
		out.print("</tr>");
	}
	
	out.print("	</tbody></table></div></div>");
	

	rs.close();
	pstmt.close();
	conn.close();
%>
	<!-- 게시판 메인 페이지 영역 시작 -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>