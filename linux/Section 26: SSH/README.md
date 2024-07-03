# SSH: Secure Shell

## I. `SSH server`: Security

### 0. sshd logs:
```
/var/log/auth.log
```

### 1. `SSH server Security`: Change port
**introduction**
```
We should change the port to something else
We can edit the sshd config in the following file: `/etc/ssh/sshd_config`

example: Port 222
```

**example**
```
# edit the file
> vim /etc/ssh/sshd_config

# change the port: 22 -> 2222

# test ssh config:
> ssh -t

# restart sshd
> systemctl restart sshd
```

### 2. `SSH server Security`: Disable root login: `PermitRootLogin no`
```
The problem:
- By default, all normal users with password can use SSH
- Depending on the configuration, sometimes this also applies to the user root
- We should check, and consider disabling root login:
  `PermitRootLogin no`
- This helps a little bit, as an attacker now has to first login as a user, and only
then can elevate his privileges with sudo
```

### 3. `SSH server Security`: Whitelist users
```
The problem:
- By default, all normal users with password can use SSH
- We might also want to whitelist users, so we have to explicitly think about who is able to access our server through ssh:
> AllowUsers [username]

- Example:
> AllowUsers janniss
```

### 4. `SSH server Security`: Disable password auth: `PasswordAuthentication no`
```
- Now that key auth has been enabled, we can disable password auth
- This further reduces the attack surface - the key is way longer than any
password could ever be
- An attacker then need to know both:
- The private key
- And the password of our user (for everything that needs sudo)
- We can disable password auth with the following option:
- File: /etc/ssh/sshd_config
> PasswordAuthentication no
- Of course we need to restart sshd after:
> Test config: sshd -t
> Restart sshd: systemctl restart sshd
```

## II. SSH `fingerprint`:

### 1. introduction:
```
- If we access a server for the first time, we store its key fingerprint on our system
- Each system has its own fingerprint(s)
- If we try to connect to a remote server...... and we get a fingerprint warning:
- Do not ignore this!
- We might have a connection to the wrong server (or the domain name might be wrong and resolve to another server)
- We might be victim of a man-in-the-middle attack!
```

### 2. Verify fingerprint:
**command**
```
# command
> ssh-keygen -E [algorithm] -lf /etc/ssh/ssh_host_ed25519_key.pub

# example
> ssh-keygen -E sha256 -lf /etc/ssh/ssh_host_ed25519_key.pub
```

**Example**:
**step1**: ssh to new host - please check `ED25519 key fingerprint is SHA256:b7taohSbiFPaATNRL3b2XZFjAGtKqM3BLkDN6COOx18.`
```
# command:
> ssh -i client.pem deploy@192.168.100.222

# response:
Warning: Identity file client.pem not accessible: No such file or directory.
The authenticity of host '192.168.56.98 (192.168.56.98)' can't be established.
ED25519 key fingerprint is SHA256:b7taohSbiFPaATNRL3b2XZFjAGtKqM3BLkDN6COOx18.
This key is not known by any other names
```

**step2**: check `algorithm` of previous step:
```
# go to server and running command:
> ssh-keygen -E sha256 -lf /etc/ssh/ssh_host_ed25519_key.pub

# result:
> b7taohSbiFPaATNRL3b2XZFjAGtKqM3BLkDN6COOx18

=> if fingerprint `is match`, it is `trust` server
=> if fingerprint `not match`, it is `malicious` server
```