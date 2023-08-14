#!/bin/bash

SDK_TOP_DIR=".."
SDK_VERSION=v1.06


function show_notice()
{
    echo ""
    echo -e "\033[32m===============Attention Please======================\033[0m"
    echo "1) From http://www.rtcore.cn instead of rockchip."
    echo "2) You should backup your own change."
    echo "2) We will copy some files or overrid some files."
    echo "3) All the source files are in this directory"
    tree
    echo -e "\033[32m=====================================================\033[0m"
    echo ""
}

function check_dir()
{
    if [ ! -d "$1" ]; then
        echo -e "\033[31m Can't find $1 directory!\033[0m"
        echo -e "\033[31m You should copy these under you SDK!\033[0m"
        exit
    fi
}


function apply_change()
{

    echo -e "\033[32m=========>>>apply change\033[0m"
	#tar cf - --strip-components=1 $SDK_VERSION/device $SDK_VERSION/kernel | tar xf - -C ../
	tar cf -  -C $SDK_VERSION . | tar xf - -C ../
    echo -e "\033[32m=========>>>apply change finished\033[0m"
}

function confirm_change()
{
    read -r -p "Are You Sure do that? [Y/n] " input

    case $input in
        [yY][eE][sS]|[yY])
            apply_change
            ;;

        [nN][oO]|[nN])
            echo "No"
            ;;

        *)
            echo "Invalid input..."
            exit 1
            ;;
    esac
}

show_notice
check_dir "$SDK_TOP_DIR/kernel"
check_dir "$SDK_TOP_DIR/u-boot"
check_dir "$SDK_TOP_DIR/device"

if [ $# -eq 1 ];then
	SDK_VERSION=$1
fi

if [ "$SDK_VERSION" == "" ];then
	echo -e "\033[31m Please set SDK_VERSION before patch.\033[0m"
	exit
fi
echo "SDK_VERSION=$SDK_VERSION"

if [ ! -d $SDK_VERSION ];then
	echo -e "\033[31m No SDK_VERSION: $SDK_VERSION.\033[0m"
	exit
fi

confirm_change
