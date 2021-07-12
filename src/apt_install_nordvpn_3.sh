
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn3" >&2
	
	nordvpn_autoconnect=$(nordvpn set autoconnect on nl771)
	echo "output:$nordvpn_autoconnect" >&2
	echo $nordvpn_autoconnect > "${LOG_PATH}"
}
apt_update "$@"