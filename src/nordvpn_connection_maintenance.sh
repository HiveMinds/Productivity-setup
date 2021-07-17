#!/bin/bash

get_nordvpn_status() {
	nord_vpn_status=$(nordvpn status)
	echo $nord_vpn_status
}

connect_nordvpn() {
	nord_vpn_connection=$(nordvpn connect)
	echo $nord_vpn_connection
}

# Start infinite loop that keeps system connected to vpn
while [ "false" == "false" ]
do
	
	# Get nordvpn connection status
	nord_vpn_status_outside=$(get_nordvpn_status)
	echo "nord_vpn_status_outside=$nord_vpn_status_outside" >&2
	sleep 1
	
	# Reconnect nordvpn if the system is disconnected.
	if [[ "$nord_vpn_status_outside" == *"Disconnected"* ]]; then
		echo "Is Disconnected"
		nord_vpn_connections=$(connect_nordvpn)
	elif [[ "$nord_vpn_status_outside" == *"Status: Connected Current server:"* ]]; then
		echo "Is connected"
	fi
done
