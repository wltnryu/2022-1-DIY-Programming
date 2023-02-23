<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%
// Write Control Data File
    request.setCharacterEncoding("utf-8");
    String sLedCtrl = request.getParameter("led");

    if(sLedCtrl != null) {
        PrintWriter writer = null;
        try {
            String filePath = application.getRealPath("/Data/LedControl.txt");
            writer = new PrintWriter(filePath);
            writer.print("led="+sLedCtrl);
            Connection con = null;
            PreparedStatement pstmt = null;

            String url = "jdbc:mysql://sc1.swu.ac.kr:13306/yebbnrjs_ts"; 
            String user = "yebbnrjs";
            String pw = "yebbnrjs90";

            Class.forName("org.mariadb.jdbc.Driver");

            con = DriverManager.getConnection(url, user, pw);

            String sql = "insert into LED "
			   + "(regDate, OnOff)"
			   + "values "
			   +"( now(), ? )";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, sLedCtrl);

            pstmt.executeUpdate();

            pstmt.close();
            con.close();

        } catch (Exception ioe) {
            out.println("파일에 데이터를 쓸 수 없습니다.");
            ioe.printStackTrace();
        } finally {
            try {
                writer.close();
            } catch (Exception e) {
            }
        }
    }
%>
<%
// Read Control Data File
BufferedReader reader = null;
String strLed = "";
String LedState = "";

try {
    String filePath = application.getRealPath("/Data/LedControl.txt");
    reader = new BufferedReader(new FileReader(filePath));
    strLed = reader.readLine();
    String[] getParas = strLed.split("="); 
    LedState = getParas[1];
} catch (FileNotFoundException fnfe) {
    out.println("파일이 존재하지 않습니다.");
} catch (IOException ioe) {
    out.println("파일을 읽을수 없습니다.");
} finally {
    try {
        reader.close();
    } catch (Exception e) {

    }
}

//String[] 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>LED 제어 생성</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" 
rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" 
crossorigin="anonymous">
</head>
<body>
<div class="row">
    <div class="col-12"><h3>LED 제어</h3> </div>
    <div class="col-12">LED 상태: <%=strLed%> </div>
</div>

<form name="ledControl" method="get">
<div class="form-check">
  <input class="form-check-input" type="radio" name="led" value="on" 
  <% if(LedState.equals("on")) out.print(" checked "); %> >LED On</div>
<div class="form-check">
  <input class="form-check-input" type="radio" name="led" value="off"
  <% if(LedState.equals("off")) out.print(" checked "); %> >LED Off</div>

<div class="row">
    <div class="col-12"><button type="submit" id="ledCont" class="btn btn-outline-success">LED 상태제어</button></div>
    </form>
</div>

    <!-- Optional JavaScript; choose one of the two! -->
    <!-- Option 1: Bootstrap Bundle with Popper -->

  </body>
  </html>

  