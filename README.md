# synonym_engine
French synonym search engine based on Perl regex and XML traversal. The chosen XML corpus (rali.iro.umontreal.ca/DEM//DEM-1_1.xml.zip) encodes extensively around 70k French words, including their domain use, semantic features, and syntactic particularities.

The XML tree traversal algorithm retrieves the relevant information for the input word then overlays it against every XML entry to find similarities. Overlaying domain, semantic, and syntactic properties, encapsulated in the <CONT>, <OP> and <DOM> tags, gives fairly reliable results.

The output is an HTML file dividing the entry word synonyms into 3 categories from least to most relevant considering the occurrence rate of given tags.
