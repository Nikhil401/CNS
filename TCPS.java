import java.io.*;
import java.util.*;
import java.net.*;
class TCPS
{
	public static void main(String args[]) throws Exception
	{
		ServerSocket ss=new ServerSocket(4000);
		System.out.println("Server is ready for connection");
		Socket cs=ss.accept();
		System.out.println("Connection is successful waiting for chatting");
		InputStream istream=cs.getInputStream();
		BufferedReader file=new BufferedReader(new InputStreamReader(istream));
		String fname=file.readLine();
		BufferedReader content=new BufferedReader(new FileReader(fname));
		OutputStream ostream=cs.getOutputStream();
		PrintWriter pwrite=new PrintWriter(ostream,true);
		String str;
		while((str=content.readLine())!=null)
		{
			pwrite.println(str);
		}
		cs.close();
		ss.close();
		pwrite.close();
		file.close();
		content.close();
	}
}
