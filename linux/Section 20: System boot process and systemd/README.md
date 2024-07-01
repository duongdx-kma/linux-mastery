# Section 20: System boot process and systemd

## I. How `kernel` work:

### 1. concept
```
1. process management
- scheduling and resource allocation
- inter-process communication (IPC)

2. Memory management
- Physical and virtual memory
- Handles allocation and de-allocation

3. File system management
- supports various file system (e.g ext4, XFS, ...)
- handles the read and write to those


4. Networking stack
- Implement various network protocols (eg. TCP/IP, Ethernet)
- Routing, packet filtering, and traffic control

5. Hardware  abstraction layer (HAL):
- Enables applications to communicate with various devices
```

### 2. List all kernel modules, that are available on OS:
```
# command:

> sudo lsmod
```

---

## II. systemd:

```
- After the bootloader has given control to our kernel, the kernel
will initialize and start the main process (PID = 1).
- On most Linux systems nowadays, it's the systemd process
- Let's first have a look at how this looks in the output of the ps
program:
> "ps 1"
- This process will then initiate all the rest:
    (+) Starting the system
    (+) Mounting drives
    (+) Starting services
    (+) Configuring network connections
    (+) Starting additional applications
```

### 1. systemd: General structure

**system mode;**
```
- systemd manages the boot process and starts all services required for this (in parallel)
- It reads in configuration files (unit files), builds the dependency graph, and then executes all commands necessary to get to the result
```

**user mode:**
```
- The same as system mode, but for user services
(after the user logins)
- We will focus on system mode in this course
```

**Systemd manages "Units": Those path are usually for systemd:**
```
- /lib/systemd/system:

    (+) (sometimes also /usr/lib/systemd/system)
    (+) system configuration
    (+) this is the default place for configuration from the maintainer
```

```
- /run/systemd/system:

    (+) non-persistent
    (+) runtime configuration (when reboot the server, those will be deleted)
```

```
- /etc/systemd/system:

    (+) Configuration for the adminsitrator
    (+) Overwrites files from /lib/systemd/system
    (+) This is where we should store our custom configuration
```

### 2. systemd: Structuring and Customizing
```
[Unit]:
    - A general configuration for the unit
[Service]:
    - If this unit is a service, we should write all the configuration for the service into this section
[Install]:
    - Here, we specify, how the unit should be installed
```

**a. [Unit]**
```
Description:
- Brief explanation, helps users understand the purpose of the service

Documentation:
- Links to relevant documentation

Requires:
- Ensures other units are activated before the current unit
- If the required unit fails to start, the current unit will not start

Wants:
- Similar to Requires, but the current unit will start even if the wanted unit fails
- Useful for optional dependencies

After:
- Ensures the current unit starts after specified units
- Helps to define the order of unit activation

Before:
- Ensures the current unit starts before specified units
- Also helps to define the order of unit activation
```

**b. [Service]**
```
Type:
- Defines the process type and startup behavior
- Examples: simple, exec, forking, oneshot,...

ExecStart:
- Command to start the service
- Can include arguments and options
- But it's not a full bash command!

ExecStop:
- Command to stop the service (optional)

Restart:
- Defines when the service should be automatically restarted
- Examples: no, on-success, on-failure, on-abnormal, on-abort, always

User:
- User under which the service should be run

Environment:
- Defines environment variables for the service
```

**c. [Install]**
```
WantedBy:
- Specifies the target(s) that should include this unit as a dependency
- Common targets: multi-user.target, graphical.target
- Enables the unit to be started automatically at boot when "systemctl enable" is used
```

### 3. `systemd`: Testing customize config: testing with haproxy.service
```
# step1:
> sudo cp /lib/systemd/system/haproxy.service /etc/systemd/system/haproxy.service

# step2:
> sudo systemctl daemon-reload

# step3:
> sudo systemctl disable haproxy

# step4:
> sudo systemctl enable haproxy

# step 5:
> sudo systemctl reload haproxy
```


### 4. `systemd`: testing own service
```
# check file

- my-custom-log.service
- ping_and_log.sh
```

### 5. `timer`:
```
# check file

- my-custom-log.timer
```

**command**
```
# start timer:
- sudo systemctl start [timer_name].timer
- sudo systemctl start my-custom-log.timer

# list all timer:
> sudo systemctl list-timers
```


### 6. Systemd: Targets
```
Target:
- Groups units logically to a goal
- Managed by .target unit files
```

**a. To get the (current) default `target`:**
```
> sudo systemctl get-default
```

**b. To switch `target`, without rebooting:**
```
> sudo systemctl isolate [target-name].target

# example
> sudo systemctl isolate multi-user.target
```

