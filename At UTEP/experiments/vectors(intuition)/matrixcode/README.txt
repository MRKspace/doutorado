To:             recipient
From:           William Gould, StataCorp
Date:           Tue Mar  8 13:54:24 CST 2011
Subject:        Do-files to create graphs for "Understanding Matrices" 

The files described here create the graphs that appeared in
"Undestanding Matrices Intuitively" parts 1 and 2 and blog.stata.com,

http://blog.stata.com/2011/03/03/understanding-matrices-intuitively-part-1/

http://blog.stata.com/2011/03/09/understanding-matrices-intuitively-part-2/

There are three files.  They are

        graphs.do   create .gph files for parts 1 and parts 2

        grmat.do    used by graph.do
        grmate.do   used by graph.do


graphs.do creates fig1.gph through fig14.gph along with fig5_1.gph and
fig8_1.gph.  There is no meaning to the figure number except that
graphs appear in numerical order in the article, so fig5_1.gph
appeared between fig5.gph and fig6.gph in the blog.

The two do-files provide the code for graphing matrices and
eigenvectors and values.  grmate.do is grmat.do, with eigen additions.
When I wrote part 1, I didn't need to graph eigenvalues and
eigenvectors.  When I wrote part 2, I modified grmat.do to add the 
eigen features.  In theory, I could have used grmate.do to replace
grmat.do, but I haven't bothered.

Either one of the do-files, grmat.do or grmate.do, could be made into 
ado-files.  With a little work, they could be turned into nice ado-files.

I apologize for the inconsistent notation used in grmate.do and grmat.do.
What's called A in the blog entry is called X in the do-file, or is it 
the other way around?, and there are other inconsistencies, too.
If I were going to produce ado-files from them, the first thing I would 
do is clean up the notation.

<end>
