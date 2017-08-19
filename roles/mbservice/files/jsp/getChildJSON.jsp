<%@page language="java" contentType="text/plain" %><%@page import="java.util.Map" %><%@page import="javax.servlet.http.HttpServletRequest" %><%!
  /** retrieving the child JSON data from the text field of the response */
  private String getMsg(HttpServletRequest req) {
    String msg = null, key = req.getContextPath();
    Map data = (Map) req.getAttribute(key);
    if (data == null || !data.containsKey("text"))
      msg = "{\"error\":\"failed to process request on " + key + "\"}";
    else {
      int i, j;
      String line = (String) data.get("text");
      i = line.indexOf("[{");
      j = org.qbroker.json.JSON2Map.locate(2, line);
      if (i > 0 && j > i) {
        msg = line.substring(i+1,j+1);
      }
      else { // wrong data
        line = (line.length() > 60) ? line.substring(0, 60) : line;
        msg = "{\"error\":\"failed to process request on " + key + "\"}";
      }
    }
    return msg;
  }
%><%=getMsg(request) %>
