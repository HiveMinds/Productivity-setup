# What is this? [![Build Status](https://travis-ci.org/a-t-0/Taskwarrior-installation.svg?branch=refactor_to_shell)](https://travis-ci.org/a-t-0/Taskwarrior-installation)
This is a set of bash scripts and that automatically install an opinonated student/developer setup on Ubuntu 20.04 with an **emphasis** on productivity and focus. It empowers the user to select actively which information the user wants to consume by fencing off undesired digital tempations. It is opinionated in the sense that it blocks all social media, youtube, image searches, news sites and adult content. Not because I think they are bad, instead it is because I am highly passionate about the opportunities that I am given and I want to give those opportunities and pursuits my complete dedication.

## Usage: Installation
Install git and download this repository:
```
sudo apt update
yes | sudo apt install git
git clone https://github.com/HiveMinds-EU/Productivity-setup
```
Run the main code from the root of this repository with:
```
./main.sh
```
to get a list of yes/no questions on which software you want to install. After completing the list, this repository will automatically install and configure what you chose. If you already know what you want, you can also skip the list and just type *(for example)*:
```
./main.sh --install zotero signal nordvpn
```
You can do a full uninstall of Anaconda it with:
```
./src/uninstall.sh
```
the uninstallation of the other packages is not yet created.


## Usage: Testing
First install the required submodules with:
```
rm -r test/libs/*
chmod +x install-bats-libs.sh
./install-bats-libs.sh
```

Next, run the unit tests with:
```
chmod +x test.sh
./test.sh
```
Note: Put your unit test files (with extention .bats) in folder: `/test/`


## Functionality
Unit tests bash code/scripts and provides continuous integration testing through Travis CI. Intended to be built as a two-line command that sets up a laptop for productivity right after a clean Ubuntu image installation.


## Structure of repository
To start development it is nice to understand how the code is currently structured. This structure is explained in three segments, installation, uninstallation and testing.
### Installation
The installation files are located in `/src/`, and they are called by `/main.sh`. The exact "scoping" of the code follows: 
 1. The `main.sh` reads which software packages are supported by this repo from the hardcoded [supported_software.txt](https://github.com/HiveMinds-EU/Productivity-setup/blob/main/src/supported_software.txt).
 2. Then it passes that list to the [ask_user_choice.sh](https://github.com/HiveMinds-EU/Productivity-setup/blob/main/src/ask_user_choice.sh) which loops through all the types of installations, e.g. `apt`, `snap` and `custom` installations, and per installation type, loops through all the software packages that are supported by this software. For every supported software package and asks the user: "do you want to use this package?"
 3. Then the user answers y/n, and accordingly, the `supported_software.txt` is recreated in `/src/logs/selected_software.txt` with only the software packages that the user selected. 
 4. Next, the `main.sh` installs those packages using the [install_user_choice.sh](https://github.com/HiveMinds-EU/Productivity-setup/blob/main/src/install_user_choice.sh) script. This script is called once for each package that is to be installed, and using a switch statement made of if-else's, it calls the main installation script for each package, for example `apt_signal.sh`. This main installation script then calls a separate script for each command that has to be completed for the installation. This is so that each command can be separately tested (ideally during installation). An example of such a command-script would be: `apt_3_2_install_signal.sh` where the naming convention currently is: `<installation type>_<nth software package that is being supported for that installation type>_<nth command that is required to install the software package>_<install (to indicate it is an installation instead of uninstallation script)>_<software package name>.sh`.
 5. A note, after each software package, a set of tests is performed to determine whether the installation of this package was successfull. More details on this can be found below under "testing".
### Uninstallation
The structure of uninstallation is analogous to the installation structure. In short:
 1. The `/uninstall.sh` also goes through the list of hardcoded [supported_software.txt](https://github.com/HiveMinds-EU/Productivity-setup/blob/main/src/supported_software.txt).
 2. Then it similarly asks the user which software packages the user wants to uninstall (currently only the full uninstallation anaconda is supported).
 3. Then the user answers y/n, and accordingly, the `supported_software.txt` is recreated in `/src/logs/selected_software.txt` with only the software packages that the user selected.
 4. Next, similarly to the installation, the uninstallation calls a main uninstallation script, e.g. `custom_uninstall_anaconda.sh` which, (ideally), calls a separate script for each separate uninstallation command. An example of such an uninstallation command-script would be: `custom_uninstall_1_anaconda.sh` where the naming convention currently is: `<installation type>_<nth command that is required to install the software package>_<install (to indicate it is an installation instead of uninstallation script)>_<software package name>.sh`.
 5. A note, after each software package, a set of tests is performed to determine whether the uninstallation of this package was successfull. More details on this can be found below under "testing".

### Testing
There are currently three sets of tests in this repository. A post installation test, a post uninstallation test, and an installation test. They are described below.
#### Post-installation tests
Right after an installation test is ran, the results are tested. The tests are called through the chain of `main.sh>install_user_choice.sh> some software package installer.sh`. For example, the function `test_signal()` in [/src/apt_signal.sh](https://github.com/HiveMinds-EU/Productivity-setup/blob/update-readme/src/apt_signal.sh) calls: `test/post_setup/test_apt_install_signal_postsetup.bats`. This then tests the log file(s) that is/are created for each command that is used to install the software package `signal`. The tests may also test some expected results/system properties that should emerge out of the installation. For example the `git --version` command should give a version of git back after installation of git.
#### Post-uninstallation test
Post-uninstallation tests are structured in the same way, except they test different properties, as the result of an uninstallation is different than the result of an installation.

#### Installation tests
The installation tests are the same tests as the post-installation tests. The only difference is that they include a `setup()` function which automatically installs each software package, and then runs the test. Therefore, these tests provide the opportunity to automatically test all the functions without user input. This enables CI testing.
