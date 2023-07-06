# Support scripts used in the woorkflow

## 1. bgi_to_id.sh
  The scrpt uses as input a tsv file with the association between the sample id of BGI and the patients ids (ID_associations.txt).
  Only one aguments has to be given to the  script, which is the inside of the metaphlan directory where the results are strored. 
  The new files will be copied into a new directory named "id_profiles".

## 2. merge_metaphlan_abs.py
  Python script developed by biobakers' user [timyerg](https://forum.biobakery.org/u/timyerg), that merges the absolute counts from all metaphlan's sample in a directory.
  It works in the same way as Metaphlan's own script
