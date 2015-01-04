
inputfield = document.getElementById("input");
outputfield = document.getElementById("output");


inputfield.onkeyup = function () {
	outputfield.innerHTML = math.eval(inputfield.value);
}

