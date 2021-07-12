#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/silent-mode/
# Source: https://github.com/kevinfreeman1101/bash-magic/blob/374cf2b8d8acd6e5c7ca8b84d9578f4fe212d7d6/scripts/bash_scripts/fastai_startup.sh

# Install Conda
#bash ~/anaconda.sh -b -p $HOME/anaconda
echo "COMPLETED LINE 6 bash b p" > "./src/logs/custom_6_anaconda_install.txt"
eval "$(/home/$USER/anaconda/bin/conda shell.bash hook)"
echo "COMPLETED LINE 8 eval hook"  > "./src/logs/custom_6_anaconda_install.txt"
conda init
echo "COMPLETED LINE 10 conda init" > "./src/logs/custom_6_anaconda_install.txt"
sync
echo "COMPLETED LINE 12 sync" > "./src/logs/custom_6_anaconda_install.txt"
conda install conda --y
echo "COMPLETED LINE 14 conda install conda y" > "./src/logs/custom_6_anaconda_install.txt"