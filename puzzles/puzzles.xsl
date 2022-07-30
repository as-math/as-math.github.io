<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings"
extension-element-prefixes="str">

<!--#############################-->
<!--#####   MAIN DOCUMENT   #####-->
<xsl:template match="/document">
	<html>
		<xsl:call-template name="html_head"/>
		<xsl:call-template name="html_body"/>
	</html>
</xsl:template>

<!-- head -->
<xsl:template name="html_head">
	<head>
		<meta charset="utf-8"/>
		<title>AS - Math Puzzles</title>
		<link rel="shortcut icon" href="/config/icons/ico-6gon.png" type="image/png" />
		<link rel="stylesheet" href="style.css"/>
		<script src="/config/nerdamer.core.js"></script>
		<script src="check_answer.js"></script>
		<script src="change_lang.js"></script>
	</head>
</xsl:template>

<!-- body -->
<xsl:template name="html_body">
	<body>
		<xsl:call-template name="puzzles_page_title"/>
		<xsl:call-template name="title_links"/>
		<xsl:apply-templates />
	</body>
</xsl:template>

<!-- title -->
<xsl:template name="puzzles_page_title">
	<div class="puzzles_page_title">
		<img class="puzzles_page_title" src="/config/icons/title-6gon.png"/>
		<h1 class="puzzles_page_title">Math Puzzles by AS</h1>
	</div>
</xsl:template>

<!-- title links -->
<xsl:template name="title_links">
	<a class="puzzles_page_title" href="/">Home page</a>
	<a class="puzzles_page_title" href="https://t.me/SerovaA_math"><img src="/config/icons/telegram_icon.svg" style="height: 1em; margin-right: 0.2em; margin-bottom: -0.1em;"/>Telegram channel</a>

</xsl:template>

<!--#####################-->
<!--#####   GROUP   #####-->
<xsl:template match="group">
	<div class="group">
		<hr class="group"><xsl:value-of select="date"/></hr>
		<xsl:apply-templates select="puzzle"/>
	</div>
</xsl:template>

<!--######################-->
<!--#####   PUZZLE   #####-->
<xsl:template match="puzzle">
	<xsl:variable name="puzzle_id">
		<xsl:value-of select="./@id" />
	</xsl:variable>
	<xsl:variable name="lang_list">
		<xsl:value-of select="./@lang" />
	</xsl:variable>
	<div class="puzzle">
		<xsl:attribute name="id"><xsl:text>puzzle_</xsl:text><xsl:value-of select="$puzzle_id" /></xsl:attribute>
		<xsl:apply-templates mode="puzzle_content">
			<xsl:with-param name="puzzle_id" select="$puzzle_id"/>
			<xsl:with-param name="lang_list" select="$lang_list"/>
		</xsl:apply-templates>
		<xsl:if test="count(./question)+count(./questions) = 0">
			<xsl:call-template name="question_status">
				<xsl:with-param name="puzzle_id" select="$puzzle_id"/>
				<xsl:with-param name="question_id" select="$puzzle_id"/>
				<xsl:with-param name="lang_list" select="$lang_list"/>
			</xsl:call-template>
		</xsl:if>
	</div>
</xsl:template>

<!-- Puzzle content -->

<!--text -->
<xsl:template match="text" mode="puzzle_content">
	<p class="puzzle_content">
		<xsl:apply-templates select="./@*" mode="copy"/>
		<xsl:copy-of select="node()"/>
	</p>
</xsl:template>

<!-- SVG image -->
<xsl:template match="image[@type='svg']" mode="puzzle_content">
	<xsl:variable name="src" select="concat('./images/', ./node())"/>
	<xsl:apply-templates select="document($src)" mode="svg_image__width_100"/>
</xsl:template>

<xsl:template match="node()" mode="svg_image__width_100">
	<xsl:copy>
		<xsl:apply-templates select="@*[not(name(.) = 'height')]" mode="copy"/>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:apply-templates select="node()" mode="copy"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="@*|node()" mode="copy">
		<xsl:copy>
				<xsl:apply-templates select="@*|node()" mode="copy"/>
		</xsl:copy>
</xsl:template>

<!-- image -->
<xsl:template match="image" mode="puzzle_content">
	<img class="puzzle_content" src="./images/{.}"/>
</xsl:template>

<!--#########################-->
<!--#####   QUESTIONS   #####-->

