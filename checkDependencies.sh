#!/bin/bash

# List the dependencies required to run the project
dependencies=(
  "AndroidX Core KTX: androidx.core:core-ktx:1.10.0"
  "AndroidX AppCompat: androidx.appcompat:appcompat:1.6.1"
  "Material Design Library: com.google.android.material:material:1.8.0"
  "AndroidX Constraint Layout: androidx.constraintlayout:constraintlayout:2.1.4"
  "JUnit: junit:junit:4.13.2"
  "AndroidX Test Extension JUnit: androidx.test.ext:junit:1.1.5"
  "Espresso: androidx.test.espresso:espresso-core:3.5.1"
  "Retrofit: com.squareup.retrofit2:retrofit:2.9.0"
  "Retrofit Gson Converter: com.squareup.retrofit2:converter-gson:2.9.0"
)

# Loop through the dependencies and check if each one is available on the current environment
missing_dependencies=()
for dependency in "${dependencies[@]}"; do
  # Extract the dependency name, group ID, artifact ID and version
  dependency_name=$(echo "$dependency" | awk '{print $1}')
  group_id=$(echo "$dependency" | awk -F ':' '{print $1}')
  artifact_id=$(echo "$dependency" | awk -F ':' '{print $2}')
  version=$(echo "$dependency" | awk -F ':' '{print $3}')
  
  # Check if the dependency is available
  if ! mvn -q dependency:get -Dartifact="$group_id:$artifact_id:$version" >/dev/null 2>&1; then
    missing_dependencies+=("$dependency_name")
  fi
done

# Print the list of missing dependencies and the command to install each one
if [[ ${#missing_dependencies[@]} -eq 0 ]]; then
  echo "All dependencies are installed."
else
  echo "The following dependencies are missing: ${missing_dependencies[*]}"
  echo "To install them, run the following commands:"

  for dependency in "${dependencies[@]}"; do
    dependency_name=$(echo "$dependency" | awk '{print $1}')
    group_id=$(echo "$dependency" | awk -F ':' '{print $1}')
    artifact_id=$(echo "$dependency" | awk -F ':' '{print $2}')
    version=$(echo "$dependency" | awk -F ':' '{print $3}')

    if [[ " ${missing_dependencies[@]} " =~ " $dependency_name " ]]; then
      echo "mvn dependency:get -Dartifact=$group_id:$artifact_id:$version"
    fi
  done
fi
