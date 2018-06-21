<%@page language="java" contentType="text/xml" %><%@page import="java.util.Map" %><%@page import="javax.servlet.http.HttpServletRequest" %><%!
  /** retrieving XML data from the text field of the response */
  private String getMsg(HttpServletRequest req) {
    String msg = null, key = req.getContextPath();
    Map data = (Map) req.getAttribute(key);
    if (data == null || !data.containsKey("text"))
      msg = "<msg><Name>" + key + "</Name><Error>" +
        (String) req.getAttribute("error") + "</Error></msg>";
    else
      msg = (String) data.get("text");
    return msg;
  }
%>
<%=getMsg(request) %>
