#!/bin/bash

apt update -y \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
  && apt-get install -y nodejs