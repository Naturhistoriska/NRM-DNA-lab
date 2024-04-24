#!/bin/bash

## Fetch ENA taxonomy ID for scientific name.
## Last modified: ons apr 24, 2024  04:18
## By: Johan.Nylander@nrm.se
## Usage: ./sci2taxid_ENA.sh infile-with-scientific-names

set -euo pipefail
while IFS= read -r org ; do
    orgn="${org// /%20}"
    resp=$(curl "https://www.ebi.ac.uk/ena/taxonomy/rest/scientific-name/${orgn}" 2>/dev/null)
    if [ "$resp" = "[ ]" ] ; then
        echo "$org,NoTaxId"
    else
        echo "$resp" | \
        sed 's/,//g' | \
        sed 's/"//g' | \
        grep 'taxId' | \
        awk -v var="$org" '{print var","$3}'
    fi
done <${1:-/dev/stdin}

