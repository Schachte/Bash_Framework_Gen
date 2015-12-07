m4_dnl File: basicHTMLMacros.m4 - HTLM m4 macro definition file
m4_dnl
m4_dnl Version 1.0 - Dan Mazzola - 4/18/04
m4_dnl Version 2.0 - Dan Mazzola - 3/24/14
m4_dnl Version 3.0 - Dan Mazzola - 4/18/15 (css for most things now)
m4_dnl
m4_dnl inspired by the book:
m4_dnl
m4_dnl	"The Art of UNIX Programming", Eric S. Raymond
m4_dnl	2004, Pearson Education, Addison Wesley, ISBN  0-13-142901-9"
m4_dnl
m4_dnl Many other resources supported this inspiration:
m4_dnl
m4_dnl	http://www.linuxgazette.com/issue22/using_m4.html
m4_dnl	http://jones.tc/htm4l/htm4l/
m4_dnl
m4_dnl "Discard to newline character" - how to do a comment in m4
m4_dnl many think this is ugly, so we define a new macro for it:

m4_define(`C', `m4_dnl') m4_dnl - define C as an alias for an m4 comment

C --------------------------------------------------------------------------
C Ahh, this is much better, I will use comments like this for the
C rest of this document.
C	
C --------------------------------------------------------------------------
C --------------------------------------------------------------------------
C PHYSICAL STYLES 
C ==========================================================================
C These represent simple physical styles of normal HTML, all take
C arguments except for BREAK which inserts the <br> tag.
C
C Usage: physical_style(text|macro)
C Where: text is some HTML or text to change style on - can be nested
C
C Examples:
C
C 1) H1(`This will be big') expands to:
C
C	<h1>This will be big</h1>
C
C 2) CENTER(H1(`This will be big and centered')) expands to:
C
C	<center><h1>This will be big and centered</h1></center>
C --------------------------------------------------------------------------

m4_define(`H1',		`<h1>$1</h1>'		)
m4_define(`H2',		`<h2>$1</h2>'		)
m4_define(`H3',		`<h3>$1</h3>'		)
m4_define(`H4',		`<h4>$1</h4>'		)
m4_define(`H5',		`<h5>$1</h5>'		)
m4_define(`H6',		`<h6>$1</h6>'		)

m4_define(`CENTER',	`<center>$1</center>'	)
m4_define(`BOLD',	`<b>$1</b>'		)
m4_define(`ITALIC',	`<i>$1</i>'		)
m4_define(`UNDERLINE',	`<u>$1</u>'		)
m4_define(`CODE',	`<code>$1</code>'	)
m4_define(`PRE',	`<pre>$1</pre>'		)
m4_define(`CITE',	`<cite>$1</cite>'	)
m4_define(`COMMENT',	`<!-- $1 -->'		)
m4_define(`BREAK',	`<br>'			)
m4_define(`TITLE',	`<title>$1</title>'	)
m4_define(`HR',		`<hr>'			)
m4_define(`NBSP',	`&nbsp;'		)

m4_define(`PARA',	`<p>$*</p>'		)
m4_define(`PARA_BEGIN',	`<p>$*'			)
m4_define(`PARA_END',	`</p>'			)

m4_define(`DIV',	`<div>$1</div>'		)
m4_define(`DIV_BEGIN',	`<div $*>'		)
m4_define(`DIV_END',	`</div>'		)

C --------------------------------------------------------------------------
C LINK
C ==========================================================================
C Creates an anchor tag <a>
C
C Usage: LINK(`anchor_text', `URL')
C Where: anchor_text is the text that will have the hyperlink underline
C        URL is a universal resource locator
C
C Example:
C
C   LINK(`A really cool page', `http://www.asu.edu') expands to
C
C   <a href="http://www.asu.edu">A really cool page</a>
C --------------------------------------------------------------------------

m4_define(`LINK', 		`<a href="$2">$1</a>')
m4_define(`LINK-TEXT-URL',	`<a href="$2">$1</a>')
m4_define(`LINK-URL-TEXT',	`<a href="$1">$2</a>')

m4_define(`IMAGE',		`<img src="$2" alt="$1">')
m4_define(`IMAGE_LINK', 	`LINK(IMAGE($1, $2), $3)')

C --------------------------------------------------------------------------
C NEW
C ==========================================================================
C Places a simple "new" image
C
C Usage: NEW
C --------------------------------------------------------------------------

m4_define(`NEW', `<img src="NEW_IMAGE" align="center">')


C --------------------------------------------------------------------------
C LISTS
C ==========================================================================
C These are two closely related macros, they both create lists of html
C elements. There are two kinds of lists, ordered and unordered. Ordered
C lists put numbers on each list item, unordered just put standard bullets
C for each list item. LIST_ITEMS is a list of items to be managed under
C the UNORDERED_LIST or ORDERED_LIST macro.
C
C Usage: UNORDERED_LIST(LIST_ITEMS(`item1, item2, ... itemN'))
C        ORDERED_LIST(LIST_ITEMS(`item1, item2, ... itemN'))
C Where: item1... itemN are HTML elements
C
C Example:
C
C UNORDERED_LIST(LIST_ITEMS(`1st item', `2nd item', `3rd item'))
C
C expands: <ul><li>1st item</li><li>2nd item</li><li>3rd item</li></ul>
C
C --------------------------------------------------------------------------

m4_define(`UNORDERED_LIST', `<ul>$1</ul>')
m4_define(`ORDERED_LIST',   `<ol>$1</ol>')
m4_define(`LIST_ITEMS', `<li>$1</li> 
  m4_ifelse($#,1,,`LIST_ITEMS(m4_shift($@))')')
  
C --------------------------------------------------------------------------
C HOW LIST_ITEMS WORKS: Recursion
C ==========================================================================
C (i.e. it calls itself). The macro can be read as...
C "expand LIST_ITEMS to "<li>$1</li>" plus the concatenation of another
C m4 internal macro, m4_ifelse. m4_ifelse comes in a number of forms
C but the one used here is: If the number of arguments ($#) is equal
C to 1 (2nd element), return null (3rd element - which is empty), otherwise
C call LIST_ITEMS with the arguments quoted ($@) and shifted (m4_shift)"
C
C Here is an tracing of how this works, suppose we call 
C LIST_ITEMS(`1st', `2nd', `3rd'):
C
C new call #1 LIST_ITEMS(`1st', `2nd', `3rd')
C   return "<li>1st</li>" followed by the result of:
C     if the number of arguments is equal to 1, return null
C     else call LIST_ITEMS with the arguments shifted
C     (since the number of arguments ($#) is 3, call LIST_ITEMS(`2nd', `3rd'),
C     this invocation of LIST_ITEMS waits for that call to complete, it has
C     not returned any value yet...
C     
C new call #2 LIST_ITEMS(`2nd', `3rd')
C   return: "<li>2nd</li>" followed by the result of
C     if the number of arguments is equal to 1, return null
C     else call LIST_ITEMS with the arguments shifted
C     (since the number of arguments ($#) is 2, call LIST_ITEMS(`3rd')
C     this invocation of LIST_ITEMS waits for that call to complete, it has
C     not returned any value yet...
C     
C new call #3 LIST_ITEMS(`3rd')
C   return: "<li>3rd</li>" followed by the result of
C      if the number of arguments is equal to one,  return "<li>3rd</li>"
C      
C back to call #2, return "<li>2nd</li>" plus the concatenation of call #3
C    return "<li>2nd</li><li>3rd</li>"
C    
C back to call #1, return "<li>1st</li>" plus the concatenation of call #2
C    return ""<li>1st</li><li>2nd</li><li>3rd</li>"
C --------------------------------------------------------------------------

m4_define(`UNORDERED_LIST', `<ul>$1</ul>')
m4_define(`ORDERED_LIST',   `<ol>$1</ol>')
m4_define(`LIST_ITEMS', `<li>$1</li> 
  m4_ifelse($#,1,,`LIST_ITEMS(m4_shift($@))')')

C --------------------------------------------------------------------------
C TABLES
C ==========================================================================
C Tables are created using a sequence of macros:
C TABLE_BEGIN and TABLE_END are the first and last macros to call 
C respectively. If you have a table header, use TABLE_HDR, and then
C follow up with one TABLE_ROW for each row in your table. Do not
C use _TABLE_HDR_ITEM or _TABLE_ROW_ITEM - they are internal to
C this macro definition. These macros use recursion, to understand
C how it works see the section called "HOW LIST_ITEMS WORKS: Recursion"
C
C Usage: TABLE_BEGIN
C        TABLE_HDR(`hdr_1',      ` hdr_2',     ... `hdr_N'	)
C        TABLE_ROW(`row1_item1', `row1_item2', ... `row1_itemN'	)
C        TABLE_ROW(`row2_item1', `row2_item2', ... `row2_itemN'	)
C        TABLE_ROW(............................................	)
C        TABLE_ROW(`rowN_item1', `rowN_item2', ... `rowN_itemN'	)
C        TABLE_END
C --------------------------------------------------------------------------

m4_define(`TABLE_BEGIN', `<table>')

m4_define(`_TABLE_HDR_ITEM', `<th>$1</th>
  m4_ifelse($#,1,,`_TABLE_HDR_ITEM(m4_shift($@))')')

m4_define(`_TABLE_ROW_ITEM', `<td>$1</td>
  m4_ifelse($#,1,,`_TABLE_ROW_ITEM(m4_shift($@))')')

m4_define(`TABLE_HDR',`<tr>_TABLE_HDR_ITEM($@)</tr>')
m4_define(`TABLE_ROW',`<tr>_TABLE_ROW_ITEM($@)</tr>')

m4_define(`TABLE_END', `</table>')

C --------------------------------------------------------------------------
C Call the Operating system
C ==========================================================================
C m4_syscmd(`unix commandline')
C
C Use as templates to extend
C --------------------------------------------------------------------------
m4_define(`COMMAND', `m4_syscmd($@)')

C --------------------------------------------------------------------------
C Strcuture of HTML Document
C ==========================================================================
C Closes the HTML steam
C
C Use as templates to extend
C --------------------------------------------------------------------------
m4_define(`DOC_TYPE',	`<!DOCTYPE html>')
m4_define(`HTML_BEGIN',	`<html lang="en">')
m4_define(`HEAD_BEGIN',	`<head>')
m4_define(`META_SECTION', `
	<meta name="robots" content="noindex, nofollow" />
    	<meta charset="utf-8" />')
m4_define(`CSS', 	`<link type="text/css" rel="stylesheet" href="$1" />')
m4_define(`HEAD_END', 	`</head>')

m4_define(`BODY_BEGIN',	`<body $*>')

m4_define(`BODY_END',	`</body>')
m4_define(`HTML_END',	`</html>')
