#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Use: $0 <contacts.csv>"
    exit 1
fi

csv_file="$1"
vcf_file="${csv_file%.csv}.vcf"

if [[ ! -f "$csv_file" ]]; then
    echo "Error: File '$csv_file' not found!"
    exit 1
fi

rm -f "$vcf_file"

while IFS=',' read -r first_name last_name company_name address city county state zip phone1 phone email; do

    if [[ "$first_name" == "first_name" ]]; then
        continue
    fi

    echo "BEGIN:VCARD" >>"$vcf_file"
    echo "VERSION:3.0" >>"$vcf_file"
    echo "FN:$first_name $last_name" >>"$vcf_file"
    echo "ORG:$company_name" >>"$vcf_file"
    echo "ADR:;;$address;$city;$state;$zip;$county" >>"$vcf_file"
    echo "TEL;TYPE=WORK:$phone1" >>"$vcf_file"
    echo "EMAIL:$email" >>"$vcf_file"
    echo "END:VCARD" >>"$vcf_file"
    echo "" >>"$vcf_file"

done <"$csv_file"

echo "VCF file '$vcf_file' has been generated successfully!"
