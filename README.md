# Netscaler
Useful Resources for managing a Netscaler as a DevOps Security Consultant


## WAF/SignatureManagement

<small>This folder currently contains two scripts that can run or *nix or macOS

Since i am running macOS you need to modify the shell to bash as instructed in the script if you are on a *nix based OS</small>

### adc_waf_GetSignatures.sh
<small>This script will download the latest Netscaler 13.1 Signatures when executed with no parameters  
The script supports parameter release to define in order to fetch signatures for the Netscaler Release   
you are currently running   

./adc_waf_GetSignatures.sh release="14.1" will download latest signatures for 14.1
</small>

### adc_waf_ModifySignatures.sh  

<small> The script is intended to be used after running the adc_waf_GetSignatures.sh script  
The adc_waf_GetSignatures.sh will write a signature xmlfile to the folder you executed the script from  
i.e the file sig-r13.1b0v139s8.xml will be downloaded as the latest signature as of Friday 18th of October 2024.  

Use the adc_waf_ModifySignatures.sh script to create a new signature file based on the input file  
The script is currently made to enable / disable based on category with a defined action.

i.e ./adc_waf_ModifySignatures.sh sig-r13.1b0v139s8.xml sig-r13.1b0v139s8_customized.xml "web-cgi,web-misc" ON "log,stats"

## Requirements for the scripts to work as intended

curl
xmllint
xmlstarlet
