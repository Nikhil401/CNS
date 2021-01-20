
set ns [new Simulator]

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

## The code you need to add –Change 1 
set f1 [open f1 w]
set f2 [open f2 w]

#===================================
#        Nodes Definition        
#===================================
#Create 6 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n2 10.0Mb 1ms DropTail
$ns queue-limit $n0 $n2 10
$ns duplex-link $n1 $n2 10.0Mb 1ms DropTail
$ns queue-limit $n1 $n2 10
$ns simplex-link $n2 $n3 10.0Mb 1ms DropTail
$ns queue-limit $n2 $n3 10
$ns simplex-link $n3 $n2 10.0Mb 1ms DropTail
$ns queue-limit $n3 $n2 10

#Give node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns simplex-link-op $n2 $n3 orient right
$ns simplex-link-op $n3 $n2 orient left

## change 2 –setting up the lan  
set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]
#===================================
#        Agents Definition        
#===================================

#Setup a TCP/Newreno connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1
$tcp1 set packetSize_ 1500
$tcp1 set window 5000   # change 3 –set the tcp window size   

#Setup a TCP/Newreno connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n5 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n1 $sink2
$ns connect $tcp2 $sink2
$tcp2 set packetSize_ 1500
$tcp2 set window 500   # change 4 –set the tcp window size 
  
#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP/Newreno connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 1.0 "$ftp1 start"
$ns at 10.0 "$ftp1 stop"

#Setup a FTP Application over TCP/Newreno connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 1.0 "$ftp2 start"
$ns at 10.0 "$ftp2 stop"

# change 4 –setting up error model between $n2 $ n3 in random fashion 
set var [new ErrorModel]
$var ranvar [new RandomVariable/Uniform]
$var drop-target [new Agent/Null]
$ns lossmodel $var $n2 $n3
#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
	exec xgraph f1 f2 &  
   exit 0
}

# change 6 adding plot window function 
proc PlotWindow {tcpSource file} { 
global ns 
set time 0.1	
set now [$ns now]  
set cwnd [$tcpSource set cwnd_] 
puts $file "$now $cwnd"   
$ns at [expr $now+$time] "PlotWindow $tcpSource $file" 
}  

# change 7 schedule it 
$ns at 0.1 "PlotWindow $tcp1 $f1"
$ns at 0.1 "PlotWindow $tcp2 $f2"
$ns at 10.0 "finish"

$ns run

