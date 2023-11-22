#!/bin/sh
export JAVA_HOME=$(guix build openjdk@17.0.5 | grep "\-jdk$")
guix shell openjdk@17.0.5:jdk

export JAVA_HOME=$(guix build openjdk@17.0.5 | grep "\-jdk$")
cd ~/git/carisma-tool
guix shell openjdk@17.0.5:jdk -- ./mvnw clean verify
