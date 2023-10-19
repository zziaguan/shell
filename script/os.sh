#! /bin/sh
uNames=$(uname -s)
echo $uNames
osName=${uNames: 0: 4}
echo $osName
if [ "$osName" == "Darw" ] # Darwin
then
	echo "Mac OS X"
elif [ "$osName" == "Linu" ] # Linux
then
	echo "GNU/Linux"
elif [ "$osName" == "MING" ] # MINGW, windows, git-bash
then
	echo "Windows, git-bash"
else
	echo "unknown os"
fi
