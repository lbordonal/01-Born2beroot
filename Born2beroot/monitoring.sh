# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lbordona <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 13:09:08 by lbordona          #+#    #+#              #
#    Updated: 2022/11/24 14:40:44 by lbordona         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

arch=$(uname -a)
cpu=$(nproc)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
ip=$(hostname -I)
mac=$(ip a | grep ether | awk '{print $2}')

wall "
#Architecture: $arch
#CPU Physical: $cpu
#vCPU: $vcpu
#Network: IP $ip ($mac)
"
