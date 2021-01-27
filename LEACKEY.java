import java.util.*;
public class LEACKEY
{
public static void main(String[] args)
{
Scanner my= new Scanner(System.in);
int no_groups,bucket_size;
System.out.println("\n enter bucket size:\t");
bucket_size= my.nextInt();
System.out.println("\n enter no of groups:\t");
no_groups= my.nextInt();
int no_packets[]=new int[no_groups];
int in_bw[]=new int[no_groups];
int out_bw,reqd_bw=0,tot_packets=0;
for (int i=0;i<no_groups;i++)
{
System.out.print("\n enter no of packets for group"+(i+1)+"\t");
no_packets[i]=my.nextInt();
System.out.print("\n enter input bandwidth for group"+(i+1)+"\t");
in_bw[i]=my.nextInt();
if((tot_packets+no_packets[i])<=bucket_size)
{
tot_packets+=no_packets[i];
}
else
{
do
{
System.out.println("bucket overflow");
System.out.println("enter values less than"+(bucket_size-tot_packets));
no_packets[i]=my.nextInt();
}
while((tot_packets+no_packets[i])>bucket_size);
tot_packets+=no_packets[i];
}
reqd_bw +=(no_packets[i]*in_bw[i]);
}
System.out.println("required bandwidth is "+reqd_bw);
System.out.println("enter output bandwidth");
out_bw=my.nextInt();
while((out_bw<=reqd_bw)&&(tot_packets>0))
{
System.out.println("data sent\n" + (--tot_packets) +"packets remaining");
System.out.println("remaining band width " +(reqd_bw-=out_bw));
if((out_bw>reqd_bw)&&(tot_packets>0))
System.out.println(tot_packets+"packets(s) discarded due to invsufficient bandwidth");
}
}
}

