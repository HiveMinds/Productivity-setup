
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.
	echo "Starting nordvpn1" >&2
	#ovpn_zip_path="/etc/ovpn/"
	ovpn_zip_path="/etc/openvpn/ovpn.zip"
	ovpn_zip_url="https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip"

	# 1. Install our official public software signing key
	#get_ovpn_zip=$(wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip)
	#get_ovpn_zip=$(yes | curl $ovpn_zip_url > "$ovpn_zip_path") # TODO: uncomment to get file
	#get_ovpn_zip=$(wget -O $ovpn_zip_url  "$ovpn_zip_path") # TODO: uncomment to get file

	#update=$(curl --header "Host: dl.twrp.me" --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0" --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" --header "Accept-Language: en-US,en;q=0.5" --referer "$TWRP_URL" --header "Upgrade-Insecure-Requests: 1" --header "Sec-GPC: 1" "$TWRP_LINK" --output "$TWRP_FILEPATH")

	get_ovpn_zip=$(sudo curl --header 'Host: downloads.nordcdn.com' --user-agent 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --cookie '__cfduid=d9bac25457528d40d4d26a49cc9eca9f01620310141' --header 'Upgrade-Insecure-Requests: 1' $ovpn_zip_url --output $ovpn_zip_path)

	#echo $get_ovpn_zip > "${LOG_PATH}"
}
apt_update "$@"