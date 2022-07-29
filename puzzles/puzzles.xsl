<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings"
extension-element-prefixes="str">

<!--###################-->
<!--#####   CSS   #####-->
<xsl:template name="html_head_style">
	<style>
		@import url("/config/fonts/ArbutusSlab/arbutusslab.css");
		@import url("/config/fonts/Gabriela/gabriela.css");
		:root {
			--color_gray_1: #d3d3d3;
			--color_gray_2: #a3a3a3;
			--color_blue_1: #5a6fd4;
			--color_green_1: #cfecc5;
			--color_green_2: #339900;
			--color_red_1: #ffaaa7;
			--color_red_2: #ff0500;
			--color_white: #ffffff;
		}
		@media only screen and (max-device-width: 640px) {
			:root {
				font-size: 30px;
			}
		}
		body {
			font-family: 'Arbutus Slab', 'Gabriela';
			width: 100%;
			max-width: 1200px;
			text-align: center;
			margin: auto;
		}
		table {
			border-collapse: collapse;
		}

		/* *********************** */
		/* ** PUZZLE PAGE TITLE ** */
		/* *********************** */
		div.puzzles_page_title {
			display: table;
			margin: auto;
			max-width: 90vw;
		}
		img.puzzles_page_title {
			display: table-cell;
			vertical-align: middle;
			height: 7rem;
		}
		h1 {
			display: table-cell;
			vertical-align: middle;
			font-size: 2.5rem;
			white-space: nowrap;
			color: var(--color_blue_1);
		}
		a.puzzles_page_title {
			display: block;
			color: var(--color_blue_1);
		}

		/* *********** */
		/* ** GROUP ** */
		/* *********** */
		div.group {
			display: block;
			margin: 2rem auto;
		}
		hr.group {
			width: 95%;
			border: none;
			border-top: 0.2rem solid var(--color_gray_1);
			margin: 0.1rem auto;
			text-align: left;
			font-weight: bold;
			font-size: 1rem;
			color: var(--color_gray_2);
		}

		/* ************ */
		/* ** PUZZLE ** */
		/* ************ */
		div.puzzle {
			display: inline-block;
			width: min(30rem, 90vw);
		}
		.puzzle_content {
			display: block;
			max-width: 100%;
		}
		p.puzzle_content {
			text-align: justify;
		}
		img.puzzle_content {
			max-height: 20rem;
			margin: auto;
		}

		/* ************** */
		/* ** QUESTION ** */
		/* ************** */
		div.puzzle_content_block {
			display: block;
			width: 100%;
		}
		div.question_status {
			display: table;
			width: 80%;
			margin: auto;
			text-align: left;
		}
		div.question_id {
			display: inline-block;
			width: max-content;
			font-weight: bold;
			font-size: 1.5rem;
			color: var(--color_gray_2);
		}
		button.puzzle_lang_button {
			display: inline-block;
			width: max-content;
			float:right;
		}
		div.question_result_block, div.questions_result_block {
			position: relative;
			width: 1.3rem;
			display: inline-block;
		}
		div.question_result, div.questions_result {
			font-weight: normal;
			font-size: 1.3rem;
		}
		div.question_result_note, div.questions_result_note {
			opacity: 0;
			transition: opacity 0.5s;
			pointer-events: none;
			border-radius: 0.7em;
			border: 0.15em solid black;
			text-align: justify;
			display: none;
			position: absolute;
			width: 15rem;
			padding: 1rem;
			z-index: 1;
		}
		div.question_result:hover + div.question_result_note,
		div.questions_result:hover + div.questions_result_note {
			opacity: 1;
		}
		input.question, input.questions {
			font-family: 'Arbutus Slab', 'Gabriela';
			text-align: center;
			background-color: var(--color_white);
			border-radius: 0.7rem;
			border: 0.15rem solid var(--color_blue_1);
		}
		button.question, button.questions {
			font-family: 'Arbutus Slab', 'Gabriela';
			text-align: center;
			border-radius: 0.7rem;
			background-color: var(--color_blue_1);
			border: 0.1.5rem solid var(--color_blue_1);
			color: var(--color_white);
		}

		/* ** Question ** */
		input.question {
			font-size: 1rem;
			padding: 0.5rem;
			margin: 0.2rem;
			width: 80%;
			min-width: 13rem;
		}
		button.question {
			font-size: 1rem;
			padding: 0.5rem;
			margin: 0.1rem;
		}
		p.questions {
			text-align: justify;
			padding: 0;
			margin-top: 4px;
			margin-bottom: 4px;
			line-height: 1em;
		}
		div.question_result_block {
			padding-left: 0.5rem;
		}
		div.question_result_note {
			left: 23px;
		}

		/* ** Questions ** */
		input.questions {
			font-size: 0.9rem;
			padding: 0.2rem;
			margin: 0.1rem;
			width: 2rem;
		}
		button.questions {
			font-size: 0.9rem;
			padding: 0.2rem;
			margin: 0.1rem;
		}
	</style>
