<%@page language="java" contentType="text/html" %>
<%@page import="java.util.Date" %>
<%@page import="java.net.InetAddress" %>
<%!
  private String getGreeting() {
    Date now = new Date();
    String greeting = null;
    if (now.getHours() < 12) {
      greeting = "Good morning";
    }
    else if (now.getHours() < 18) {
      greeting = "Good afternoon";
    }
    else {
      greeting = "Good evening";
    }
    return greeting;
  }

  private String getHostname() {
    String hostName = "failed to get hostname";
    String ipAddr;
    try {
        java.net.InetAddress ipAddress =java.net.InetAddress.getLocalHost();
        ipAddr = ipAddress.getHostAddress();
        hostName = ipAddress.getHostName();
        if (hostName == null || hostName.length() == 0)
            hostName = ipAddress.getHostAddress();
        else {
            int i = hostName.indexOf(".");
            if (i > 0)
                hostName = hostName.substring(0, i);
        }
    }
    catch (Exception e) {
    }
    return hostName;
}
%> 
<html>
<head><title>Current Date</title></head>
<body>
  <%= getGreeting() %> from <%= getHostname() %>
  <BR>
  Today is <%= new Date() %>.
</body>
</html>