<!-- status -->
<xsl:template name="question_status">
	<xsl:param name="puzzle_id"/>
	<xsl:param name="question_id"/>
	<xsl:param name="lang_list"/>
	<div class="question_status">
		<div class="question_id">
			#<xsl:value-of select="$question_id"/>
		</div>
		<div class="question_result_block">
			<div class="question_result" id="result_{$question_id}"></div>
			<div class="question_result_note" id="result_note_{$question_id}"></div>
		</div>
		<xsl:if test="$question_id=$puzzle_id or $question_id=concat($puzzle_id, '_1')">
			<xsl:for-each select="str:tokenize($lang_list, ';')">
				<button class="puzzle_lang_button" lang="{.}" onclick="change_puzzle_lang('{.}', '{$puzzle_id}')"><xsl:value-of select="."/></button>
			</xsl:for-each>
		</xsl:if>
	</div>
</xsl:template>

<!-- question/questions -->
<xsl:template match="question | questions" mode="puzzle_content">
	<xsl:param name="puzzle_id"/>
	<xsl:param name="lang_list"/>
	<xsl:variable name="question_id">
		<xsl:value-of select="$puzzle_id" />
		<xsl:if test="count(../question)+count(../questions) > 1">
			<xsl:text>_</xsl:text>
			<xsl:value-of select="count(preceding-sibling::question)+count(preceding-sibling::questions)+1" />
		</xsl:if>
	</xsl:variable>
	<xsl:call-template name="question_status">
		<xsl:with-param name="puzzle_id" select="$puzzle_id"/>
		<xsl:with-param name="question_id" select="$question_id"/>
		<xsl:with-param name="lang_list" select="$lang_list"/>
	</xsl:call-template>
	<xsl:apply-templates select="." mode="questions">
		<xsl:with-param name="question_id" select="$question_id"/>
	</xsl:apply-templates>
</xsl:template>

<!-- Question -->
<xsl:template match="question" mode="questions">
	<xsl:param name="question_id"/>
	<div class="puzzle_content">
		<xsl:call-template name="question_input">
			<xsl:with-param name="question_id" select="$question_id"/>
		</xsl:call-template>
	</div>
	<div class="puzzle_content">
		<xsl:call-template name="question_button">
			<xsl:with-param name="question_id" select="$question_id"/>
		</xsl:call-template>
	</div>
</xsl:template>

<!-- input -->
<xsl:template name="question_input">
	<xsl:param name="question_id"/>
	<input class="question" type="text" id="input_{$question_id}" placeholder="{text}" />
</xsl:template>

<!-- button -->
<xsl:template name="question_button">
	<xsl:param name="question_id"/>
	<xsl:variable name="answer">
		<xsl:text>[</xsl:text>
		<xsl:for-each select="./answer">
			<xsl:text>'</xsl:text>
			<xsl:value-of select="." />
			<xsl:text>', </xsl:text>
		</xsl:for-each>
		<xsl:text>]</xsl:text>
	</xsl:variable>
	<button class="question" onclick="check('{$question_id}', {$answer})">
		Check
	</button>
</xsl:template>

<!-- Questions -->
<xsl:template match="questions" mode="questions">
	<xsl:param name="question_id"/>
	<table>
		<tbody>
			<xsl:for-each select="./question">
				<xsl:variable name="question_id_edited">
					<xsl:value-of select="$question_id" />
					<xsl:text>_</xsl:text>
					<xsl:value-of select="count(preceding-sibling::question)+1" />
				</xsl:variable>
				<tr>
					<td>
						<xsl:call-template name="questions_result">
							<xsl:with-param name="question_id" select="$question_id_edited"/>
						</xsl:call-template>
					</td>
					<td>
						<xsl:call-template name="questions_input">
							<xsl:with-param name="question_id" select="$question_id_edited"/>
						</xsl:call-template>
					</td>
					<td>
						<xsl:call-template name="questions_button">
							<xsl:with-param name="question_id" select="$question_id_edited"/>
						</xsl:call-template>
					</td>
					<td>
						<p class="questions"><xsl:value-of select="text"/></p>
					</td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<!-- result -->
<xsl:template name="questions_result">
	<xsl:param name="question_id"/>
	<div class="questions_result_block">
		<div class="questions_result" id="result_{$question_id}"></div>
		<div class="questions_result_note" id="result_note_{$question_id}"></div>
	</div>
</xsl:template>

<!-- input -->
<xsl:template name="questions_input">
	<xsl:param name="question_id"/>
	<input class="questions" type="text" id="input_{$question_id}"/>
</xsl:template>

<!-- button -->
<xsl:template name="questions_button">
	<xsl:param name="question_id"/>
	<xsl:variable name="answer">
		<xsl:text>[</xsl:text>
		<xsl:for-each select="./answer">
			<xsl:text>'</xsl:text>
			<xsl:value-of select="." />
			<xsl:text>', </xsl:text>
		</xsl:for-each>
		<xsl:text>]</xsl:text>
	</xsl:variable>
	<button class="questions" onclick="check('{$question_id}', {$answer})">
		Check
	</button>
</xsl:template>

</xsl:stylesheet>