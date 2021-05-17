# LatticePresentations
Code for the paper "Presentations for cusped arithmetic hyperbolic lattices"

The files d=1.ipynb, d=3.ipynb, and d=7.ipynb are Sage Jupyter notebooks that can be opened and run as is.   The output is a list of relations that are not quite ready for Magma.  We did some post-processing on this output to make d=1.m, d=3.m, and d=7.m, which can be loaded into magma.

The subfolder 'quaternions' contains the code we used to generate the presentation for the hurwitz integral quaternion lattice.  There were several places where we broke up the computation into pieces to parallelize it.  This was done by parsing output files using sed, and grep, and other bash stuff.  That was done in the terminal, and the code for it is not included.  However, the places where it was done is noted in the comments. 

The final output is included in two forms.  There is one giant file containing the entire presentation.  We *do not recommend* loading this file into Magma, it is way too big.  There are 10 files named mondo1.m, ..., mondo10.m, each containing about 1/10 of the relatations.
