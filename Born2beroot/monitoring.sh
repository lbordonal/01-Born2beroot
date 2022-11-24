# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lbordona <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/23 13:09:08 by lbordona          #+#    #+#              #
#    Updated: 2022/11/24 14:38:48 by lbordona         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

arch=$(uname -a)
cpu=$(nproc)
vcpu=$(
ip=$(hostname -I)
mac=$(ip a | grep ether | awk '{print $2}')

wall "
#Architecture: $arch
#Network: IP $ip ($mac)
#CPU Physical: $cpu
"
