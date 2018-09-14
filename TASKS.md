
TODO/TASKS
==========

Need to clean up each programs helptext and remove old un-needed options.

I realized that one some of my programs use the generic, catch-all
pytis_tools.ini, and others use only their own .ini, I''d like there be an easy
option for it to be both, with inheritance, where a program could look for its
own ini file, as the primary, but if not found, load default values from the
pytis_tools.ini.


TODO - Meging
-------------

I''ve recently come to the realization, after spending ours merging pytis.py 
and pytis3.py for the 3rd tiem, that it would make more sence to merge them
back into a single file, do away with pylib and pylib3, and handle language
version difference within the file.  99.9% of pytis is the same as pytis3, the
subtle differences could be coded around right there in the file itself.  **
Thusfar, the pytis libraries have been merged, however "pylib" and "pylib3"
still need to be merged.

TODO - ITEM 2
-------------

DESC GOES HERE


MILESTONES
==========

Create setup.py installer for our tools.

Create a tool that uses our deep help (--help) and generates man pages, and
installs them ( w.i.p., 60% done)) 

Create Man Pages for each of our tools, alter setup.py to actually install
these as well.

Need to learn git branching, so I can have one branch for W.I.P. and one for
completed, functional scripts.

I need to break out the Database interaction into a module with a parent layer.
This way a user can pick and choose which Database that he/she wishes to use. 
I would like to have first release support PostgreSQL, MySQL and Sqlite3.
