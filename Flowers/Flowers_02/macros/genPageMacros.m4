m4_define(`C', `m4_dnl') m4_dnl - define C as an alias for an m4 comment
C ==========================================================================
C File: genPageMacros.m4 - macro definition called by genPages
C
C Version 1.0 - Dan Mazzola - 4/18/04
C Version 2.0 - Dan Mazzola - 3/24/14
C Version 3.0 - Dan Mazzola - 4/18/15 (converted to css 
C                                      dropped HTML tables for divs)
C --------------------------------------------------------------------------
C
C --------------------------------------------------------------------------
C CHANGE QUOTE
C ==========================================================================
C For this macro file, we will use 
C "[[" (two opening square brackets) to open
C "]]" (two closeing square brackets) to close all macros
C Why? Two reasons, one, it is really hard for genPages to output ` and '
C and it will be easy to see
C --------------------------------------------------------------------------
m4_changequote([[, ]])

C --------------------------------------------------------------------------
C HTML_START and HTML_END
C ==========================================================================
C The opening and closing macros to each page
C NOTE: AUTHOR and TITLE is passed in as arguments
C NOTE: CSS link is below... change if you need to
C --------------------------------------------------------------------------
m4_define([[HTML_START]],
[[
	<!DOCTYPE html>
	<html>
	    <head>
		<meta content='noindex, nofollow' name='robots'>
		<meta charset='utf-8'>
		<meta name="generator" content="m4">
		<meta name="Author" content="$1">

		<link href="styles/project.css" 
			rel="stylesheet" type="text/css" />

		<title>$2</title>
	    </head>
]])

m4_define([[HTML_END]],	[[</html>]])

C --------------------------------------------------------------------------
C BODY_START and BODY_END
C ==========================================================================
C trivially opens the closes the body 
C --------------------------------------------------------------------------
m4_define([[BODY_START]], [[<body class="main">]])
m4_define([[BODY_END]],	  [[</body>]])

C --------------------------------------------------------------------------
C GALLERY_START and GALLERY_END
C ==========================================================================
C Trivial open and close for our outermost div
C --------------------------------------------------------------------------
m4_define([[GALLERY_START]], [[<div class="bounding_box">]])
m4_define([[GALLERY_END]],   [[</div>]])

C --------------------------------------------------------------------------
C IMAGE_LINK url, image_file_path
C ==========================================================================
C IMAGE_LINK([[http://www.asu.edu]], [[./images/orig/123.jpg]])]
C --------------------------------------------------------------------------
m4_define([[IMAGE_LINK]], [[<a href="$2"><img src="$1"></a>]])

C --------------------------------------------------------------------------
C SITE_NAVIGATION_CELL([[contents]])
C ==========================================================================
m4_define([[SITE_NAVIGATION_CELL]], 
	[[<div id="site_navigation_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C TITLE_CELL([[title-to-use]])
C ==========================================================================
m4_define([[TITLE_CELL]], [[<div id="title_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C GALLERY_NAVIGATION_CELL([[contents]])
C ==========================================================================
m4_define([[GALLERY_NAVIGATION_CELL]],
	[[<div class="gallery_navigation_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C IMAGE_NAVIGATION_CELL([[IMAGE_LINK()]], [["4 of 32"]], [[IMAGE_LINK()]])
C ==========================================================================
m4_define([[IMAGE_NAVIGATION_CELL]],
	[[<div class="image_nav_box">
		<div class="image_nav_center">
			<div class="image_nav_left_arrow">
				$1
			</div>
			<div class="image_nav_counts">
				$2
			</div>
			<div class="image_nav_right_arrow">
				$3
			</div>
		</div>
	</div>]])

C --------------------------------------------------------------------------
C THUMB_CELL(IMAGE_LINK([[url-when-clicked]],[[image_file]]))
C ==========================================================================
m4_define([[THUMB_CELL]], [[<div class="thumbnail_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C THUMB_BOX(THUMB_CELL(1) THUMB_CELL(2)...)
C ==========================================================================
m4_define([[THUMB_BOX]], [[<div id="thumbnail_box">$1</div>]])

C --------------------------------------------------------------------------
C SMALL_CELL(IMAGE_LINK([[url]],[[main-image]])
C ==========================================================================
m4_define([[SMALL_CELL]], [[<div id="small_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C CAPTION_CELL([[page-caption]])
C ==========================================================================
m4_define([[CAPTION_CELL]], [[<div id="caption_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C FOOTNOTE_CELL([[text-for-every-page]])
C ==========================================================================
 m4_define([[FOOTNOTE_CELL]], [[<div id="footnote_cell"> $1 </div>]])

C --------------------------------------------------------------------------
C PORTFOLIO_PAGE
C ==========================================================================
C Fills in all parts of the page, $1 - $29, see the skeleton
C --------------------------------------------------------------------------
m4_define([[PORTFOLIO_PAGE]],
	[[
		SITE_NAVIGATION_CELL([[$23]])
		TITLE_CELL([[$24]])
		GALLERY_NAVIGATION_CELL([[$25]])
		IMAGE_NAVIGATION_CELL(
			IMAGE_LINK([[$26]], [[$27]]), 
			$28, 
			IMAGE_LINK([[$29]], [[$30]]),
		)
		THUMB_BOX(
			THUMB_CELL(IMAGE_LINK([[$3]],  [[$4]] ))
		    	THUMB_CELL(IMAGE_LINK([[$5]],  [[$6]] ))
			THUMB_CELL(IMAGE_LINK([[$7]],  [[$8]] ))
		    	THUMB_CELL(IMAGE_LINK([[$9]],  [[$10]]))
			THUMB_CELL(IMAGE_LINK([[$11]], [[$12]]))
		    	THUMB_CELL(IMAGE_LINK([[$13]], [[$14]]))
			THUMB_CELL(IMAGE_LINK([[$15]], [[$16]]))
		    	THUMB_CELL(IMAGE_LINK([[$17]], [[$18]]))
		    	THUMB_CELL(IMAGE_LINK([[$19]], [[$20]]))
		    	THUMB_CELL(IMAGE_LINK([[$21]], [[$22]]))
		)
		SMALL_CELL(IMAGE_LINK([[$1]],  [[$2]]))
		GALLERY_NAVIGATION_CELL([[$31]])
		CAPTION_CELL([[$32]])
		FOOTNOTE_CELL([[$33]])
	]])
C --------------------------------------------------------------------------
