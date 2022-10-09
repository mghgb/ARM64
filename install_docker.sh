#!/bin/sh
sudo su
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $USER
