<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="style.css" rel="stylesheet"/>
<body>
<jsp:include page="header.jsp"/>
<section>
	<h2><b>참가자 목록 조회</b></h2>
	<form>
		<table border=1>
			<tr>
				<td>참가번호</td>
				<td>참가자명</td>
				<td>생년월일</td>
				<td>성별</td>
				<td>특기</td>
				<td>소속사</td>
				<% /* 자바 DB 연동 샘플 소스코드 */
					try{
						Class.forName("oracle.jdbc.OracleDriver");
						Connection con = DriverManager.getConnection

						("jdbc:oracle:thin:@//localhost:1521/xe","system","1234");

						Statement stmt = con.createStatement();
						ResultSet rs = stmt.executeQuery("select * from tbl_artist_201905 order by artist_id");
						while(rs.next()){
							String birth = rs.getString(3);
							String birth2 = birth.substring(0,4) + "년" + birth.substring(4,6) + "월" + birth.substring(6,8) + "일";
							String gender = rs.getString(4);
							if(gender.equals("F")) gender="여";
							else gender = "남";
							String talent = rs.getString(5);
							if(talent.equals("1")) talent="보컬";
							else if(talent.equals("2")) talent="댄스";
							else talent="랩";
							%>
								<tr>
									<td><%=rs.getString(1) %></td>
									<td><%=rs.getString(2) %></td>
									<td><%=birth2 %></td>
									<td><%=gender %></td>
									<td><%=talent %></td>
									<td><%=rs.getString(6) %></td>
								</tr>
							<%
						}
						stmt.close();
						con.close();
					}catch(Exception e){
						e.printStackTrace();
					}
				%>
			</tr>
		</table>
	</form>
</section>
</body>
</html>