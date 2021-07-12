#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/silent-mode/
# Source: https://github.com/kevinfreeman1101/bash-magic/blob/374cf2b8d8acd6e5c7ca8b84d9578f4fe212d7d6/scripts/bash_scripts/fastai_startup.sh
custom_install() {
	local LOG_PATH=$1
	
	md5_of_anaconda_sh=$(sudo md5sum /home/$USER/anaconda.sh)
	md5_of_anaconda_sh_head=${md5_of_anaconda_sh:0:32}
	#while [[ $md5_of_anaconda_sh_head != "17600d1f12b2b047b62763221f29f2bc" ]];
	#do
	update=$(wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh)
	md5_of_anaconda_sh=$(sudo md5sum /home/$USER/anaconda.sh)
	md5_of_anaconda_sh_head=${md5_of_anaconda_sh:0:32}
	#done
	echo $update > "${LOG_PATH}"
}
custom_install "$@"
