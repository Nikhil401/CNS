#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

$ns color 1 Red
$ns color 2 Green
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
$ns duplex-link $n0 $n1 10Mb .05ms DropTail
$ns queue-limit $n0 $n1 5
$ns duplex-link $n1 $n2 0.05Mb 100ms DropTail
$ns queue-limit $n1 $n2 2
$ns duplex-link $n2 $n3 10.0Mb 1ms DropTail
$ns queue-limit $n2 $n3 5
$ns duplex-link $n3 $n4 10.0Mb 1ms DropTail
$ns queue-limit $n3 $n4 10
$ns duplex-link $n4 $n5 10.0Mb 1ms DropTail
$ns queue-limit $n4 $n5 10


Agent/Ping instproc recv {from rtt} {
      $self instvar node_
      puts "node [$node_ id] received ping answer from $from with round-trip-time $rtt ms."
}

#===================================
#        Agents Definition        
#===================================
set p0 [new Agent/Ping]
$ns attach-agent $n0 $p0

$p0 set fid_ 1

set p1 [new Agent/Ping]
$ns attach-agent $n5 $p1

$p1 set fid_ 2

#Connect the two agents
$ns connect $p0 $p1
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
# to create drop at n1 following sends
$ns at 0.2 "$p0 send"
$ns at 0.2 "$p0 send"
$ns at 0.2 "$p0 send"
$ns at 0.2 "$p0 send"

$ns at 0.4 "$p1 send"
$ns at 0.4 "$p1 send"
$ns at 0.4 "$p1 send"
$ns at 0.4 "$p1 send"

$ns at 2.0 "finish"
$ns run
