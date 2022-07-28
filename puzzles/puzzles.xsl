<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/document">
	<html>
		<xsl:call-template name="html_head"/>
		<xsl:call-template name="html_body"/>
	</html>
</xsl:template>

<xsl:template name="html_head">
	<head>
		<title>AS - Math Puzzles</title>
		<link rel="shortcut icon" href="/config/icons/ico-6gon.png" type="image/png" />
		<xsl:call-template name="html_head_style"/>
		<script src="/config/nerdamer.core.js"></script>
	</head>
</xsl:template>

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
			--puzzle_max_width: min(30rem, 90vw);
			--puzzle_image_max_height: 20rem;
			--group_head_font_size: 1rem;
			--question_id_font_size: 1.5rem;
			--question_result_font_size: 1.3rem;
			--question_input_font_size: 1rem;
			--question_input_padding: 0.5rem;
			--question_input_margin: 0.2rem;
			--question_input_width: 80%;
			--question_input_min_width: 13rem;
			--question_button_font_size: 1rem;
			--question_button_padding: 0.5rem;
			--question_button_margin: 0.1rem;
			--question_result_small_font_size: 1.3rem;
			--question_result_small_width: 1.3rem;
			--question_input_small_font_size: 0.9rem;
			--question_input_small_padding: 0.2rem;
			--question_input_small_margin: 0.1rem;
			--question_input_small_width: 2rem;
			--question_button_small_font_size: 0.9rem;
			--question_button_small_padding: 0.2rem;
			--question_button_small_margin: 0.1rem;
			--result_note_padding: 1rem;
			--result_note_width: 15rem;
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
		button {
			font-family: 'Arbutus Slab', 'Gabriela';
			text-align:  center;
			border-radius: 10px;
			background-color: var(--color_blue_1);
			border: 2px solid var(--color_blue_1);
			color: var(--color_white);
		}
		input {
			font-family: 'Arbutus Slab', 'Gabriela';
			text-align:  center;
			background-color: var(--color_white);
			border-radius: 10px;
			border: 2px solid var(--color_blue_1);
		}
		.result_note {
			opacity: 0;
			transition: opacity 0.5s;
			pointer-events: none;
			border-radius: 10px;
			border: 2px solid black;
			text-align: justify;
			display: none;
			position: absolute;
			left: 23px;
			width: var(--result_note_width);
			max-width: var(--result_note_max_width);
			padding: var(--result_note_padding);
		}
		.result:hover + .result_note{
			opacity: 1;
		}
		a.head_link {
			display: block;
			color: var(--color_blue_1);
		}
	</style>
</xsl:template>

<xsl:template name="html_body">
	<body>
		<xsl:call-template name="puzzles_page_title"/>
		<xsl:call-template name="go_to_home_page"/>
		<xsl:apply-templates />
		<xsl:call-template name="js-script"/>
	</body>
</xsl:template>

<xsl:template name="puzzles_page_title">
	<div style="margin: auto; display: table; max-width: 90vw;">
		<img src="/config/icons/title-6gon.png" style="display: table-cell; vertical-align: middle; height: 7rem;"/>
		<h1 style="display: table-cell; vertical-align: middle; font-size: 2.5rem; white-space: nowrap; color: var(--color_blue_1);">Math Puzzles by AS</h1>
	</div>
</xsl:template>

<xsl:template name="go_to_home_page">
	<a class="head_link" href="/">Home page</a>
	<a class="head_link" href="https://t.me/SerovaA_math"><img src="/config/icons/telegram_icon.svg" style="height: 1em; margin-right: 0.2em; margin-bottom: -0.1em;"/>Telegram channel</a>
	
</xsl:template>

<xsl:template match="group">
	<div class="group" style="display: block; margin: 2rem auto;">
		<xsl:call-template name="group_head"/>
		<xsl:apply-templates select="puzzle"/>
	</div>
</xsl:template>

<xsl:template name="group_head">
	<div class="group_head" style="width: 95%; border-top: 0.2rem solid var(--color_gray_1); margin: 0.1rem auto; text-align: left; font-weight: bold; font-size: var(--group_head_font_size); color: var(--color_gray_2);">
		<xsl:value-of select="date"/>
	</div>
</xsl:template>

<xsl:template match="puzzle">
	<div style="display: inline-block; width: var(--puzzle_max_width);">
		<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
		<xsl:for-each select="image|text">
			<xsl:apply-templates select="." mode="puzzle_content"/>
		</xsl:for-each>
		<xsl:for-each select="question|questions">
			<xsl:call-template name="question_block"/>
		</xsl:for-each>
	</div>
</xsl:template>

