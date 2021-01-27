import java.util.*;
import java.net.*;
import java.io.*;
class TCPC
{
	public static void main(String args[]) throws Exception
	{
		Socket s=new Socket("localhost",4000);
		System.out.println("Enter the file name");
		BufferedReader file=new BufferedReader(new InputStreamReader(System.in));
		String fname=file.readLine();
		OutputStream ostream=s.getOutputStream();
		PrintWriter pwrite=new PrintWriter(ostream,true);
		pwrite.println(fname);
		InputStream istream=s.getInputStream();
		BufferedReader content=new BufferedReader(new InputStreamReader(istream));
		String str;
		while((str=content.readLine())!=null)
		{
			System.out.println(str);
		}
		pwrite.close();
		file.close();
		content.close();
		s.close();
	}
}
