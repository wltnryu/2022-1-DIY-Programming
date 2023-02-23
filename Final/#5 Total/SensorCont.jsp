<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최종</title>
</head>
<body>
<%@include file="contLed.jsp"%>
<%

request.setCharacterEncoding("UTF-8");

String Temperature = request.getParameter("temp");
String Humidity = request.getParameter("moisture");
String sBtnVal = request.getParameter("BUTTON");

Connection con = null;
PreparedStatement pstmt = null;

String url = "jdbc:mysql://sc1.swu.ac.kr:13306/yebbnrjs_ts"; 
String user = "yebbnrjs";
String pw = "yebbnrjs90";

Class.forName("org.mariadb.jdbc.Driver");

con = DriverManager.getConnection(url, user, pw);

String sql = "insert into SENSOR "
			   + "(buttonDate, buttonOnOff, Temperature, Humidity)"
			   + "values "
			   +"( now(), ?, ?, ?)";

pstmt = con.prepareStatement(sql);
pstmt.setString(1, sBtnVal);
pstmt.setString(2, Temperature);
pstmt.setString(3, Humidity);

pstmt.executeUpdate();

pstmt.close();
con.close();

%>
<script>
alert("저장 성공!");
</script>
</body>
</html>