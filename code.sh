cat "topbeat_output.txt" | while read LINE
do
                #echo $bool
                if [[ $LINE == *"timestamp"* ]]
                then
                        arr=($LINE)
                        echo "At time:" ${arr[1]}
                fi
                if [[ $LINE == *"cpu"*  ]]
                then
                        bool=1
                fi
                if [[ $bool -eq 1 ]] && [[ $LINE == *"\"user\""* ]]
                then
                        arr=($LINE)
                        num=${arr[1]}
                fi
                if [[  $LINE == *"\"system\""* ]]
                then
                        arr=($LINE)
                        echo "In CPU Usage, User uses " $num ", system uses " ${arr[1]}
                fi
                if  [[ $LINE == *"mem"*  ]]
                then
                        bool=5
                fi
                if [[ $bool -eq 5 ]] && [[  $LINE == *"total"*  ]]
                then
                        arr=($LINE)
                        num=${arr[1]}
                fi
                if [[ $bool -eq 5 ]] && [[ $LINE == *"used"* ]]
                then
                        arr=($LINE)
                        num1=${arr[1]}
                fi
                if [[  $bool -eq 5 ]] && [[ $LINE == *"free"* ]]
                then
                        arr=($LINE)
                        num2=${arr[1]}
                        bool=1
                        echo "In Total Memory of " $num ", used memory is " $num1 ", and free memory is " $num2
                fi
done
