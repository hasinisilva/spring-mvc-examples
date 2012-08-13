<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="isSearchPage" value="${param.title != null}" />
<c:set var="title"
	value="${isSearchPage ? 'Search Books' : 'Book List'}" />
<c:set var="morePages"
	value="${nextResult != null || prevResult != null}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><c:out value="${title}" /></title>
</head>
<body>
<h2><c:out value="${title}" /></h2>
<a href="<c:url value="."/>">book list</a>
&nbsp;
<a href="<c:url value="searchForm"/>">search books</a>
&nbsp;
<a href="<c:url value="addForm"/>">add book</a>
<c:choose>
	<c:when test="${empty(books)}">
		<c:choose>
			<c:when test="${isSearchPage}">
				<p>Library has no books starting with '<c:out
					value="${param.title}" />'.</p>
			</c:when>
			<c:otherwise>
				<p>Library has no books.</p>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:if test="${isSearchPage}">
			<br />
			<br />
			<c:url var="action" value="/library/books/search" />
			<form action="${action}" method="GET">
			<table>
				<tr>
					<th>Title</th>
					<td><input type="text" name="title" value="${param.title}" /></td>
				</tr>
				<tr>
					<td rowspan="2""><input type="submit" name="submit"
						value="Search" /></td>
				</tr>
			</table>
			</form>
		</c:if>
		<p>Displaying <c:choose>
			<c:when test="${morePages}">
				<c:choose>
					<c:when test="${count == 1}">
						<c:out value="${firstResult + 1}" /> of <c:out value="${total}" />
					</c:when>
					<c:otherwise>
						<c:out value="${firstResult + 1}" /> - <c:out
							value="${firstResult + count}" /> of <c:out value="${total}" />
					</c:otherwise>
				</c:choose>
				book<c:if test="${total > 1}">s</c:if>
			</c:when>
			<c:otherwise>
				<c:out value="${count}" />
				<c:if test="${total > 1}"> of <c:out value="${total}" />
				</c:if> book<c:if test="${total > 1}">s</c:if>
			</c:otherwise>
		</c:choose> <c:if test="${isSearchPage}"> starting with '<c:out
				value="${param.title}" />'</c:if></p>
		<p />
		<table>
			<tr>
				<th>Title</th>
				<th>Author</th>
				<th>&nbsp;</th>
			</tr>
			<c:forEach items="${books}" var="book">
				<c:url var="viewUrl" value="/library/books/book/${book.bookId}/" />
				<c:url var="editUrl"
					value="/library/books/book/${book.bookId}/editForm" />
				<tr>
					<td><a href="<c:out value="${viewUrl}"/>"><c:out
						value="${book.title}" /></a></td>
					<td><c:out value="${book.author}" /></td>
					<td><a href="${editUrl}">edit</a></td>
				</tr>
			</c:forEach>
			<c:if test="${morePages}">
				<tr>
					<td colspan="3">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<c:choose>
								<c:when test="${prevResult != null}">
									<td width="50%"><a
										href="?<c:if test="${isSearchPage}">title=<c:out value="${param.title}"/>&</c:if>firstResult=<c:out value="${prevResult}" />">previous&nbsp;<c:out
										value="${maxResults}" /></a></td>
								</c:when>
								<c:otherwise>
									<td width="50%">&nbsp;</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${nextResult != null}">
									<td width="50%" align="right"><a
										href="?<c:if test="${isSearchPage}">title=<c:out value="${param.title}"/>&</c:if>firstResult=<c:out value="${nextResult}" />">next&nbsp;<c:out
										value="${maxResults}" /></a></td>
								</c:when>
								<c:otherwise>
									<td width="50%" align="right">&nbsp;</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
					</td>
				</tr>
			</c:if>
		</table>
	</c:otherwise>
</c:choose>
<hr>
request:
<c:out value="${param}" />
<br />
<br />
model:
<br />
<br />
books:
<c:out value="${books}" />
<br />
total:
<c:out value="${total}" />
<br />
count:
<c:out value="${count}" />
<br />
firstResult:
<c:out value="${firstResult}" />
<br />
nextResult:
<c:out value="${nextResult}" />
<br />
prevResult:
<c:out value="${prevResult}" />
<br />
maxResults:
<c:out value="${maxResults}" />
</body>
</html>
