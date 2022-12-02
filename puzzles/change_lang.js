document.addEventListener('DOMContentLoaded', () => {
	change_global_lang("EN");
});

function change_global_lang(lang) {
	let lang_buttons = document.getElementsByClassName("global_lang_button");
	for (let i=0; i < lang_buttons.length; i++){
		if (lang_buttons[i].lang == lang) {
			lang_buttons[i].classList.add("active");
		} else {
			lang_buttons[i].classList.remove("active");
		}
	}
	let puzzles = document.getElementsByClassName("puzzle")
	for (let i=0; i < puzzles.length; i++){
		let buttons = puzzles[i].getElementsByClassName("puzzle_lang_button");
		if (buttons.length != 0) {
			for (let j=0; j < buttons.length; j++){
				if (buttons[j].lang == lang) {
					buttons[j].click();
				}
			}
		} else {
			change_lang_input(puzzles[i], lang);
			change_lang_check_button(puzzles[i], lang);
			change_lang_question_tip(puzzles[i], lang)
		}
	}
}

function change_puzzle_lang(lang, id) {
	let puzzle = document.getElementById("puzzle_"+id);
	change_lang_text(puzzle, lang);
	change_lang_input(puzzle, lang);
	change_lang_check_button(puzzle, lang);
	change_lang_svg(puzzle, lang);
	change_active_button(puzzle, lang)
	change_lang_question_tip(puzzle, lang)
}

function change_lang_text(puzzle, lang) {
	let text_nodes = puzzle.getElementsByTagName("p");
	for (let i=0; i < text_nodes.length; i++){
		if (text_nodes[i].hasAttribute('lang')) {
			if (text_nodes[i].lang == lang) {
				text_nodes[i].style.display = "block";
			} else {
				text_nodes[i].style.display = "none";
			}
		}
	}
}

function change_lang_input(puzzle, lang) {
	let input_nodes = puzzle.getElementsByTagName("input");
	for (let i=0; i < input_nodes.length; i++){
		if (input_nodes[i].classList.contains("question")){
			if (lang == "EN") {
				if (input_nodes[i].dataset.textEn != "") {
					input_nodes[i].placeholder = input_nodes[i].dataset.textEn;
				} else {
					input_nodes[i].placeholder = input_nodes[i].dataset.text;
				}
			}
			if (lang == "RU") {
				if (input_nodes[i].dataset.textRu != "") {
					input_nodes[i].placeholder = input_nodes[i].dataset.textRu;
				} else {
					input_nodes[i].placeholder = input_nodes[i].dataset.text;
				}
			}
			if (lang == "EO") {
				if (input_nodes[i].dataset.textEo != "") {
					input_nodes[i].placeholder = input_nodes[i].dataset.textEo;
				} else {
					input_nodes[i].placeholder = input_nodes[i].dataset.text;
				}
			}
		}
	}
}

function change_lang_check_button(puzzle, lang) {
	let button_nodes = puzzle.getElementsByTagName("button");
	for (let i=0; i < button_nodes.length; i++){
		if (button_nodes[i].classList.contains("question") | button_nodes[i].classList.contains("questions")) {
			if (lang == "EN") {
				button_nodes[i].innerHTML = "Check";
			}
			if (lang == "RU") {
				button_nodes[i].innerHTML = "Проверить";
			}
			if (lang == "EO") {
				button_nodes[i].innerHTML = "Kontroli";
			}
		}
	}
}

function change_lang_question_tip(puzzle, lang) {
	let ques_tip_nodes = puzzle.getElementsByClassName("question_tip");
	for (let i=0; i < ques_tip_nodes.length; i++){
		if (ques_tip_nodes[i].tagName == "DIV") {
			if (lang == "EN") {
				ques_tip_nodes[i].innerHTML = "The answer is a mathematical expression. You can use brackets, basic mathematical operations and functions.<br><br>For example: (2*pi+1)/sqrt(2)+3^2";
			}
			if (lang == "RU") {
				ques_tip_nodes[i].innerHTML = "Ответом является математическое выражение. Можно использовать скобки, основные математические операции и функции.<br><br>Например: (2*pi+1)/sqrt(2)+3^2";
			}
			if (lang == "EO") {
				ques_tip_nodes[i].innerHTML = "La respondo estas matematika esprimo. Vi povas uzi krampojn, bazajn matematikajn operaciojn kaj funkciojn.<br><br>Ekzemple: (2*pi+1)/sqrt(2)+3^2";
			}
		}
	}
}

function change_lang_svg(puzzle, lang) {
	let svg_nodes = puzzle.getElementsByTagName("svg");
	for (let i=0; i < svg_nodes.length; i++){
		lang_content = svg_nodes[i].getElementsByClassName("lang_dependent_content");
		for (let j=0; j<lang_content.length; j++) {
			if (lang_content[j].getAttribute("lang") == lang) {
				lang_content[j].style.visibility = "visible";
			} else {
				lang_content[j].style.visibility = "hidden";
			}
		}
	}
}

function change_active_button(puzzle, lang) {
	let buttons = puzzle.getElementsByClassName("puzzle_lang_button");
	for (let i=0; i < buttons.length; i++){
		if (buttons[i].lang == lang) {
			buttons[i].classList.add("active");
		} else {
			buttons[i].classList.remove("active");
		}
	}
}