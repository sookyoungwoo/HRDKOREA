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
				<td>총접</td>
				<td>평균</td>
				<td>등수</td>
				<% /* 자바 DB 연동 샘플 소스코드 */
					try{
						Class.forName("oracle.jdbc.OracleDriver");
						Connection con = DriverManager.getConnection

						("jdbc:oracle:thin:@//localhost:1521/xe","system","1234");

						Statement stmt = con.createStatement();                 
						ResultSet rs = stmt.executeQuery("select ar.artist_id as aid, artist_name, sum(score), TO_CHAR(avg(score),'99.99'), rank() over(order by sum(score) desc) from tbl_artist_201905 ar, tbl_point_201905 po where ar.artist_id = po.artist_id group by ar.artist_id, artist_name");
						while(rs.next()){
							
							%>
							<tr>
								<td><%=rs.getString(1) %></td> 
								<td><%=rs.getString(2) %></td>
								<td><%=rs.getString(3) %></td>
								<td><%=rs.getString(4) %></td>
								<td><%=rs.getString(5) %></td>
							</tr>
							<%
						}
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