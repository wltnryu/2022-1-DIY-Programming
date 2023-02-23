<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="3; url=http://sc1.swu.ac.kr/~yebbnrjs/refreshGps.jsp">
<title>GPS 조회</title>
<style>
table {
	border-collapse: collapse;
}

th {
	width: 100px;
	background-color: rgb(220, 186, 181);
	border-color: rgb(170, 116, 128);
}

td {
	text-align: center;
}
</style>
</head>
<body>
<h1>GPS 조회</h1>
	<table border="1">
		<tr>
			<th>시간</th>
			<th>위도</th>
			<th>위도위치</th>
            <th>경도</th>
            <th>경도위치</th>
            <th>속도</th>
            <th>진행방향</th>
		</tr>
		<%
			String url = "jdbc:mysql://sc1.swu.ac.kr:13306/yebbnrjs_ts";
			String user = "yebbnrjs", pw = "yebbnrjs90";

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			Class.forName("org.mariadb.jdbc.Driver");

			con = DriverManager.getConnection(url, user, pw);

			String sql = "SELECT * FROM (SELECT regDate, Latitude, LatDirec, Longitude, LongDirec, Speed, Course FROM GPSpro g ORDER BY regDate DESC LIMIT 5) q ORDER BY regDate";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String regDate = rs.getString("regDate");
				String Latitude = rs.getString("Latitude");
				String LatDirec = rs.getString("LatDirec");
                String Longitude = rs.getString("Longitude");
                String LongDirec = rs.getString("LongDirec");
                String Speed = rs.getString("Speed");
                String Course = rs.getString("Course");
		%>
		<tr>
			<td><%=regDate%></td>
			<td><%=Latitude%></td>
			<td><%=LatDirec%></td>
            <td><%=Longitude%></td>
            <td><%=LongDirec%></td>
            <td><%=Speed%></td>
            <td><%=Course%></td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		rs.close();
		pstmt.close();
		con.close();
	%>
	<br />
</body>
</html>