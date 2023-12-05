#!/bin/sh
export JAVA_HOME=$(guix build openjdk@17.0.5 | grep "\-jdk$")
guix shell openjdk@17.0.5:jdk
