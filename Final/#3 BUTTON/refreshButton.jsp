<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="3; url=http://sc1.swu.ac.kr/~yebbnrjs/refreshButton.jsp">
<title>버튼상태 조회</title>
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
<h1>버튼상태 조회</h1>
	<table border="1">
		<tr>
			<th>시간</th>
			<th>버튼상태</th>
		</tr>
		<%
			String url = "jdbc:mysql://sc1.swu.ac.kr:13306/yebbnrjs_ts";
			String user = "yebbnrjs", pw = "yebbnrjs90";

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			Class.forName("org.mariadb.jdbc.Driver");

			con = DriverManager.getConnection(url, user, pw);

			String sql = "SELECT * FROM (SELECT regDate, OnOff FROM BUTTON b ORDER BY regDate DESC LIMIT 5) q ORDER BY regDate";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String regDate = rs.getString("regDate");
				String OnOff = rs.getString("OnOff");
		%>
		<tr>
			<td><%=regDate%></td>
			<td><%=OnOff%></td>
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