<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head></head>
    <body>
        <style>
        #title {
            width: 100%;
            height: 50px;
            background: black;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #frame {
            width: 100%;
            height: 300px;
        }
        </style>
        <div id="title">iFrame</div>
        <iframe id="LED" src="http://sc1.swu.ac.kr/~yebbnrjs/LedSetting.jsp" width="1500" height="200"></iframe>
        <iframe id="database" src="http://sc1.swu.ac.kr/~yebbnrjs/RefreshSensor.jsp" width="1500" height="500"></iframe>
    </body>
</html>