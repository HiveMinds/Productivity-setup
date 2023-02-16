
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	
	# TODO: ommit prompt for password if user is already logged into nordvpn
	# (note connected to a nordvpn server is something else than being logged into nordvpn)
	read -p "Please enter your nordvpn username (e.g. an email):" username
	read -p "Please enter your nordvpn pw:" password
	
	nordvpn_login=$(nordvpn login --username $username --password $password)
	
	echo "output:$nordvpn_login" >&2
	echo $nordvpn_login > "${LOG_PATH}"
}
apt_update "$@"