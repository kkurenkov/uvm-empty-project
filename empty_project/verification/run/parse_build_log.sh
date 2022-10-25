#!/bin/bash

count_fail=0
count_pass=0
exit_code=0

ls ../logs/*.log | awk '{print $1}' > list.log
x=`wc ./list.log | awk '{print $1}'`
for i in $(seq 1 1 $x)
do

	head -$i ./list.log | tail -1 | xargs ./log_parser.sh

	e_code=$?
	if [ $e_code == 0 ]; then
	  count_pass=$(( $count_pass + 1 ))
	else
	  count_fail=$(( $count_fail + 1 ))
	  exit_code=1
	fi

done

if [ $count_pass == 0 ]; then
	exit_code=1
fi

echo   
echo  "+------------------------------+"
echo  "+--      PASSED TEST $count_pass	     --+"
echo  "+--      FAILED TEST $count_fail	     --+"
echo  "+------------------------------+"
echo   


exit $exit_code