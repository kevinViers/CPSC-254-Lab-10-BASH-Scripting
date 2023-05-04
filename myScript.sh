#!/bin/bash

echo "Welcome to my script!"

while true; do
  echo "Please choose an option:"
  echo "0. Exit"
  echo "1. Project Introduction"
  echo "2. File Integrity Check Helper"
  echo "3. Dependency Check Helper"
  echo "4. Credits"
  echo "------------------------------"

  read option

  case $option in
    0) 
      echo "Exiting..."
      exit 0
      ;;
    1) 
      echo "Project Introduction:"
      echo "This script is designed to help you with various tasks related to your project."
      ;;
    2)
      echo "File Integrity Check Helper:"
      echo "This tool will help you check the integrity of your files and ensure they have not been tampered with."
      bash checkFiles.sh
      ;;
    3)
      echo "Dependency Check Helper:"
      echo "This tool will help you check the dependencies of your project and ensure they are up-to-date."
      bash checkDependencies.sh
      ;;
    4)
      echo "Credits:"
      echo "This script was created by the group that brought you Weather254."
      ;;
    *)
      echo "Invalid option, please try again."
      ;;
  esac
done
