var weekday = new Array(7);
weekday[0] = "SUNDAY";
weekday[1] = "MONDAY";
weekday[2] = "TUESDAY";
weekday[3] = "WEDNESDAY";
weekday[4] = "THURSDAY";
weekday[5] = "FRIDAY";
weekday[6] = "SATURDAY";

function getDayName(dateString) {
    var d = new Date(dateString);
    var n = weekday[d.getDay()];
    return n.substring(0, 3);
}

// RF
function showElementById(id) {
	document.getElementById(id).style.display = 'block';
}

// RF
function hideElementById(id) {
	document.getElementById(id).style.display = 'none';
}

// RF - rende un elemento html spostabile
function dragElement(elem) {
	var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
	if (document.getElementById(elem.id + "-drag-picker"))
		document.getElementById(elem.id + "-drag-picker").onmousedown = dragMouseDown;
	else
		elem.onmousedown = dragMouseDown;

	function dragMouseDown(e) {
		e = e || window.event;
		pos3 = e.clientX;
		pos4 = e.clientY;
		document.onmouseup = closeDragElement;
		document.onmousemove = elementDrag;
	}

	function elementDrag(e) {
		e = e || window.event;
		pos1 = pos3 - e.clientX;
		pos2 = pos4 - e.clientY;
		pos3 = e.clientX;
		pos4 = e.clientY;
		elem.style.top = (elem.offsetTop - pos2) + "px";
		elem.style.left = (elem.offsetLeft - pos1) + "px";
	}

	function closeDragElement() {
		document.onmouseup = null;
		document.onmousemove = null;
	}
}
