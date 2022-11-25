# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lbordona <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 13:09:08 by lbordona          #+#    #+#              #
#    Updated: 2022/11/25 16:49:55 by lbordona         ###   ########.fr        #
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

#DISK:
total_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{td += $2} END {print td}')
used_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} END {print ud}')
percent_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} {td+= $2} END {printf("%d"), (ud/td)*100}')

#LAST BOOT:
last_boot=$(who -b | awk '{print $3 " " $4}')

#LVM:
lvm=$(lsblk | grep "lvm" | wc -l)

lvmt=$()
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)

#NETWORK:
ip=$(hostname -I)
mac=$(ip a | grep ether | awk '{print $2}')

wall "
#Architecture: $arch
#CPU Physical: $cpu
#vCPU: $vcpu
#Memory Usage: $used_ram/$total_ram MB ($percent_ram%)
#Disk Usage: $used_disk/$total_disk GB ($percent_disk%)
#CPU load: $cpu_usage
#Last boot: $last_boot
#LVM use:
#Connections TCP:
#User log:
#Network: IP $ip ($mac)
#Sudo:
"
