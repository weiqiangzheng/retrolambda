#!/bin/bash
set -eux

# Run end-to-end tests against all supported Java versions

mvn clean verify \
    --errors \
    -P noDefaultMethods
mvn clean verify \
    --errors

mvn clean verify \
    --errors \
    -P java6,noDefaultMethods
mvn clean verify \
    --errors \
    -P java6

mvn clean verify \
    --errors \
    -P java5,noDefaultMethods
mvn clean verify \
    --errors \
    -P java5

# Test the forking mechanism

mvn clean verify \
    --errors \
    -P fork,noDefaultMethods
mvn clean verify \
    --errors \
    -P fork

# The Maven plugin's minimum requirement is Java 6,
# but then the plugin must force forking the process

JAVA_HOME="$JAVA6_HOME" mvn clean verify \
    --errors \
    -P java6

# Java 9 has stricter bytecode validation than Java 8,
# so make sure that Retrolambda can run under Java 9 (without forking)

JAVA_HOME="$JAVA9_HOME" mvn clean verify \
    --errors
