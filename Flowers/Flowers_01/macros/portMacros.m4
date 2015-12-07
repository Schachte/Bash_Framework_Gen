C portMacros.m4:
C
C Portfolio Macros - for use with the genPort and awkPort scripts
C
C These are macros specifically designed to support the generation of
C portfolios as navigational aids to get to galleries generated by
C genPages.
C
C Dan Mazzola
C version 2.0 4/28/05 - removed html tables and uses CSS and divs
C
C Make sure to include these macros in genPort. 
C For example, to work correctly, use something like this:
C
C 	echo "m4_include(\`${macrosDir}/basicHTMLMacros.m4')"
C   echo "m4_include(\`${macrosDir}/port2Macros.m4')"

C ---------------------------------------------------------------------

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
C NOTE: AUTHOR, TITLE, and path to the css file is passed in as arguments
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

		<link href="$3" 
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
m4_define([[BODY_START]], 
[[
	<body>
  		<div id="bounding_box">
]])
m4_define([[BODY_END]],	  
[[
		</div> <!-- close bounding_box -->
	</body>

]])

C -------------------------------------------------------------------------
C PORTFOLIO_HEADING: This displays a heading for the portfolio
C
C Usage: PORTFOLIO_HEADING([[page title]], [[long text description]])
C -------------------------------------------------------------------------

m4_define([[PORTFOLIO_HEADING]],
[[
	<div id="heading_box">
		<div id="main_heading">
			$1
      		</div>
		<div id="sub_heading">
	        	$2
	      	</div>
    	</div> 
]])

C -------------------------------------------------------------------------
C PORTFOLIO_NAV: This is a simple table of LINKS for navigating up and
C down the portfolio
C
C Usage: PORTFOLIO_NAV([[ navigation LINKS ]])
C -------------------------------------------------------------------------
m4_define([[PORTFOLIO_NAV]],
[[
 	<div id="portfolio_navigation">
		$1
	</div>
]])

C -------------------------------------------------------------------------
C PORTFOLIO_RECORD: This is the master record for each sub portfolio or
C gallery
C
C Usage: PORTFOLIO_RECORD([[portfolio title]], [[./child_dir]], 
C [[./path/to/thumbnail/image]], [[porfolio description text]],
C [[ date of last update ]]
C -------------------------------------------------------------------------
m4_define([[PORTFOLIO_RECORD]],
[[
	<div class="portfolio_record_box">
      		<div class="portfolio_record_thumbnail_box">
      			IMAGE_LINK([[$3]], [[$2/index.html]])
		</div>
		<div class="portfolio_record_text_box">
			<div class="portfolio_record_main_heading">
				$1
			</div>
			<div class="portfolio_record_sub_heading">
		 		$4
			</div>
			<div class="portfolio_record_update_stamp">
				$5
			</div>
		</div>
	</div>
]])

C -------------------------------------------------------------------------
C PORTFOLIO_FOOTNOTE:
C
C Usage: PORTFOLIO_FOOTNOTE([[footnote text]])
C -------------------------------------------------------------------------
m4_define([[PORTFOLIO_FOOTNOTE]],
[[
	<div id="portfolio_record_footer_box">
		<div id="portfolio_record_footer_text">
			$1
		</div>
	</div>
]])
	

C --------------------------------------------------------------------------
C IMAGE_LINK url, image_file_path
C ==========================================================================
C IMAGE_LINK([[http://www.asu.edu]], [[./images/orig/123.jpg]])]
C --------------------------------------------------------------------------
m4_define([[IMAGE_LINK]], [[<a href="$2"><img src="$1"></a>]])

C -------------------------------------------------------------------------
C BASENAME: returns the basename of a path e.g. if path is a/b/c BASENAME
C calls basename(1) and returns c
C
C Usage: BASENAME(path)
C -------------------------------------------------------------------------
m4_define([[BASENAME]],
[[
	m4_syscmd([[/usr/bin/basename $1]])
]])