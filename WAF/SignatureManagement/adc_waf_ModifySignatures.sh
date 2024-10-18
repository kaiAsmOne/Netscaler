#!/bin/zsh

#if running on a linux machine replace line 1 with #!/bin/bash
# I am running on macOS

# Script written by Kai Thorsrud Sicra A/S
# Use this script the way you find it usable
# Contant kai@sicra.no || kai@thorsrud.io

# Possible values for categories / $3 = Drupal, HTTP.sys, WEB-MISC, web-activex, web-cgi, web-client, web-coldfusion, web-frontpage, web-iis, web-misc, web-msic, web-php, web-shell-shock, web-struts, web-wordpress



# For beginners: This is how you do it   

#Step 1:  remember to chmod +x adc_waf_ModifySignatures.sh to make the script executable
#Step 2: ./adc_waf_ModifySignatures.sh sig-r13.1b0v139s8.xml sig-r13.1b0v139s8_customized.xml "web-cgi,web-misc" ON "log,stats"
   


# Check if the correct number of arguments are provided
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <input_file.xml> <output_file.xml> <categories> <enabled_value> <actions_value>"
    echo "enabled_value should be either 'ON' or 'OFF'"
    exit 1
fi

INPUT_FILE=$1
OUTPUT_FILE=$2
CATEGORIES=$3
ENABLED_VALUE=$4
ACTIONS_VALUE=$5

# Validate enabled_value
if [ "$ENABLED_VALUE" != "ON" ] && [ "$ENABLED_VALUE" != "OFF" ]; then
    echo "enabled_value should be either 'ON' or 'OFF'"
    exit 1
fi

# Convert categories to XPath OR condition
CATEGORY_CONDITION=$(echo "$CATEGORIES" | sed "s/,/\' or @category=\'/g")

# Use xmlstarlet to modify the enabled and actions attributes for the specified categories
xmlstarlet ed -u "//SignatureRule[@category='$CATEGORY_CONDITION']/@enabled" -v "$ENABLED_VALUE" \
              -u "//SignatureRule[@category='$CATEGORY_CONDITION']/@actions" -v "$ACTIONS_VALUE" \
              "$INPUT_FILE" > "$OUTPUT_FILE"

echo "The enabled attribute has been set to $ENABLED_VALUE and actions attribute to $ACTIONS_VALUE for SignatureRule elements with categories $CATEGORIES. Output saved to $OUTPUT_FILE"
