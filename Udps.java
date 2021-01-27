





import java.io.*;
import java.net.*;
import java.util.Scanner;
public class Udps
{
public static void main(String args[])throws Exception 
{
DatagramSocket s=new DatagramSocket(6789);
byte[] sendData=new byte [1024];
byte[] receiveData=new byte [1024];
while(true)
{
DatagramPacket receivePacket=new DatagramPacket(receiveData,receiveData.length);
s.receive(receivePacket);
String sentance=new String(receivePacket.getData());
InetAddress IpAddress=receivePacket.getAddress();
int port=receivePacket.getPort();
System.out.println("enter message to echo");
Scanner sc=new Scanner(System.in);
String msg=sc.nextLine();
sendData=msg.getBytes();
DatagramPacket sendPacket=new DatagramPacket(sendData,sendData.length,IpAddress,port);
s.send(sendPacket);
}
}
}

