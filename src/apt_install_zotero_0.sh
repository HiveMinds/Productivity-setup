#!/bin/bash
install_prerequisites() {
	yes | sudo apt install wget
	yes | sudo apt install curl
}
install_prerequisites "$@"