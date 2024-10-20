
# Netscaler
Useful Resources for managing a Netscaler as a DevOps Security Consultant

## Folder: WAF/SignatureManagement

<small>This folder currently contains two scripts that can run on *nix or macOS.

Since I am running macOS, you need to modify the shell to bash as instructed in the script if you are on a *nix-based OS.</small>

### adc_waf_GetSignatures.sh
<small>This script will download the latest Netscaler 13.1 Web Application Firewall Signatures when executed with no parameters.  
The script supports the parameter "release" to specify the version of signatures of the Netscaler Release you are currently running.   

./adc_waf_GetSignatures.sh release="14.1" will download latest signatures for 14.1
</small>

### adc_waf_ModifySignatures.sh  

<small>This script is intended to be used after running the adc_waf_GetSignatures.sh script.  
The adc_waf_ModifySignatures.sh will write a new signature XML file to the folder you executed the script from.  
i.e., the file sig-r13.1b0v139s8.xml will be downloaded as the latest signature as of Friday, 18th of October 2024.  

Use the adc_waf_ModifySignatures.sh script to create a new signature file based on the input file.  
The script is currently made to enable/disable based on category with a defined action.

i.e., ./adc_waf_ModifySignatures.sh sig-r13.1b0v139s8.xml sig-r13.1b0v139s8_myplatform.xml "web-cgi,web-misc" ON "log,stats"

I am currently using these scripts to create Signature Templates for different platforms such as IIS / Apache / Tomcat / Whatever

## Requirements for the scripts to work as intended

curl
xmllint
xmlstarlet

## Why do we need these scripts? (And why bother using Netscaler)
<small>As per my findings, the Netscaler has, like most other enterprise products, complexity due to evolution.   

Netscaler is a product initially created by Sun Microsystems.  
Sun Microsystems was one of the few companies that worked with SMP in the "Single CPU" era.  
(SMP = Symmetric multiprocessing back then was mostly several physical CPU´s)  
Due to Sun Microsystems knowledge, the Netscaler internals are designed for SMP, spawning separate packet processing engines per core, very similar to the way containers work today.  

This is why Netscaler works so well in the cloud due to the packet processing engine architecture (how it can handle such high load with cheap hardware).  
Todays CPU´s are multiple Cores and multiple threads but still software developers struggle to design code that scales beyond using a single core per "program" or system. 
(One of the many reasons why containers are so popular)  

The above statement is a big benefit and explains why Netscaler is capable of serving huge amounts of traffic due to several good architectural considerations.
I used to be all into ASIC and Cisco, but companies now struggle with the change to a generic software-based approach thus equally struggeling to scale well in the cloud.  
These systems ususally require very large Virtual Machines or struggle to perform due to the initial ASIC based design.  

Furthermore Netscaler runs on FreeBSD. The BSD Line of *nix systems are known as one of the most secure Operating Systems / The OS with the fewest CVE´s recorded. 


Back on track regarding the scripts:  

Netscaler GUI used to be Java client-side:

Even though they were smart enough to implement everything as a REST API from the early days (NITRO API), the WAF Signature management REST API = NITRO API = Terraform citrixadc_appfwsignatures.  
The API /nitro/v1/config/appfwsignatures seems to only support management of an entire signature database.  
Hence, we are not able to manage or operate WAF Signatures properly in a DevOps environment.   

I am trying to find a good way to handle configuration of one entity / one signature,  
but as per my understanding, we have to post the entire signature database back to the Netscaler for every single small change. 

The scripts in this repo aim to solve this problem, allowing true blue/green deployments or true canary deployments by enabling 100% configuration by code in a DevOps pipeline.

</small>
