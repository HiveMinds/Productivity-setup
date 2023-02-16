#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/silent-mode/
# Source: https://github.com/kevinfreeman1101/bash-magic/blob/374cf2b8d8acd6e5c7ca8b84d9578f4fe212d7d6/scripts/bash_scripts/fastai_startup.sh
custom_install() {
	local LOG_PATH=$1
	make_runnable=$(chmod +x /home/$USER/anaconda.sh)
	update=$(bash /home/$USER/anaconda.sh -b -p /home/$USER/anaconda)
	echo $update > "${LOG_PATH}"
}
custom_install "$@"
