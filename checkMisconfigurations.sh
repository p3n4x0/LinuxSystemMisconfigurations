#!/bin/bash

# Kernel and distribution release details
echo -e "\033[1;31m[+] Kernel and distribution release details\033[0m"
uname -a
cat /etc/*-release
echo

# System Information
echo -e "\033[1;31m[+] System Information\033[0m"

# Hostname
echo -e "\033[1;32m[+] Hostname\033[0m"
hostname
echo

# Networking details
echo -e "\033[1;32m[+] Networking details\033[0m"

# Current IP
echo -e "\033[1;32m[+] Current IP\033[0m"
ip a | grep 'inet'
echo

# Default route details
echo -e "\033[1;32m[+] Default route details\033[0m"
route -n
echo

# DNS server information
echo -e "\033[1;32m[+] DNS server information\033[0m"
cat /etc/resolv.conf
echo

# User Information
echo -e "\033[1;31m[+] User Information\033[0m"

# Current user details
echo -e "\033[1;32m[+] Current user details\033[0m"
whoami
echo

# Last logged on users
echo -e "\033[1;32m[+] Last logged on users\033[0m"
last
echo

# Shows users logged onto the host
echo -e "\033[1;32m[+] Shows users logged onto the host\033[0m"
who
echo

# List all users including uid/gid information
echo -e "\033[1;32m[+] List all users including uid/gid information\033[0m"
cat /etc/passwd
echo

# List root accounts
echo -e "\033[1;32m[+] List root accounts\033[0m"
grep "x:0:" /etc/passwd
echo

# Extracts password policies and hash storage method information
echo -e "\033[1;32m[+] Extracts password policies and hash storage method information\033[0m"
grep "^password" /etc/pam.d/*
echo

# Checks umask value
echo -e "\033[1;32m[+] Checks umask value\033[0m"
umask
echo

# Attempt to read restricted files i.e. /etc/shadow
echo -e "\033[1;31m[+] Attempt to read restricted files i.e. /etc/shadow\033[0m"
cat /etc/shadow 2>/dev/null
echo

# List current users history files (i.e .bash_history, .nano_history etc.)
echo -e "\033[1;31m[+] List current users history files\033[0m"
find /home -name ".bash_history" -o -name ".nano_history" -exec ls -la {} \;
echo

# Which users have recently used sudo
echo -e "\033[1;31m[+] Which users have recently used sudo\033[0m"
grep "sudo" /var/log/auth.log
echo

# Determine if /etc/sudoers is accessible
echo -e "\033[1;31m[+] Determine if /etc/sudoers is accessible\033[0m"
ls -la /etc/sudoers
echo

# Are known ‘good’ breakout binaries available via Sudo (i.e. nmap, vim etc.)
echo -e "\033[1;31m[+] Are known ‘good’ breakout binaries available via Sudo\033[0m"
sudo -l | grep "nmap\|vim"
echo

# Is root’s home directory accessible
echo -e "\033[1;31m[+] Is root’s home directory accessible\033[0m"
ls -ld /root
echo

# List permissions for /home/
echo -e "\033[1;31m[+] List permissions for /home/\033[0m"
ls -ld /home
echo

# Display current $PATH
echo -e "\033[1;31m[+] Display current \$PATH\033[0m"
echo $PATH
echo

echo -e "\033[1;31m[+] List all cron jobs\033[0m"
crontab -l
echo

echo -e "\033[1;31m[+] Locate all world-writable cron jobs\033[0m"
find /etc/cron* -perm -0002 -type f -exec ls -la {} \;
echo

echo -e "\033[1;31m[+] Locate cron jobs owned by other users of the system\033[0m"
find /etc/cron* ! -user root -type f -exec ls -la {} \;
echo

echo -e "\033[1;31m[+] List the active and inactive systemd timers\033[0m"
systemctl list-timers --all
echo

echo -e "\033[1;31m[+] List running processes\033[0m"
ps aux
echo

echo -e "\033[1;31m[+] Lookup and list process binaries and associated permissions\033[0m"
ps aux --sort=-%cpu | awk '{print $11}' | xargs -r ls -la 2>/dev/null
echo

echo -e "\033[1;31m[+] List init.d binary permissions\033[0m"
ls -la /etc/init.d/*
echo

echo -e "\033[1;31m[+] Locate all SUID/GUID files\033[0m"
find / -perm /4000 -type f 2>/dev/null
echo

echo -e "\033[1;31m[+] Locate all world-writable SUID/GUID files\033[0m"
find / -perm /6000 -type f 2>/dev/null
echo

echo -e "\033[1;31m[+] Locate all SUID/GUID files owned by root\033[0m"
find / -user root -perm /4000 -type f 2>/dev/null
echo

echo -e "\033[1;31m[+] Locate ‘interesting’ SUID/GUID files (i.e. nmap, vim etc)\033[0m"
find / -user root -perm /4000 -type f -name "nmap" -o -name "vim" 2>/dev/null
echo

echo -e "\033[1;31m[+] Locate files with POSIX capabilities\033[0m"
getcap -r / 2>/dev/null
echo

echo -e "\033[1;31m[+] List all world-writable files\033[0m"
find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print
echo

echo -e "\033[1;31m[+] Find/list all accessible *.plan files and display contents\033[0m"
find / -name "*.plan" -exec cat {} \; 2>/dev/null
echo

echo -e "\033[1;31m[+] Find/list all accessible *.rhosts files and display contents\033[0m"
find / -name "*.rhosts" -exec cat {} \; 2>/dev/null
echo

echo -e "\033[1;31m[+] Show NFS server details\033[0m"
showmount -e
echo

echo -e "\033[1;31m[+] Locate *.conf and *.log files containing keyword supplied at script runtime\033[0m"
grep -r "keyword" /etc/*.conf /var/log/* 2>/dev/null
echo

echo -e "\033[1;31m[+] List all *.conf files located in /etc\033[0m"
ls -la /etc/*.conf
echo

echo -e "\033[1;31m[+] .bak file search\033[0m"
find / -name "*.bak" -exec ls -la {} \; 2>/dev/null
echo

echo -e "\033[1;31m[+] Locate mail\033[0m"
find / -name "mail" -exec ls -la {} \; 2>/dev/null
echo

echo -e "\033[1;31m[+] Checks to determine if we're in a Docker container\033[0m"
cat /proc/self/cgroup | grep "docker"
echo

echo -e "\033[1;31m[+] Checks to see if the host has Docker installed\033[0m"
which docker
echo

echo -e "\033[1;31m[+] Checks to determine if we're in an LXC container\033[0m"
cat /proc/self/cgroup | grep "lxc"
echo
