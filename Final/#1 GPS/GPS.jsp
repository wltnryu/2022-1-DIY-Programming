<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 정보 저장</title>
</head>
<body>
<%

request.setCharacterEncoding("UTF-8");

String Lat = request.getParameter("Latitude");
String Long = request.getParameter("Longitude");
String Sp = request.getParameter("Speed");
String Co = request.getParameter("Course");

Connection con = null;
PreparedStatement pstmt = null;

String url = "jdbc:mysql://sc1.swu.ac.kr:13306/yebbnrjs_ts"; 
String user = "yebbnrjs";
String pw = "yebbnrjs90";

Class.forName("org.mariadb.jdbc.Driver");

con = DriverManager.getConnection(url, user, pw);

String sql = "INSERT INTO GPSpro (regDate, Latitude, LatDirec, Longitude, LongDirec, Speed, Course) VALUES (now(), ?, 'N', ?, 'E', ?, ?)";

pstmt = con.prepareStatement(sql);
pstmt.setString(1, Lat);
pstmt.setString(2, Long);
pstmt.setString(3, Sp);
pstmt.setString(4, Co);

pstmt.executeUpdate();

pstmt.close();
con.close();
%>
<script>
alert("저장 성공!");
location.href = 'insert.jsp';
</script>
</body>
</html>