<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- head-main -->
<LINK REL=STYLESHEET TYPE="text/css" HREF="/black/style.css" TITLE="Normal">
<LINK REL="shortcut icon" HREF="/favicon.ico" TYPE="image/x-icon">
</head>
<body style="margin-top: 0">
<img style="float: left" src="/black/lorlogo.png" alt="Русская информация об ОС LINUX" width="270" height="208">

<div style="float: left" class="head-main">
<table>
<tr>
  <td><a href="/">Новости</a></td>
  <td><a href="/wiki/en/Linux">O linux</a></td>
  <td><a href="/wiki/en/%D0%94%D0%B8%D1%81%D1%82%D1%80%D0%B8%D0%B1%D1%83%D1%82%D0%B8%D0%B2%D1%8B">Дистрибутивы</a></td>
  <td><a href="server.jsp">О сервере</a></td>
</tr>
<tr>
  <td><a href="view-news.jsp?section=3">Галерея</a></td>
  <td><a href="view-section.jsp?section=2">Форум</a></td>
  <td><a href="/books">Документация</a></td>
  <td><a href="/wiki">Wiki</a></td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td></td>
  <td><a href="search.jsp">Поиск</a></td>
</tr>
</table>

<table class="adv" cellpadding="5" cellspacing="0" border="1" width="600" style="font-size: smaller" ><tr><td bgcolor="#000030">
<a target="_blank" href="http://www.linuxcenter.ru/linux-format-2009/"><b><center>Розыгрыш призов для подписчиков журнала Linux Format</center></b></a>
<a target="_blank" href="http://www.linuxcenter.ru/linux-format-2009/"><img src="/adv/id1996.gif" hspace='1' vspace='1' height="50" align="left" border="0" ></a>
<a target="_blank" href="http://www.linuxcenter.ru/linux-format-2009/"><img src="/adv/on.gif" hspace='0' vspace='0' height="50" align="right" border="0"></a>
<div  style="text-align: left">Подпишись на журнал Linux Format с 10 по 30 декабря и выиграй ASUS EEE PC 900! Разыгрываются 10 нетбуков и другие призы от ГНУ/Линуксцентра.</div>
<a target="_blank" href="http://www.linuxcenter.ru/linux-format-2009/"><b><center>www.linuxcenter.ru/linux-format-2009</center></b></a>
</td></tr></table>

  
</div>

<div style="right: 5px; text-align: right; top: 5px; position: absolute">
<c:if test="${template.sessionAuthorized}">
  <c:url var="userUrl" value="/whois.jsp">
    <c:param name="nick" value="${template.nick}"/>
  </c:url>
  добро пожаловать, <a style="text-decoration: none" href="${userUrl}">${template.nick}</a>
  <br>
  <img src="/black/pingvin.gif" alt="Linux Logo" height=114 width=102>
</c:if>

<c:if test="${not template.sessionAuthorized}">
  <div id="regmenu">
    <a style="text-decoration: none" href="/register.jsp">Регистрация</a> -
    <a style="text-decoration: none" href="/" onclick="showLoginForm(); return false;">Вход</a>
    <br>
    <img src="/black/pingvin.gif" alt="Linux Logo" height=114 width=102>
  </div>

  <form method=POST action="login.jsp" style="display: none" id="regform">
    Имя: <input type=text name=nick size=15><br>
    Пароль: <input type=password name=passwd size=15><br>
    <input type=submit value="Вход">
    <input type="button" value="Отмена" onclick="hideLoginForm(); return false">
  </form>
</c:if>
  </div>

<div style="clear: both"></div>
