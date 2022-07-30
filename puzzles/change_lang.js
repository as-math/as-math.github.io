document.addEventListener('DOMContentLoaded', () => {
	let buttons = document.getElementsByClassName("puzzle_lang_button");
	for (let i=0; i < buttons.length; i++){
		if (buttons[i].lang == "EN") {
			buttons[i].click();
		}
	}
});

function change_puzzle_lang(lang, id) {
	let puzzle = document.getElementById("puzzle_"+id);
	change_lang_text(puzzle, lang);
	change_lang_svg(puzzle, lang);
	change_active_button(puzzle, lang)
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