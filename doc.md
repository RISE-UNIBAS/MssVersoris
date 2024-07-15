## Github

https://github.com/RISE-UNIBAS/MssVersoris

Update cloned repository 
- go to the folder
- right click > open in terminal
- in terminal, type `git pull` and enter


## XPath
Run XPath queries in oXygen or using online services such as http://xpather.com/.

About XPath:
- https://dixit.uni-koeln.de/wp-content/uploads/2015/04/Camp2-4-James_Cummings_-_An_introduction_to_searching_in_oXygen_using_XPath__talk.pdf
- https://www.w3schools.com/xml/xpath_intro.asp
- https://devhints.io/xpath

About XPath in oXygen:
- https://www.oxygenxml.com/xml_editor/xpath.html
- https://www.youtube.com/watch?v=E3fscFJAnqk
- https://dixit.uni-koeln.de/wp-content/uploads/2015/04/Camp2-4-James_Cummings_-_Using_XPath_in_oXygen__exercise.pdf


#### Examples of XPATH queries

Mss copied before 1458
- `//origDate[@from < 1458]//ancestor::msDesc`

Mss copied after 1458
- `//origDate[@to > 1458]//ancestor::msDesc`

Mss copied by Iohannes Scolaris
- `//handNote[@scribeRef="#IohannesScolaris"]//ancestor::msDesc`

Mss belonging to a person or organisation
- `//provenance//*[@ref="#BaselDominicanConvent"]//ancestor::msDesc`

Mss containing questions on a specific work
- `//msItem/title[@ref="#work_DC"]/../msItem[@class="question"]`

Mss copied in Leipzig or Paris
- `//origPlace[@ref='#place_cologne']//ancestor::msDesc`

