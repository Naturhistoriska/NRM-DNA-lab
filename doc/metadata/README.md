# Metadata

- Last modified: ons sep 27, 2023  05:13
- Sign: nylander

## Description

A sample template for submitting data to ENA can be found in this repository
(see below), but also downloaded through ENA's [Webin
portal](https://ena-docs.readthedocs.io/en/latest/submit/general-guide/submissions-portal.html).

The use of the Webin portal requires registration (adding e-mail addresses for
users), and the NRM DNA-lab have an account: **Webin-65361**. Ask around for
the password!

### Steps for getting a sample sheet from ENA

1. Log in to the [Webin portal](https://www.ebi.ac.uk/ena/submit/webin/login),
   and under `Samples`, click on `Register Samples`. On the next page, click on
   `Download spreadsheet to register samples`.
2. For a "standard" analysis (e.g. WGS from several samples), choose `Other
   Checklists`. Then the `ENA default sample checklist` would be appropriate
   for most studies.
3. Select the fields applicable. Pay attention to the mandatory fields and the
   section of Optional Fields. Some/many of the Optional fields can be vary
   valuable to collect in one place.). Then click on `Next`, followed by
   `Download TSV Template`.  An example of the minimal ENA sample tsv template
   file (30 Sept 2023) can be found here:
   [`ENA_default_sample_checklist.tsv`](ENA_default_sample_checklist.tsv), and
   a submitted sample checklist can be found here:
   [`ENA_sample_checklist_Azure.tsv`](ENA_sample_checklist_Azure.tsv).
4. Open the file in, e.g., MS Excel and add samples.

Detailed information for each field can be found in the step **3.** above, or
here for the default sample example:
[`ENA_default_sample_checklist_README.md`](ENA_default_sample_checklist_README.md).

**Important**

- For `sample_alias`, do not use special characters or white space, and make
  sure those entries are unique.
- New taxon? Use a place-holder name, e.g., `Genus sp_nov_1`. More details on
  new taxa can be found here:
  <https://ena-docs.readthedocs.io/en/latest/faq/taxonomy_requests.html>.

### Links

- <https://ena-docs.readthedocs.io/en/latest/submit/general-guide.html>
- <https://ena-docs.readthedocs.io/en/latest/submit/general-guide/metadata.html>

