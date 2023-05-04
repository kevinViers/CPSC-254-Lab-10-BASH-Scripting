#!/bin/bash

# Prompt the user for the paths to the two folders
read -p "Enter the path to the local folder: " local_path
read -p "Enter the path to the publisher's folder: " publisher_path

# Check if the folders exist
if [[ ! -d "$local_path" || ! -d "$publisher_path" ]]; then
  echo "Error: one or both of the specified folders do not exist."
  exit 1
fi

# Loop through the files in the local folder and compare their checksums to the corresponding files in the publisher's folder
while read -r local_file; do
  publisher_file="$publisher_path/$(basename "$local_file")"
  
  if [[ -f "$publisher_file" ]]; then
    local_checksum=$(md5sum "$local_file" | cut -d ' ' -f 1)
    publisher_checksum=$(md5sum "$publisher_file" | cut -d ' ' -f 1)
    
    if [[ "$local_checksum" == "$publisher_checksum" ]]; then
      echo "Checksums match: $local_file"
    else
      echo "Checksums do not match: $local_file"
    fi
  else
    echo "File not found in publisher's folder: $local_file"
  fi
done < <(find "$local_path" -type f)
