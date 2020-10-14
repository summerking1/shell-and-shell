
#!/bin/bash
 
num=0
str='#'
max=100
pro=('|' '/' '-' '\')
while [ $num -le $max ]
do
	((color=30+num%8))
	echo -en "\e[1;"$color"m"
	let index=num%4
	printf "[%-100s %d%% %c]\r" "$str" "$num" "${pro[$index]}"
	let num++
	sleep 0.1
	str+='#'
done
printf "\n"
echo -e "\e[1;30;m"
