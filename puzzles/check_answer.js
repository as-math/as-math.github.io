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
	result_display(result_node, result_note_node)
}

function result_bad(result_node, result_note_node) {
	result_node.innerHTML="✘";
	result_node.style.color = "var(--color_red_2)";
	result_note_node.innerHTML = "Wrong answer!";
	result_note_node.style.backgroundColor = "var(--color_red_1)";
	result_note_node.style.borderColor = "var(--color_red_2)";
	result_display(result_node, result_note_node)
}

function result_error(result_node, result_note_node, err) {
	result_node.innerHTML="⚠";
	result_node.style.color = "var(--color_red_2)";
	result_note_node.innerHTML = err.message;
	result_note_node.style.backgroundColor = "var(--color_red_1)";
	result_note_node.style.borderColor = "var(--color_red_2)";
	result_display(result_node, result_note_node)
}

function result_hide(result_node, result_note_node) {
	result_note_node.style.display = "none";
}

function result_display(result_node, result_note_node) {
	result_note_node.style.display = "block";
}

function sleep_ms(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}