**c. We can list available `targets` with the following command:**
```
> sudo systemctl list-units --type target --all
```

**We could also change the current default `target`:**
```
> sudo systemctl set-default multi-user.target
```

---

## III. `Cgroup` control groups

### 1. What is a cgroup?

```
- Control groups (cgroups) are a feature of the Linux kernel
- It organizes processes hierarchically
- And allows us to more evenly distribute system resources
- Systemd heavily relies on cgroups to manage processes
```

**a.Advantages:**
```
- A cgroup can span multiple processes - and even contain other cgroups
- If we start a sub-process, it will automatically be in the same cgroup as the parent
```

**b. Uses of `cgroups` include:**
```
- Resource limiting:
- We can configure a cgroup to not exceed a specific memory limit
- We can define how much % of CPU resources this cgroup may occupy
- We can also measure how much resources certain systems consume
- ... or freeze a group of processes
- This can be useful when multiple services (in an application sense) / containers
share the same server
```

**c. checking `cgroup`**
```
# command: systemctl status

# Result: checking `CGroup`

runner01
    State: degraded
     Jobs: 0 queued
   Failed: 1 units
    Since: Sat 2024-06-29 23:39:20 +07; 1h 27min ago
   CGroup: /
           ├─docker
           │ ├─a5b1b4afcefcb9031aaf5dbd663f50c1fab116789c6340ccd4b693f8c53abd4b
           │ │ ├─2344 /usr/bin/dumb-init /entrypoint run --user=gitlab-runner --working-directory=/home/gitlab-runner
           │ │ └─2574 gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner
           │ └─78d538959124a52801027c8a871c140aea64d6452309fbc88c5071b7351779d7
           │   └─2341 minio server --console-address :9001 /data
           ├─user.slice
           │ └─user-1002.slice
           │   ├─user@1002.service
           │   │ └─init.scope
           │   │   ├─2979 /lib/systemd/systemd --user
           │   │   └─2980 (sd-pam)
           │   └─session-3.scope
           │     ├─2977 sshd: deploy [priv]
           │     ├─3054 sshd: deploy@pts/0
           │     ├─3055 -bash
           │     ├─3461 systemctl status
           │     └─3462 pager
           ├─init.scope
           │ └─1 /sbin/init

```

**c. inspect `cgroup`**
```
# command:
> systemd-cgtop

# or We can change this level:

> systemd-cgtop --depth=5

# result:

Control Group                                                                                        Tasks   %CPU   Memory  Input/s Output/s
/                                                                                                      262    2.0     2.7G        -        -
/docker                                                                                                 20    0.8     2.0G        -        -
/user.slice                                                                                              6    0.8   126.4M        -        -
/docker/a5b1b4afcefcb9031aaf5dbd663f50c1fab116789c6340ccd4b693f8c53abd4b                                10    0.8    58.2M        -        -
/system.slice                                                                                          158    0.1   593.1M        -        -
/docker/78d538959124a52801027c8a871c140aea64d6452309fbc88c5071b7351779d7                                10    0.1     1.9G        -        -
/system.slice/mysql.service                                                                             28    0.0   200.9M        -        -
/system.slice/docker.service                                                                            51    0.0   107.2M        -        -
/system.slice/containerd.service                                                                        34    0.0    79.3M        -        -
/system.slice/haproxy.service
```


---

## IV. `systemd-journald`

### 1. introduction:

**a. systemd-journald:**
```
- Part of the systemd suite
- Manages system logs
- Replaces traditional syslog
```

**b.Key features:**
```
- Binary format for efficient storage
- Centralized logging solution
- Automatic log rotation and retention
- Indexing and querying capabilities
- Also logs messages that happened during boot
```

### 2. journalctl:

**a. list all logs**
```
> sudo journaldctl
```

**b. show currunt boot logs**
```
> sudo journaldctl -b
```

**c. Filter by unit:**
```
> sudo journalctl -u <unit>

# example

> sudo journalctl -u apache2
> sudo journalctl -u my-custom-log
```

**d.Show all available boots:**
```
> sudo journalctl --list-boots
```

**e.Filter by time range:**
```
> sudo journalctl --since "<time>" --until "<time>"

# example

> sudo journalctl -u apache2 --since '2024-06-29' --until '2024-06-30'
> sudo journalctl -u my-custom-log --since '2024-06-29' --until '2024-06-30'
```

**f.Reverse output:**
```
> journalctl -r
```

**g. Follow logs in real-time:**
```
> journalctl -f
```

**j.We can also send a message into the journalctl log:**
```
# command:

> echo 'message' | systemd-cat

# example for check
> echo 'message testiinggg' | systemd-cat

>  journalctl -f -t me
```