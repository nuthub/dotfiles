#!/usr/bin/env -S guix shell --container --network --emulate-fhs coreutils bash openjdk@17.0.5:jdk -- sh

export PATH=/home/flake/Applications/apache-maven-3.9.1/bin:$PATH
bash
