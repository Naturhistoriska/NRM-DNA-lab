#!/bin/bash

## Fetch ENA taxonomy ID for scientific name.
## Last modified: mån apr 22, 2024  01:54
## By: Johan.Nylander@nrm.se
## Usage: ./sci2taxid_ENA.sh infile-with-scientific-names

set -euo pipefail

#author_email_address='johan.nylander@nrm.se'
#name_of_script='sci2taxid'
#econtact -email ${author_email_address} -tool ${name_of_script}

while IFS= read -r org ; do
    orgn="${org// /%20}"
    curl "https://www.ebi.ac.uk/ena/taxonomy/rest/scientific-name/${orgn}" 2>/dev/null | \
        sed 's/,//g' | \
        sed 's/"//g' | \
        grep 'taxId' | \
        awk -v var="$org" '{print var","$3}'
done <${1:-/dev/stdin}

