#!/bin/bash
PS3="Run command, entery your choice [ 1-5 ]: "

select choice in date w hostname "uname -a" exit
do
    case $choice in
        date )
            echo "------------------------"
            echo "Current system date and time:"
            echo "------------------------"
            $choice
            ;;
        w)
            echo "------------------------"
            echo "Who is logged on and whate they are doing:"
            echo "------------------------"
            $choice
            ;;
        hostname)
            echo "------------------------"
            echo "Hostname:"
            echo "------------------------"
            $choice
            ;;
        "uname -a")
            echo "------------------------"
            echo "System information:"
            echo "------------------------"
            $choice
            ;;
        exit)
            echo "------------------------"
            echo "Bye!"
            echo "------------------------"
            $choice
            ;;
    esac
done
