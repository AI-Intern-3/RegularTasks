 ```
         +---------------+
          |  Core Router  |
          +---------------+
                  |
                  |
                  v
+---------------+---------------+
|         Switch         |
|  (configured to only  |
|  accept frames with    |
|  MAC addresses from    |
|  Core Routers)        |
+---------------+---------------+
                  |
                  |
                  v
+---------------+---------------+
|  Server 1      |  Server 2    |
|  (IPv4 addr:   |  (IPv4 addr:  |
|   192.168.1.10)|   192.168.1.20)|
+---------------+---------------+
                  |
                  |
                  v
+---------------+---------------+
|  Server 3      |  Server 4    |
|  (IPv4 addr:   |  (IPv4 addr:  |
|   192.168.1.30)|   192.168.1.40)|
+---------------+---------------+

```

In this diagram:

All traffic from the servers must pass through the core router.
The switch is configured to only accept Ethernet frames with MAC addresses originating from the core routers. This means that any traffic sent directly between servers (e.g. from Server 1 to Server 2) will be dropped by the switch.
Each server has an IPv4 address from the same subnet (192.168.1.0/24).
Since the switch does not forward layer-2 traffic between servers, direct communication between servers is not possible, even if they are on the same subnet.


To allow servers to communicate with each other, you need to create static routes on each server to the other servers. For example:

On Server 1, you would create a static route to Server 2: route add -net 192.168.1.20/32 gw 192.168.1.1 (assuming the core router's IP address is 192.168.1.1)
On Server 2, you would create a static route to Server 1: route add -net 192.168.1.10/32 gw 192.168.1.1
Similarly, you would create static routes on Server 3 and Server 4 to each other, and to Server 1 and Server 2.
By creating these static routes, you are effectively telling each server to send traffic destined for another server on the same subnet to the core router, which will then forward the traffic to the destination server.

Note that this configuration is not typical in most networks, as it requires manual configuration of static routes on each server. In most cases, layer-2 switching is used to allow devices on the same subnet to communicate directly with each other. However, this configuration may be used in certainscenarios where security or isolation requirements dictate that all traffic must pass through a central router.

