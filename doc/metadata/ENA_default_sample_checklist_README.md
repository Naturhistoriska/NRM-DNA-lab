# Fields in the ENA (extended) data sheet

- Last modified: 2025-11-19 15:45:17
- Sign: JN

Reference: <https://www.ebi.ac.uk/ena/submit/webin/app-checklist/sample/true>

These are the fields present in the default [ENA sample sheet,
`ENA_default_sample_checklist.tsv`](ENA_default_sample_checklist.tsv), given
some additions.

## Mandatory fields

### `tax_id`

Taxonomy ID of the organism as in the NCBI Taxonomy database
(<https://www.ncbi.nlm.nih.gov/Taxonomy>).  Entries in the NCBI Taxonomy
database have integer taxon IDs. See our tips for sample taxonomy here:
<https://ena-docs.readthedocs.io/en/latest/faq/taxonomy.html>.

If no taxon ID is available (e.g., new or unknown species), this have to be
addressed separately before submission. See `scientific_name` below.

### `scientific_name`

Scientific name of the organism as in the [NCBI Taxonomy
database](https://www.ncbi.nlm.nih.gov/Taxonomy). Scientific names typically
follow the binomial nomenclature. For example, the scientific name for humans
is *Homo sapiens*. Note: use the binomen (no authors).

If no bionomen is available, e.g. when there is no taxon ID in ENA database, or
if the species is unknown, this has to be addressed before submission. This
can be done by applying for a new taxonomy (see
<https://ena-docs.readthedocs.io/en/latest/faq/taxonomy_requests.html#requesting-new-taxon-ids>).
If the taxon is from an unknown -- or yet to be described species -- use a
place holder as taxon name.  For example: *Genus sp. 1 US-2024*. See
instructions here:
<https://ena-docs.readthedocs.io/en/latest/faq/taxonomy_requests.html#eukaryotes>.

### `sample_alias`

**Unique** name of the sample. Note: this entry will be used as `LIBRARY_ID` in
the sample sheet for submitting samples for sequencing at NGI (see
<https://github.com/Naturhistoriska/NRM-DNA-lab/#2-ordering-sequences-from-scilifelabngi>).

### `sample_title`

Title of the sample. Here I have used a longer name containing as much
information as possible, but still useful in downstream analyses. For example,
one may consider combining `scientific_name` + `sample_alias` and also perhaps
`specimen_voucher` (if not too complicated): `Genus_species_GS01_NRM12345`.

### `sample_description`

Description of the sample.

### `collection date`

The date the sample was collected with the intention of sequencing, either as
an instance (single point in time) or interval. In case no exact time is
available, the date/time can be right truncated i.e. all of these are valid
ISO8601 compliant times: `2008-01-23T19:23:10+00:00`; `2008-01-23T19:23:10`;
`2008-01-23`; `2008-01`; `2008`. If no date is available, use the string `not
provided`.

### `geographic location (country and/or sea)`

The location the sample was collected from with the intention of sequencing, as
defined by the country or sea. Country or sea names should be chosen from the
INSDC country list (<https://www.ncbi.nlm.nih.gov/genbank/collab/country/>).

## Additional fields

### `tissue_type`

Tissue type from which the sample was obtained.

### `lat_lon`

Geographical coordinates of the location where the specimen was collected. The
preferred format for latitude and longitude in submissions is decimal degrees,
with a positive value for North latitude and East longitude, and a negative
value for South latitude and West longitude. This information is typically
provided combined as `lat_lon` (e.g., `40.7128,-74.0060`).

### `collected_by`

Name of persons or institute who collected the specimen.

### `geographic location (region and locality)`

The geographical origin of the sample as defined by the specific region name
followed by the locality name.

### `identified_by`

Name of the expert who identified the specimen taxonomically.

### `specimen_voucher`

Unique identifier that references the physical specimen that remains after the
sequence has been obtained and that ideally exists in a curated collection. The
ID should have the following structure: name of the institution (institution
code) followed by the collection code (if available) and the voucher id
(`institution_code:collection_code:voucher_id`). Please note institution codes
and collection codes are taken from a controlled vocabulary maintained by the
INSDC: <https://ftp.ncbi.nih.gov/pub/taxonomy/biocollections/>.

### `sub_species`

Name of sub-species of organism from which sample was obtained.

### `variety`

Variety (= *varietas*, a formal Linnaean rank) of organism from which sample
was derived.

