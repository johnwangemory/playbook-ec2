<%@page language="java" contentType="text/plain" %><%@page import="java.util.Map" %><%@page import="java.util.Iterator" %><%@page import="javax.servlet.http.HttpServletRequest" %><%!
  /** retrieving data from the response and returns them in a JSON */
  private String getMsg(HttpServletRequest req) {
    String msg = null, key = req.getContextPath();
    Map data = (Map) req.getAttribute(key);
    if (data == null || data.size() <= 0)
      msg = "{\n  \"success\":false,\n  \"errors\":{\"title\":\"" + key +
        "\"},\n  " + "\"errormsg\":\"" + (String) req.getAttribute("error") +
        "\"}";
    else { // copy items over
      Iterator iter = data.keySet().iterator();
      String line;
      StringBuffer strBuf = new StringBuffer();
      while (iter.hasNext()) {
        key = (String) iter.next();
        if (key == null || key.length() <= 0)
          continue;
        line = (String) data.get(key);
        if (line == null)
          line = "";
        if (strBuf.length() <= 0)
          strBuf.append("\"" + key + "\":\"" + line + "\"");
        else
          strBuf.append(",\n    \"" + key + "\":\"" + line + "\"");
      }
      msg = "{\n  \"success\":true,\n  \"data\":{\n" + strBuf.toString() +
        "}\n}";
    }
    return msg;
  }
%>
<%=getMsg(request) %>
