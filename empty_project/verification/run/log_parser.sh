input_log=$1
output_log=regress.log

passed_status='PASS1ED'
failed_status='FAILED'

separator='+-------------------------------------------------------------------------------+'

# echo -e $separator >> $output_log
echo -e  >> $output_log

# grep -o "FAILED\|*E\|UVM_ERROR\|UVM_FATAL" $input_log
var1=`grep -m 1 "*F\|*E\|UVM_ERROR\|UVM_FATAL" $input_log`
if grep -q "*F\|*E\|FAILED\|^ERROR\|UVM_FATAL /\|UVM_ERROR /" $input_log
# if ( var1 > "" )
then
 #   echo  "|                                TEST FAILED                                    |" >> $output_log
	# echo $separator >> $output_log
   echo "    Target : " $input_log | rev | cut -c 5- | rev >> $output_log
   echo "           Has status :  FAILED" >> $output_log
   seed=`grep 'svseed' $input_log | cut -c 5- | tr '[:lower:]' '[:upper:]'`
   echo "             " $seed >> $output_log
   echo "    Errors: " >> $output_log
   echo " "$var1 >> $output_log

   echo ""
   echo "    Target : " $input_log | rev | cut -c 5- | rev
   echo "           Has status :  FAILED"
   seed=`grep 'svseed' $input_log | cut -c 5- | tr '[:lower:]' '[:upper:]'`
   echo "             " $seed
   echo "    Errors: "
   echo " "$var1
   echo ""
	exit 1
else
 #   echo  "|                                TEST PASSED                                    |" >> $output_log
	# echo $separator >> $output_log
   echo "    Target : " $input_log | rev | cut -c 5- | rev >> $output_log
   echo "           Has status :  PASSED" >> $output_log
   seed=`grep 'svseed' $input_log | cut -c 5- | tr '[:lower:]' '[:upper:]'`
   echo "             " $seed >> $output_log
	echo ""
   echo "    Target : " $input_log | rev | cut -c 5- | rev
   echo "           Has status :  PASSED"
   seed=`grep 'svseed' $input_log | cut -c 5- | tr '[:lower:]' '[:upper:]'`
   echo "             " $seed
	echo ""
   exit 0

fi