<xsl:template match="image" mode="puzzle_content">
	<xsl:choose>
		<xsl:when test="./@type='svg'">
			<xsl:variable name="svg_src" select="concat('./images/', ./node())"/>
			<xsl:call-template name="include_svg__width_100">
				<xsl:with-param name="src" select="$svg_src"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<img src="./images/{.}" style="display: block; max-width: 100%; max-height: var(--puzzle_image_max_height); margin: auto;"/>
		</xsl:otherwise>
	</xsl:choose> 
</xsl:template>

<xsl:template match="text" mode="puzzle_content">
	<p style="display: block; width: 100%; text-align: justify;"><xsl:copy-of select="node()"/></p>
</xsl:template>

<xsl:template name="include_svg__width_100">
	<xsl:param name="src"/>
	<xsl:apply-templates select="document($src)" mode="svg_image"/>
</xsl:template>

<xsl:template name="include_svg">
	<xsl:param name="src"/>
	<xsl:copy-of select="document($src)"/>
</xsl:template>

<xsl:template match="node()" mode="svg_image">
	<xsl:copy>
		<xsl:apply-templates select="@*"/>
		<xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="height"></xsl:attribute>
		<xsl:apply-templates select="node()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="@*|node()">
		<xsl:copy>
				<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
</xsl:template>

<xsl:template name="question_block">
	<xsl:variable name="question_id_variable">
		<xsl:value-of select="../id" />
		<xsl:if test="count(../question)+count(../questions) > 1">
			<xsl:text>_</xsl:text>
			<xsl:value-of select="count(preceding-sibling::question)+count(preceding-sibling::questions)+1" />
		</xsl:if>
	</xsl:variable>
	<div style="display: block; width: 100%; text-align: left;">
		<div style="display: inline-block; font-weight: bold; font-size: var(--question_id_font_size); color: var(--color_gray_2); padding-left: 10%;">
			#<xsl:value-of select="$question_id_variable"/>
		</div>
		<div style="position: relative; left: 0.5rem; display: inline-block;">
			<div class="result" id="result_{$question_id_variable}" style="display: inline-block; font-weight: normal; font-size: var(--question_result_font_size);"></div>
			<div class="result_note" id="result_note_{$question_id_variable}"></div>
		</div>
	</div>
	<xsl:apply-templates select="." mode="puzzle_content">
		<xsl:with-param name="question_id" select="$question_id_variable"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="question" mode="puzzle_content">
	<xsl:param name="question_id"/>
	<div style="display:block; width: 100%;">
		<xsl:call-template name="question_input">
			<xsl:with-param name="question_id" select="$question_id"/>
		</xsl:call-template>
	</div>
	<div style="display:block; width: 100%;">
		<xsl:call-template name="question_button">
			<xsl:with-param name="question_id" select="$question_id"/>
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template name="question_input">
	<xsl:param name="question_id"/>
	<input type="text" id="input_{$question_id}" style="font-size: var(--question_input_font_size); padding: var(--question_input_padding); margin: var(--question_input_margin); width: var(--question_input_width); min-width: var(--question_input_min_width);" placeholder="{text}" />
</xsl:template>

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
	<button onclick="check('{$question_id}', {$answer})" style="font-size: var(--question_button_font_size); padding: var(--question_button_padding); margin: var(--question_button_margin);">
		Check
	</button>
</xsl:template>

<xsl:template match="questions" mode="puzzle_content">
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
					<xsl:call-template name="question_result_small">
						<xsl:with-param name="question_id" select="$question_id_edited"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="question_input_small">
						<xsl:with-param name="question_id" select="$question_id_edited"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="question_button_small">
						<xsl:with-param name="question_id" select="$question_id_edited"/>
					</xsl:call-template>
				</td>
				<td>
					<p style="text-align: justify; padding: 0; margin-top: 4px; margin-bottom: 4px; line-height: 1;"><xsl:value-of select="text"/></p>
				</td>
			</tr>
		</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<xsl:template name="question_result_small">
	<xsl:param name="question_id"/>
		<div style="position: relative; width: var(--question_result_small_width); height: var(--question_result_small_height); margin: 0; padding: 0;">
			<div class="result" id="result_{$question_id}" style="font-weight: normal; font-size: var(--question_result_small_font_size);"></div>
			<div class="result_note" id="result_note_{$question_id}"></div>
		</div>
</xsl:template>

<xsl:template name="question_input_small">
	<xsl:param name="question_id"/>
	<input type="text" id="input_{$question_id}" style="font-size: var(--question_input_small_font_size); padding: var(--question_input_small_padding); margin: var(--question_input_small_margin); width: var(--question_input_small_width);" />
</xsl:template>

<xsl:template name="question_button_small">
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
	<button onclick="check('{$question_id}', {$answer})" style="font-size: var(--question_button_small_font_size); padding: var(--question_button_small_padding); margin: var(--question_button_small_margin);">
		Check
	</button>
</xsl:template>

<xsl:template name="js-script">
	<script>
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