#!/bin/bash

# f2b-unban ver 0.19  
# copyright github.com/triplr

# print version

echo " fail2ban unban user and jail , jail optional "

# visual plans 
# scroll output on 3 lines

# usage
# f2b-unban user jail
# f2b-unban $1   $2
 
echo example
echo f2b-unban triplr sshd

i=$1
jail=$2

echo "unbanning" $i "in jail" $jail

function extract_ip () {
                                # command string to filter ip address out of output of user
        last $i -i | 
        awk '{print $3}' 
} 

function filter_ip () {
                                # ip filter
        grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" 

}

function sort_ip () {
                                # goal : match the sort with the output of the fail2ban jail ban list
                                # for now just pass to the fail2ban unban command
        sort -u 
}

function unban_ip () {
while read -r line; 
        do 
                echo $line ;
                fail2ban-client set sshd unbanip $line ; 
        done
}

function help () {
      
	echo ' put help information here '
	
}

#error control with exit codes
# check if root
# check if fail2ban-client exists
# check if $1 is null
# check if $1 user exists

if $1='--help'
    then help
    else extract_ip | filter_ip | sort_ip | unban_ip
fi


