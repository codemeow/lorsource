<%@ page contentType="text/html; charset=koi8-r"%>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Statement,java.util.logging.Logger" errorPage="/error.jsp"%>
<%@ page import="ru.org.linux.site.MessageNotFoundException"%>
<%@ page import="ru.org.linux.site.MissingParameterException"%>
<%@ page import="ru.org.linux.site.Template"%>
<%@ page import="ru.org.linux.site.User" %>
<% Template tmpl = new Template(request, config, response);
  Logger logger = Logger.getLogger("ru.org.linux");
%>
<%= tmpl.head() %>
	<title>����� ������ ������ ������������</title>
<%= tmpl.DocumentHeader() %>

<%
if (!tmpl.isModeratorSession()) {
  throw new IllegalAccessException("Not authorized");
}
%>

<%
   if (request.getMethod().equals("GET")) {
   	if (request.getParameter("msgid")==null)
		throw new MissingParameterException("msgid");

        Connection db = null;

        try {

        int msgid = tmpl.getParameters().getInt("msgid");

	db = tmpl.getConnection("setpostscore");

	Statement st = db.createStatement();
	ResultSet rq = st.executeQuery("SELECT groupid, section, groups.title, postscore FROM topics, groups WHERE topics.id="+msgid+" AND topics.groupid=groups.id");
	if (!rq.next())
		throw new MessageNotFoundException(msgid);
        int postscore = rq.getInt("postscore");

%>
<h1>����� ������ ������ ������������</h1>
������ ����� ������������� ��� ��������������� ����� � �������������,
������� ����� ������������� ���������.
<form method=POST action="setpostscore.jsp">
<input type=hidden name=msgid value="<%= msgid %>">
<br>
������� ������� ������: <%= (postscore<0?"������ ��� �����������":Integer.toString(postscore)) %>
<select name="postscore">
  <option value="0">0 - ��� �����������</option>
  <option value="50">50 - ��� ������������������</option>
  <option value="100">100 - ���� "������"</option>
  <option value="200">200 - ��� "������"</option>
  <option value="300">300 - ��� "������"</option>
  <option value="400">400 - ������ "������"</option>
  <option value="500">500 - ���� "�����"</option>
  <option value="-1">������ ��� �����������</option>
</select><br>
<%
	rq.close();
	st.close();
	} finally {
          if (db!=null) db.close();
        }
%>
<input type=submit value="��������">
</form>
<%
   } else {
        int msgid = tmpl.getParameters().getInt("msgid");
        int postscore = tmpl.getParameters().getInt("postscore");

        if (postscore<-1) postscore=0;
        if (postscore>500) postscore=500;

        Connection db = null;
        try {

	db = tmpl.getConnection("setpostscore");
	db.setAutoCommit(false);
	PreparedStatement pst=db.prepareStatement("UPDATE topics SET postscore=? WHERE id=?");
	pst.setInt(1, postscore);
	pst.setInt(2, msgid);

	User user=new User(db, Template.getNick(session));
	user.checkCommit();

	pst.executeUpdate();

        out.print("���������� ����� ������� ������ "+(postscore<0?"������ ��� �����������":Integer.toString(postscore)));

	logger.info("���������� ����� ������� ������ "+postscore+" ��� "+msgid+" ������������� "+user.getNick());

	pst.close();
	db.commit();

        } finally {
          if (db!=null) db.close();
        }
   }
%>
<%=	tmpl.DocumentFooter() %>