</xsl:template>

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
		<xsl:call-template name="html_head_style"/>
		<script src="/config/nerdamer.core.js"></script>
	</head>
</xsl:template>

<!-- body -->
<xsl:template name="html_body">
	<body>
		<xsl:call-template name="puzzles_page_title"/>
		<xsl:call-template name="title_links"/>
		<xsl:apply-templates />
		<xsl:call-template name="js-script"/>
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
		<xsl:attribute name="id"><xsl:value-of select="$puzzle_id" /></xsl:attribute>
		<xsl:apply-templates mode="puzzle_content">
			<xsl:with-param name="puzzle_id" select="$puzzle_id"/>
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
	<p class="puzzle_content"><xsl:copy-of select="node()"/></p>
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
		<!--<xsl:if test="$question_id=$puzzle_id or $question_id=concat($puzzle_id, '_1')">
			<button id="lang_button_EO_{$puzzle_id}" class="puzzle_lang_button" onclick="change_puzzle_lang('EO', '{$puzzle_id}')">EO</button>
			<button id="lang_button_RU_{$puzzle_id}" class="puzzle_lang_button" onclick="change_puzzle_lang('RU', '{$puzzle_id}')">RU</button>
			<button id="lang_button_EN_{$puzzle_id}" class="puzzle_lang_button" onclick="change_puzzle_lang('EN', '{$puzzle_id}')">EN</button>
			<xsl:for-each select="str:tokenize($lang_list, ';')">
				<p><xsl:value-of select="."/></p>
			</xsl:for-each>
		</xsl:if>-->
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

<!--##########################-->
<!--#####   JavaScript   #####-->
<xsl:template name="js-script">
	<script>
		function change_puzzle_lang(lang, id) {
			console.log('change_lang', lang, id)
		}

		async function check(id, ans){
			var input_node = document.getElementById("input_"+id);
			var result_node = document.getElementById("result_"+id);
			var result_note_node = document.getElementById("result_note_"+id);
			result_hide(result_node, result_note_node)
			await sleep_ms(100);
			try{
				var in_val = nerdamer(input_node.value).evaluate()
				for (const i in ans) {
					var ans_val = nerdamer(ans[i]).evaluate();
					if (nerdamer(in_val).eq(ans_val)) {
						result_good(result_node, result_note_node);
						return;
					}
				}
				result_bad(result_node, result_note_node);
			} catch (err) {
				result_error(result_node, result_note_node, err)
				console.log(`Error while checking answer: ${err.message}`);
			}
		}
		function result_good(result_node, result_note_node) {
			result_node.innerHTML="✔";
			result_node.style.color = "var(--color_green_2)";
			result_note_node.innerHTML = "👍 Correct answer!";
			result_note_node.style.backgroundColor = "var(--color_green_1)";
			result_note_node.style.borderColor = "var(--color_green_2)";
			result_dispaly(result_node, result_note_node)
		}
		function result_bad(result_node, result_note_node) {
			result_node.innerHTML="✘";
			result_node.style.color = "var(--color_red_2)";
			result_note_node.innerHTML = "Wrong answer!";
			result_note_node.style.backgroundColor = "var(--color_red_1)";
			result_note_node.style.borderColor = "var(--color_red_2)";
			result_dispaly(result_node, result_note_node)
		}
		function result_error(result_node, result_note_node, err) {
			result_node.innerHTML="⚠";
			result_node.style.color = "var(--color_red_2)";
			result_note_node.innerHTML = err.message;
			result_note_node.style.backgroundColor = "var(--color_red_1)";
			result_note_node.style.borderColor = "var(--color_red_2)";
			result_dispaly(result_node, result_note_node)
		}
		function result_hide(result_node, result_note_node) {
			result_note_node.style.display = "none";
		}
		function result_dispaly(result_node, result_note_node) {
			result_note_node.style.display = "block";
		}
		function sleep_ms(ms) {
			return new Promise(resolve => setTimeout(resolve, ms));
		}
	</script>
</xsl:template>

</xsl:stylesheet>