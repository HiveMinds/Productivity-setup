# Remove some artifact error:
sudo apt-get install --reinstall libcanberra-gtk*

# Get vscode
xdg-open https://code.visualstudio.com/docs/?dv=linux64_deb
cd ~/Downloads
yes | sudo dpkg -i code*amd64.deb

# Generate ssh key
ssh-keygen -t ed25519 -C "your_email@example.com"
read - p "Did you enter all the way?"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519
xdg-open https://github.com/settings/ssh/new

# Always show hidden folders.
gsettings et org.nemo.desktop show-desktop-icons true

# Set the dark theme
gsettings set org.gnome.desktop.interface gtk-theme Yaru-dark
gsettings set org.gnome.desktop.interface cursor-theme Yaru-dark

gsettings set org.nemo.icon-view captions "['size', 'type', 'date_accessed', 'date_modified']"

# Also show files in the side panel of the file explorer
#gsettings set org.nemo.sidebar-panels.tree show-only-directories false


echo `PS1="\[\e[1m\]\u@\h \w\n\$\[\e[0m\] "` > temp.sh
