On host migration/IP change, re-deploy SSH key.

1. Remove existing key: `ssh-keygen -f "/home/seth/.ssh/known_hosts" -R {hostname}`
2. Redeploy key: `ssh-copy-id {username}@{hostname}`

Background: my virtual host ISP moved my stuff to a new server again and that naturally breaks the ssh login (again) 
besauce the IP changes and the host refuses to connect (which is good, don't want to trust just anyone). So to make
the SSH connection work again, I need to boot the old key and redeploy it to the host (maybe the second step would 
be enough, not sure). Anyway, with this it works again.. until next time.
