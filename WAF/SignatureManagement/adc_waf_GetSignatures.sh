#!/bin/zsh

#if running on a linux machine replace line 1 with #!/bin/bash

# I am running on macOS

# Script written by Kai Thorsrud Sicra A/S
# Use this script the way you find it usable
# Contant kai@sicra.no || kai@thorsrud.io

# This will download the latest version of etscaler WAF Signatures
# supported parameter: release="x.y" i.e release="14.1"
# If the script is executed without any parameters it willl default to 13.1 (Current stable release as of writing)



# For Beginners a simple howto
# 1 chmod +x adc_waf_GetSignatures.sh
# 2 ./adc_waf_GetSignatures.sh release="14.1"

# Define the default release version
default_release="13.1"

# Check if a release parameter is passed
if [[ $1 == release=* ]]; then
  release_version="${1#release=}"
else
  release_version="$default_release"
fi

# Define Location of XML Document Containing references to latest Netscaler WAF Signature File
sig_url="https://s3.amazonaws.com/NSAppFwSignatures/SignaturesMapping.xml"

# Download Latest Signature Mapping File
curl -O "${sig_url}"

# Extract file path based on the specified release version
file_path=$(xmllint --xpath "string(//Signature[@release=\"$release_version\"]/sig_file/file)" SignaturesMapping.xml)

# Check if file_path is empty
if [[ -z "$file_path" ]]; then
  echo "Error: File path not found for release $release_version."
  exit 1
fi

# Define the base URL
base_url="https://s3.amazonaws.com/NSAppFwSignatures"  # Replace with the actual base found in the ADC GUI If this URL no longer works

# Download the file using curl
curl -O "${base_url}/${file_path}"
