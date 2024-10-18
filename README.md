# Netscaler
Useful Resources for managing a Netscaler from a DevOps Security Consultant


## WAF/SignatureManagement

This folder currently contains to scripts that can run or *nix or macOS

Since i am running macOS you need to modify the shell to bash as instructed in the script

### adc_waf_GetSignatures.sh
This script will download the latest Netscaler 13.1 Signatures when executed with no parameters
The script supports parameter release to define in order to fetch signatures for the Netscaler Release 
you are currently running

./adc_waf_GetSignatures.sh release="14.1" will download latest signatures for 14.1

