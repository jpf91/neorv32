#!/bin/bash

# Abort if any command returns != 0
set -e

# NEORV32 project home folder
homedir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
homedir=$homedir/..

# The directories of the SW source files
srcdir_examples=$homedir/sw/example
srcdir_bootloader=$homedir/sw/bootloader
test_app_dir=$homedir/sw/example/test_exceptions

# List files
ls -al $srcdir_examples
ls -al $srcdir_bootloader

# check toolchain
make -C $test_app_dir check

# Compile all example projects
make -C $srcdir_examples clean_all info compile

# Compile and install bootloader
make -C $srcdir_bootloader clean_all info bootloader

# Compile and install test application
echo "Installing test application"
make -C $test_app_dir clean_all MARCH=-march=rv32imc info all

# Verification reference string
touch reference.out
chmod 777 reference.out
echo "TEST OK!" > reference.out

# DEBUGGING
pwd
ls -al
