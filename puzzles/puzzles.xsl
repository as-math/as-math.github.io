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
		<link rel="shortcut icon" href="../config/icons/ico-6gon.png" type="image/png" />
		<xsl:call-template name="html_head_style"/>
		<script src="../config/nerdamer.core.js"></script>
	</head>
</xsl:template>

<xsl:template name="html_head_style">
	<style>
		@import url("../config/fonts/ArbutusSlab/arbutusslab.css");
		@import url("../config/fonts/Gabriela/gabriela.css");
		:root {
			--color_gray_1: #d3d3d3;
			--color_gray_2: #a3a3a3;
			--color_blue_1: #5a6fd4;
			--color_green_1: #99ee66;
			--color_green_2: #339900;
			--color_red_1: #fc9898;
			--color_red_2: #ff0500;
			--color_white: #ffffff;
			--puzzle_max_width: min(500px, 90vw);
			--puzzle_image_max_height: 350px;
			--group_head_font_size: 16px;
			--question_id_font_size: 23px;
			--question_result_font_size: 21px;
			--question_input_font_size: 16px;
			--question_input_padding: 6px;
			--question_input_margin: 2px;
			--question_input_width: 80%;
			--question_input_min_width: 100px;
			--question_button_font_size: 16px;
			--question_button_padding: 6px;
			--question_button_margin: 2px;
			--question_result_small_font_size: 22px;
			--question_result_small_padding: 0;
			--question_result_small_margin: 0;
			--question_result_small_width: 20px;
			--question_result_small_height: 26px;
			--question_input_small_font_size: 14px;
			--question_input_small_padding: 2px;
			--question_input_small_margin: 1px;
			--question_input_small_width: 60px;
			--question_button_small_font_size: 14px;
			--question_button_small_padding: 2px;
			--question_button_small_margin: 1px;
			--result_note_padding: 10px;
			--result_note_width: 200px;
			--result_note_max_width: 200px;
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
	<table style="margin: auto;">
		<tr>
			<td><img style="height: 100px;" src="../config/icons/title-6gon.png" /></td>
			<td style="vertical-align: middle;"><h1 style="color: var(--color_blue_1); display:inline-block; margin: 0;">Math Puzzles by AS</h1></td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="go_to_home_page">
	<div><a href="..">Home page</a></div>
</xsl:template>

<xsl:template match="group">
	<div class="group" style="display: block; margin: 4% auto;">
		<xsl:call-template name="group_head"/>
		<xsl:apply-templates select="puzzle"/>
	</div>
</xsl:template>

<xsl:template name="group_head">
	<div class="group_head" style="width: 95%; border-top: 2px solid var(--color_gray_1); margin: 1% auto; text-align: left; font-weight: bold; font-size: var(--group_head_font_size); color: var(--color_gray_2);">
		<xsl:value-of select="date"/>
	</div>
</xsl:template>

<xsl:template match="puzzle">
	<table style="display: inline-block; max-width: var(--puzzle_max_width);">
		<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
		<xsl:for-each select="image|text">
			<tr><td style="vertical-align: middle; text-align: center;">
				<xsl:apply-templates select="." mode="puzzle_content"/>
			</td></tr>
		</xsl:for-each>
		<xsl:for-each select="question|questions">
			<xsl:call-template name="question_table"/>
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template match="image" mode="puzzle_content">
	<img src="./images/{.}" style="max-height: var(--puzzle_image_max_height); max-width: var(--puzzle_max_width);"/>
</xsl:template>

<xsl:template match="text" mode="puzzle_content">
	<p style="text-align: justify;"><xsl:value-of select="."/></p>
</xsl:template>

<xsl:template match="question" mode="puzzle_questions">
	<xsl:param name="question_id"/>
	<tr><td style="vertical-align: middle; text-align: center;">
		<xsl:call-template name="question_input">
			<xsl:with-param name="question_id" select="$question_id"/>
		</xsl:call-template>
	</td></tr>
	<tr><td style="vertical-align: middle; text-align: center;">
		<xsl:call-template name="question_button">
			<xsl:with-param name="question_id" select="$question_id"/>
		</xsl:call-template>
	</td></tr>
</xsl:template>

<xsl:template match="questions" mode="puzzle_questions">
	<xsl:param name="question_id"/>
	<xsl:for-each select="./question">
		<xsl:variable name="question_id_edited">
			<xsl:value-of select="$question_id" />
			<xsl:text>_</xsl:text>
			<xsl:value-of select="count(preceding-sibling::question)+1" />
		</xsl:variable>
		<tr>
			<td style="vertical-align: top; text-align: center;">
				<xsl:call-template name="question_result_small">
					<xsl:with-param name="question_id" select="$question_id_edited"/>
				</xsl:call-template>
			</td>
			<td style="vertical-align: top;">
				<xsl:call-template name="question_input_small">
					<xsl:with-param name="question_id" select="$question_id_edited"/>
				</xsl:call-template>
			</td>
			<td style="vertical-align: top;">
				<xsl:call-template name="question_button_small">
					<xsl:with-param name="question_id" select="$question_id_edited"/>
				</xsl:call-template>
			</td>
			<td style="vertical-align: middle; width: 90%">
				<p style="text-align: justify; padding: 0; margin-top: 4px; margin-bottom: 4px; line-height: 1;"><xsl:value-of select="text"/></p>
			</td>
		</tr>
	</xsl:for-each>
</xsl:template>

<xsl:template name="question_table">
	<xsl:variable name="question_id_variable">
		<xsl:value-of select="../id" />
		<xsl:if test="count(../question) > 1">
			<xsl:text>_</xsl:text>
			<xsl:value-of select="count(preceding-sibling::question)+1" />
		</xsl:if>
	</xsl:variable>
	<tr><td style="text-align: left; vertical-align: middle;">
		<div style="display: inline-block; font-weight: bold; font-size: var(--question_id_font_size); color: var(--color_gray_2); padding-left: 10%;">
			#<xsl:value-of select="$question_id_variable"/>
		</div>
		<div style="position: relative; left: 10px; display: inline-block;">
			<div class="result" id="result_{$question_id_variable}" style="display: inline-block; font-weight: normal; font-size: var(--question_result_font_size); padding-left: 2%;"></div>
			<div class="result_note" id="result_note_{$question_id_variable}"></div>
		</div>
	</td></tr>
	<tr><td>
		<table style="width: 100%;">
			<xsl:apply-templates select="." mode="puzzle_questions">
				<xsl:with-param name="question_id" select="$question_id_variable"/>
			</xsl:apply-templates>
		</table>
	</td></tr>
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

<xsl:template name="question_result_small">
	<xsl:param name="question_id"/>
		<div style="position: relative; width: var(--question_result_small_width); height: var(--question_result_small_height); margin: 0; padding: 0;">
			<div class="result" id="result_{$question_id}" style="position: absolute; bottom: 0px; font-weight: normal; font-size: var(--question_result_small_font_size);"></div>
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