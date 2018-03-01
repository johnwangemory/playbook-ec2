<%@page language="java" contentType="application/json" %><%@page import="java.util.Map" %><%@page import="javax.servlet.http.HttpServletRequest" %><%!
  /** retrieving JSON data from the text field of the response */
  private String getMsg(HttpServletRequest req) {
    String msg = null, key = req.getContextPath();
    Map data = (Map) req.getAttribute(key);
    if (data == null || !data.containsKey("text"))
      msg = "{\"success\":false,\"errors\":{\"title\":\"" + key + "\"}," +
        "\"errormsg\":\"" + (String) req.getAttribute("error") + "\"}";
    else
      msg = (String) data.get("text");
    return msg;
  }
%><%=getMsg(request) %>
