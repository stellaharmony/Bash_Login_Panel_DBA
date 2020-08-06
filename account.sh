#!/usr/bin/bash
# Assign user and password
username="${1}"
password="${2}"
database="feedbyme"
# List the parameter values passed.
echo "Username: " ${username}
echo "Password: " ${password}
echo "Database: " ${database}
ch=0
while [ $ch -ne 3 ]
do
echo ""
echo "===========SELECT YOUR CHOICE=========="
echo ""
echo -e "1.LOGIN\n2.REGISTRATION\n3.EXIT"
echo ""
echo "======================================="
echo "Enter Your Choice:"

read ch
if [ $ch -eq 1 ]
then
echo "==============LOGIN FORM=============="
echo "Enter Your Username"
read u_name
echo "Enter Your Password"
read pass
output=$(mysql -u ${username} -p${password} -D${database} -se "SELECT * FROM users where
username='$u_name' and password='$pass'")
if [ "$output" != "" ];then
echo "LOGIN SUCCESS"
echo "========FEEDBYME ACCOUNT==========="
echo ""
echo "WELCOME !!!"
echo $output|awk '{print $1" "$2 }'
echo ""
echo ""
echo "LOGOUT (Press Any Key to Logout)"
read log_out
else
echo "LOGIN FAILED"
fi
elif [ $ch -eq 2 ]
then
echo "=======REGISTRATION FORM==========="
echo ""
echo "Enter Your First Name"
read fname
if [ "$fname" = "" ]; then
echo "****Error:No Blank First Name Allowed****"
echo "Enter Your First Name"
read fname
fi
echo "Enter Your Last Name"
read lname
if [ "$lname" = "" ]; then

echo "****Error:No Blank Last Name Allowed****"
echo "Enter Your Last Name"
read lname
fi
echo "Enter Your Username"
read usname
if [ "$usname" = "" ]; then
echo "****Error:No Blank User Name Allowed****"
echo "Enter Your UserName"
read usname
fi
echo "Enter Your New Password"
read pass
if [ "$pass" = "" ]; then
echo "****Error:No Blank Password Allowed****"
echo "Enter Your New Password"
read pass
fi
echo "Confirm Password"
read cpass
if [ "$pass" != "$cpass" ];then
echo "****Error:Please Enter Correct Password****"
echo "Enter Your New Password"
read pass
echo "Confirm Password"
read cpass
fi
output=$(mysql -u ${username} -p${password} -D${database} -se "insert into users
values('$fname','$lname','$usname','$pass')")
echo ""
echo "CONGRATULATIONS $fname !!! Your Account Has Been Created"
# INSTEAD OF VIM YOU CAN USE GEDIT OR ANY OTHER EDITOR
touch hello.txt|echo "$fname Your Hello File is Created"|cat > hello.txt|vim hello.txt
exit 0
fi
done