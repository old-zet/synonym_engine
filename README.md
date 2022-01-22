# synonym_engine
Here's a French synonym search engine based on Perl regex and XML (rali.iro.umontreal.ca/DEM//DEM-1_1.xml.zip). The XML corpus describes extensively around 70k French words, including their domain use, semantic features, and syntactic particularities.

The XML tree traversal algorithm thus retrieves the relevant information for the unit specified as input in order then overlays it against every entry to find similarities. Overlaying domain, semantic, syntactic properties, encapsulated in the <CONT>, <OP> and <DOM> tags, gives fairly interesting results.
