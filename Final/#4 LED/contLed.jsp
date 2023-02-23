<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LED 제어</title>
</head>
<body>
  <%
    BufferedReader reader = null;
    try {
      String filePath = application.getRealPath("/Data/LedControl.txt");
      reader = new BufferedReader(new FileReader(filePath));
      while (true) {
        String str = reader.readLine();
        if (str == null)
          break;
        out.println(str);
      }
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
    // process = Runtime.getRuntime().exec(command + filePath);
// command + filePath
// chmod 666 /home/diy/yebbnrjs/html/Data/LedControl.txt

  %>
</body>
</html>