# OSI model

## I. Layer 1:  Physical layer of the OSI model

### 1. Introduction
```
Physical Layer (Layer 1) of OSI model
- Physical medium: Copper cables, fiber-optic cables, wireless
- Data transmission: Convert digital data to signals
- Signaling: Voltage levels, modulation synchronization

- Error detection: Basic methods, e.g., parity bits

- TLDR: We now have a physical connection, through which we can send bits
```

### 2. Layer 1: Enable/Disable device

**concept and command**
```
- We can also disable a device through software
- We first need to get the name of our device:
> ip addr show

- After this, we can enable / disable the device:
> ip link set dev <interface> up
> ip link set dev <interface> down
```

**example**
```
# command:
> ip link set dev enp0s5 down
```

## II. Layer 2: Data link layer

### 1. introduction:
```
The goal of layer 2:
- Reliable communication between devices on the same network

Divided into two sublayers:
- Logical Link Control(LLC)
    + Flow control and error detection
    + This is the interface between Data Link and Network Layers

- Media Access Control (MAC):
    + Unique hardware addresses (MAC addresses)
    + Gives us a way to identify the sender and receiver of a frame

Frame encapsulation:
- Organize data into frames for transmission
- Add source and destination MAC addresses
```

### 2. What is Ethernet (IEEE 802.3):
```
- Ethernet is a family of network technologies
- Mostly used in LAN (local area networks)
- Originally developed in the 1970s
- Ethernet splits the data into "frames"
- An ethernet frame:
    + Is usually max 1.5kb in size
    + Contains the actual data that we want to transfer (more on that later)
    + Contains a checksum so the destination can verify if it has received the data correctly
    + Also contains addressing information:
        * MAC of the source ethernet interface
        * MAC of the destination ethernet interface
```

### 3. What is WiFi?
```
What is WiFi (IEEE 802.11)?
- WiFi is wireless networking protocol
- The frames that are being sent are slightly different than the ones from Ethernet - they need to contain additional data responsible for wireless connections
- Still, they're highly compatible with each other:
    + Both protocols use MAC-addresses
    + A wireless access point can convert Ethernet frames into WiFi frames
```

### 4.What is a MAC address?
```
What is a MAC address?

MAC stands Media Access Control address
- Unique identifier for network interfaces
- 48-bit (6-byte) address

Address format:
- 6 groups of 2 hexadecimal digits, separated by colons (e.g., 01:23:45:67:89:AB)

Assigned by manufacturers:
- First 3 bytes: Organizationally Unique Identifier (OUI)
- Last 3 bytes: Device-specific identifier

Static by default but can be changed (spoofed) in software

We can show information about our network devices with the following command:
> ip addr show
```

## III. Layer 3: Network layer

### 1. `Network layer`: introduction
```
- On layer 2, we could only send frame from one computer directly to another one. But if computer are not connected directly, we can't send messages through layer2
```
**the IDEA here:**
```
- We no longer work with MAC address, but with IP addresses
- We send "packets", Which are wrapped into frames at each step

- Those packets can be forwarded
- Our router could forward a packet that meant to be sent to the internet
```

### 2. `Network layer`: What is a network?

**Definition**
```
- A network is a group of interconnected devices that can communicate and share resources
- Devices can include computers, server, printers, routers, switches and more..
```

**Types of networks (that are important for us now):**
```
- Local Area Network (LAN): Covers a small geographic area, such as a home or office

- Wide Area Network (WAN): Spans larger distances (country, continent, global), often
connecting multiple LANs
```

**COMMAND:**
```
# show ip
> ip addr show

# show route:
> ip route show
or
> ip route
or
> route

```

### 3. `Network layer`: `subnet`
**What is a subnet?**
```
- Subnet is a network with a network
- this allows us to manage more computers
- they make `Large` networks more efficient

At home:
- Technically speaking, our home network is a subnet of the internet

In a corporate setting:
- We can split our corporate network into multiple subnets, and increase the efficiency
```

**The problem right now**
```
- How do we know where to send a frame to?
- If we want to send a packet to the internet... we need to send the frame to the router
- If we wand to send a packet to another computer in our network... we can directly send the frame to it
```

**Example1: We want to send a packet to another computer in our local network**
```
- We can send the `FRAME` directly to it:
- Btw this is always the case, even if  one computer connects through WiFi, and the other one through a LAN cable
- In this case, the router part of the router `will not be involved` - the wireless access component of the router will be responsible for sending this packet to the WiFi connected device
```

**Example2: We want to send a packet to the internet**
```
- We want to send a packet to the internet
- In this case, we need to send a packet to the router
- Which will forward it for us to the internet
```

### 4. `Network layer`: How to set IP address
**a. command:**
```
# add an ip address to the interface
> ip addr add [ip_address]/[prefix_length] dev [interface_name]

# delete an ip address from an interface:
> ip addr del [ip_address]/[prefix_length] dev [interface_name]
```

**b. example:**
```
# add an ip address to the interface
> ip addr add 192.168.100.1/24 dev enp0s3

# delete an ip address from an interface:
> ip addr del 192.168.100.1/24 dev enp0s3
```

### 5. `Network layer`: Route
**a. Show current command**
```
> route
or
> ip route show
```

**b. Show which gateway for specific destination:**
```
# command:
> ip route get [dest_ip_address]

# example:
> ip route get 192.168.1.100
> ip route get 8.8.8.8
```

**c. Change/add/edit/delete route**
```
# Add route command:
> ip route add [dest_ip_address] via [gateway] dev [interface]

# Delete route command:
> ip route del [dest_ip_address] via [gateway] dev [interface]

# example:
> sudo ip route add 10.100.1.0/24 via 0.0.0.0 dev enp0s3
```


