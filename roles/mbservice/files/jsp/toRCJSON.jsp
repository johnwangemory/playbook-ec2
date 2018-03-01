<%@page language="java" contentType="application/json" %><%@page import="java.util.Map" %><%@page import="javax.servlet.http.HttpServletRequest" %><%!
  /** retrieving ReturnCode from the response and returns an XML */
  private String getRC(HttpServletRequest req) {
    String msg = null, key = req.getContextPath();
    Map data = (Map) req.getAttribute(key);
    if (data == null || !data.containsKey("name"))
      msg = "{\n  \"success\":false,\n  \"errors\":{\"title\":\"" + key +
        "\"},\n  " + "\"errormsg\":\"" + (String) req.getAttribute("error") +
        "\"}";
    else { // get rc and name
      String line = (String) data.get("ReturnCode");
      if (line == null)
          line = "";
      msg = "{\n  \"success\":true,\n  \"data\":{\n   \"name\":\"" +
          (String) data.get("name") + "\",\n    \"rc\":\"" + line + "\"}\n}";
    }
    return msg;
  }
%>
<%=getRC(request) %>
