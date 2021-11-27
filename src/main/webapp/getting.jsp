<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Phase2</title>
<link rel="stylesheet" href="css/custom.css">
<style>
.scrolltbody {
    display: block;
    width: 700px;
    border-collapse: collapse;
    border: 2px solid #000;
}
.scrolltbody table {
	width: 100%
}
.scrolltobyd table thead {width: 100%;}
.scrolltbody th { border: 1px solid #000; background: pink; }
.scrolltbody td { border: 1px solid #000; border-top: 0; }
.scrolltbody tbody {
    display: block;
    width: 100%;
    height: 500px;
    overflow: auto;
}
.scrolltbody th:nth-of-type(1), .scrolltbody td:nth-of-type(1) { width: 10%; }
.scrolltbody th:nth-of-type(2), .scrolltbody td:nth-of-type(2) { width: 10%; }
.scrolltbody th:nth-of-type(3), .scrolltbody td:nth-of-type(3) { width: 80%; }

</style>
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
		
		String [] splited_contents = contents.split("��");
		String temp = "";
		
		for(int i = 1; i < splited_contents.length; i++)
		{
			temp += ("&nbsp;&nbsp;&nbsp;�� "+ splited_contents[i] + "</br>");	
		}
		
		contents = "</br></br>"+temp;
		out.print("<p align=\"center\">");
		out.print("<h3>" + name); out.print("</h3></br>");
		out.print("���� ��¥ : " + fdate);out.print("</br>");
		out.print("���� ���� : " + festival_category);out.print("</br>");
		out.print("���� �Ⱓ : " + holding_term);out.print("</br>");
		out.print("���� ���ֹ� : " + holding_method);out.print("</br>");
		out.print("���� ��ġ : " + state + ", " + town_city + ", " + holding_location);out.print("</br>");
		out.print("���� ���� : " + festival_subject);out.print("</br>");
		out.print("���� ���� : " + contents);out.print("</br>");
		out.print("���� ���� ��� : " + host_name);out.print("</br>");
		out.print("���� ������ ��ȣ : " + contact_number);out.print("</br>");
		out.print("</p>");
		
		
	}
	out.print("<hr/>");
	out.print("<div style=\" position: relative \">");
	out.print("<form method =\"post\" action=\"review.jsp?&fid="+fid+"\">");
	out.print("<div style=\"height: 60px; width: 110px ;position: relative ;display: inline-block \">");
	out.print("<input type=\"text\"  placeholder=\"�ۼ���\" name=\"bbsTitle\" maxlength=\"50\"style=\"height: 20px; width: 100px; \">");
	out.print("<input type=\"text\"  placeholder=\"����\" name=\"bbsRating\" maxlength=\"50\"style=\"height: 20px; width: 100px; \">");
	out.print("</div>");
	out.print("<div style=\"height: 60px; width: 600px ;position: relative; display: inline\">");
	out.print("<textarea placeholder=\"�� ����\" name=\"bbsContent\" maxlength=\"2048\" style=\"height: 40px; width: 650px\"></textarea>");
	out.print("</div>");
	out.print("<div style=\" height: 60px; width: 80px; position:relative; display: inline \">");
	out.print("<input style=\" height: 40px \" type=\"submit\"  value=\"�۾���\">");
	out.print("</div></form>");
	out.print("</div>");
	
	out.print("<hr/>");

	out.print("<div > <div class=\"row\"> <table class='scrolltbody' style=\"text-align: left; border: 1px solid #dddddd\"><thead>"+
			"<tr><th style=\"background-color: #eeeeee; text-align: center;\">�ۼ���</th>"+
				"<th  style=\"background-color: #eeeeee; text-align: center;\">��</th>"+
				"<th  style=\"background-color: #eeeeee; text-align: center;\">����</th></tr></thead><tbody>");
	
	
	String review_sql = "select * from review where fid = " + fid;
	pstmt = conn.prepareStatement(review_sql);
	rs = pstmt.executeQuery();
	while(rs.next()){
		int rid = rs.getInt(1);
		String Rauthor = rs.getString(2);
		String Rpwd = rs.getString(3);
		int Rstar = rs.getInt(5);
		String Rcontent = rs.getString(6);
		out.print("<tr>");
		out.print("<td>" + Rauthor + "</td>");
		out.print("<td>" + Rstar + "</td>");
		out.print("<td>" + Rcontent + "<Button onclick=\"location.href='deleterating.jsp?&rid="+ rid +"&fid="+fid+"'\" style=\" float: right\">X</Button></td>");
		out.print("</tr>");
	}
	
	out.print("	</tbody></table></div></div>");
	

	rs.close();
	pstmt.close();
	conn.close();
%>
	<!-- �Խ��� ���� ������ ���� ���� -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>