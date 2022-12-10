# Domain Control

### Configuring and controlling a domain, containing several machines with different operating systems, from Linux, with Salt.
---
**Flexible and scalable.**

Control stuff with [Saltstack](https://saltproject.io/)   

Made in the course:    
[Configuration Management Systems by Tero Karvinen](https://terokarvinen.com/2022/palvelinten-hallinta-2022p2/)

**Current Version: Release / Demo**
- Sources released.
- Functions are tested and working.
- Further development is not certain. Probably will be used as a based for new project.

*10.12.2022 -  Demo version released*

Download source, if you need it in zip format: [.zip](https://github.com/therealhalonen/domain_control/archive/refs/heads/master.zip)

## Usage instructions:

**Please start by reading the [REPORT](https://github.com/therealhalonen/configuration_management_systems/blob/master/h7/report.md)**   

For this to work as its meant to, you need:   
( also minion config stuff is in the list)
```
Production:      
- 2 x Debian 11 servers:
	-
	id: fileserver
	saltenv: prod
	-
	id: webserver
	saltenv: prod
	-
	
- Ubuntu 22.04 Desktop:
	id: ubuntu-ws
	saltenv: prod
	
- Windows 10:
	id: windows-ws
	saltenv: prod
	   
Development:
- 1 or more Debian 11 Server(s)
	id: dev-server<1->
	saltenv: dev
	
- Fedora 36 Desktop
	id: dev-fedora-ws
	saltenv: dev
	
- Ubuntu 22.04 Server
	id: dev-ubuntu
	saltenv: dev
```
Also `master: <address>` needs to be defined of course.

*I dont recommend to use this, if your not comfortable with Salt already.   
This might require little bit of advanced understanding of Salt.   
There might come some errors, which would be hard to troubleshoot, as this is only tested by myself, in my local PC.   
But if you are comfortable, you probably already know how to configure Salt master and Minions*

```bash
git clone https://github.com/therealhalonen/domain_control
cd domain_control
```
After that:   
Copy content of `srv` into `/srv/`   
Copy `etc/salt/master` into `/etc/salt/`   
For example:      
First check that the directories youre about to copy to, exists!      
```bash
sudo cp -r srv/* /srv/
sudo cp etc/salt/master /etc/salt/
```
Restart `salt-master`  
```bash
sudo systemctl restart salt-master
```

Now you need to pull the `win-repo` to enable installing software for windows:      
```bash
sudo salt-run winrepo.update_git_repos
```
Or you can use the included script `srv/salt/update_winrepo_ng`   
The database sync, will be made automatically during the state apply

At this point, you should have the machines configured as minions and you can run:   
```bash
sudo salt '*' state.apply
```
And all states should be ran.   

See [Testing](https://github.com/therealhalonen/configuration_management_systems/blob/master/h7/project_testing.md) for example outcome.  

## Optional features:

**Vagrant, Virtualbox environment:**
```vagrant_prod``` folder holds the Vagrantfile for Production machines.
```vagrant_dev``` folder holds the Vagrantfile for Development machines.   

Each machine is configured to install `salt-minion` and connect to a Master to address `192.168.56.1`, which in my case is the virtualbox host-only adapter address of my Host.   
`cd` to directory and:
```bash
vagrant up
```
inside each folder, to create the machines.

And:   
```bash
vagrant destroy
```
to destroy created machines

More info:   
[Vagrant - CLI](https://developer.hashicorp.com/vagrant/docs/cli)   

## Troubleshooting

**Vagrant:**

**Windows**:   
If you see this while creating the Windows machine for Vagrant:
```bash
    windows-ws: Warning: Connection reset. Retrying...
    windows-ws: Warning: Remote connection disconnect. Retrying...
The guest machine entered an invalid state while waiting for it
to boot. Valid states are 'starting, running'. The machine is in the
'paused' state. Please verify everything is configured
properly and try again.

If the provider you're using has a GUI that comes with it,
it is often helpful to open that and watch the machine, since the
GUI often has more helpful error messages than Vagrant can retrieve.
For example, if you're using VirtualBox, run `vagrant up` while the
VirtualBox GUI is open.

The primary issue for this error is that the provider you're using
is not properly configured. This is very rarely a Vagrant issue.
``` 
And if its booted, just run:   
```vagrant reload windows-ws --provision```

This might also happen:
```bash
==> windows-ws: Running provisioner: shell...
An error occurred in the underlying SSH library that Vagrant uses.
The error message is shown below. In many cases, errors from this
library are caused by ssh-agent issues. Try disabling your SSH
agent or removing some keys and try again.

If the problem persists, please report a bug to the net-ssh project.

timeout during server version negotiating
```
Just run:   
```bash
vagrant reload windows-ws
vagrant up windows-ws --provision
``` 

If nothing else helps, follow this:   
```bash
vagrant destroy windows-ws
sudo salt-key -d windows-ws
vagrant up windows-ws
```
Till it finishes right...      
After that:   
```bash
sudo salt-key -a windows-ws
```

**Salt:**   
**Windows again:**   
After accepting keys and applying state:   
```bash
windows-ws:
    Data failed to compile:
----------
    No matching sls found for 'hello_all' in env 'base'
```
Reboot the Windows machine. or just restart salt-minion from it.    
Error means, it hasnt registered which `saltenv` it belongs to, and will do it when Minion gets restarted next time.

**More:**   
*Coming if something appear*
