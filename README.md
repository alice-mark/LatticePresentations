# LatticePresentations
Code for the paper "Presentations for cusped arithmetic hyperbolic lattices"

The files d=1.ipynb, d=3.ipynb, and d=7.ipynb are Sage Jupyter notebooks that can be opened and run as is.   The output is a list of relations that are not quite ready for Magma.  We did some post-processing on this output to make d=1.m, d=3.m, and d=7.m, which can be loaded into magma.  The simplified versions of these presentations that appear in the paper exist in magma format in the files d=1FinalPres.m, d=3Simplified145.m, and d=7FinalPres.m.

The subfolder 'quaternions' contains the code we used to generate the presentation for the hurwitz integral quaternion lattice.  There were several places where we broke up the computation into pieces to parallelize it.  This was done by parsing output files using sed, and grep, and other bash stuff.  That was done in the terminal, and the code for it is not included.  However, the places where it was done is noted in the comments. Intermediate output is not included, but is available on request.

The final output exists in two forms.  There is one giant file containing the entire presentation.  That file is not included here because github limits file sizes to 25MB.  It's way too big to be useful so we broke it up into 10 pieces, each containing ~1/10 of the relations, and each including the cusp relations. These pieces are named mondo1.m, ..., mondo10.m.  

The files mondo1modified.m, ..., mondo10modified.m have some some additional relations in them that are true in the abelianization but not in the original group, that make computing the abelianization faster.

QuaternionsTruncated1000.m is exactly what it sounds like: the presentations has been truncated at 1000 relations.  It is used in the proof of Theorem 3.
