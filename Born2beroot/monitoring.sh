# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lbordona <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 13:09:08 by lbordona          #+#    #+#              #
#    Updated: 2022/11/25 12:53:13 by lbordona         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#Architecture:
arch=$(uname -a)

#CPU:
cpu=$(nproc)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)

#RAM:
total_ram=$(free -m | awk '$1 == "Mem:" {print $2}')
used_ram=$(free -m | awk '$1 == "Mem:" {print $3}')
percent_ram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

#DISK:
total_disk=$(df -h | awk '$1 == "/dev/sda1" {print $2}')
used_disk=$(df -h | awk '$1 == "/dev/sda1" {print $3}')
percent_disk=$(df -h | awk '$1 == "/dev/sda1" {print $5}')

#NETWORK:
ip=$(hostname -I)
mac=$(ip a | grep ether | awk '{print $2}')

wall "
#Architecture: $arch
#CPU Physical: $cpu
#vCPU: $vcpu
#Memory Usage: $used_ram/$total_ram MB ($percent_ram)%
#Disk Usage: $used_disk/$total_disk ($percent_disk)
#Network: IP $ip ($mac)
"
