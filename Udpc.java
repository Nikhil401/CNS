import java.io.*;
import java.net.*;
public class Udpc
{
public static void main(String args[])throws Exception 
	{
	DatagramSocket cs=new DatagramSocket();
	InetAddress IpAdress=InetAddress.getByName("localhost");
	byte[] sendData=new byte [1024];
	byte[] receiveData=new byte [1024];
		String sentance="hi";
		sendData=sentance.getBytes();
		DatagramPacket sendPacket=new DatagramPacket(sendData,sendData.length,IpAdress,6789);
		cs.send(sendPacket);
		DatagramPacket receivePacket=new DatagramPacket(receiveData,receiveData.length);
		cs.receive(receivePacket);
		String receivedsentance=new String(receivePacket.getData());
		System.out.println("from sender:"+ receivedsentance);
		cs.close();
	}


}

