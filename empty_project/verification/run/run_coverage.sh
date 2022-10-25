#!/bin/bash

ITERATIONS=1

for ((i=0; i < $ITERATIONS; i++)) ; do make base_test ;  done
for ((i=0; i < $ITERATIONS; i++)) ; do make base_test ;  done
for ((i=0; i < $ITERATIONS; i++)) ; do make base_test ;  done
for ((i=0; i < $ITERATIONS; i++)) ; do make base_test ;  done

make parsing_all_logs

