# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lbordona <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 13:09:08 by lbordona          #+#    #+#              #
#    Updated: 2022/12/16 16:46:59 by lbordona         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#Architecture:
arch=$(uname -a)

#CPU:
cpu=$(nproc)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
cpu_usage=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')

#RAM:
total_ram=$(free -m | awk '$1 == "Mem:" {print $2}')
used_ram=$(free -m | awk '$1 == "Mem:" {print $3}')
percent_ram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

#Disk:
total_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{td += $2} END {print td}')
used_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} END {print ud}')
percent_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} {td+= $2} END {printf("%d"), (ud/td)*100}')

#Last boot:
last_boot=$(who -b | awk '{print $3 " " $4}')

#LVM:
lvm=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvm -eq 0 ]; then echo no; else echo yes; fi)

#Active Connections:
tcp=$(netstat -tunlp | grep tcp | wc -l)

#Users:
usrs=$(users | wc -w)

#Network:
ip=$(hostname -I)
mac=$(ip a | grep ether | awk '{print $2}')

#Commands:
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

#Display output:
wall "
#Architecture: $arch
#CPU Physical: $cpu
#vCPU: $vcpu
#Memory Usage: $used_ram/$total_ram MB ($percent_ram%)
#Disk Usage: $used_disk/$total_disk GB ($percent_disk%)
#CPU load: $cpu_usage
#Last boot: $last_boot
#LVM use: $lvmu
#Connections TCP: $tcp ESTABLISHED
#User log: $usrs
#Network: IP $ip ($mac)
#Sudo: $cmds
"
