Event.observe(document, 'dom:loaded', function() {

	HumbleFinance.trackFormatter = function(obj) {
		var x = Math.floor(obj.x);
		var data = jsonData[x];
		var text = getDayName(data.day) + " " + data.day
		+ " Avg Day: " + Math.round(data.avgDay*100)/100
		+ " Min Night: " + Math.round(data.minNight*100)/100
		+ " Real Leakage: " + Math.round(data.realLeakage*100)/100;
		return text;
	};

	HumbleFinance.yTickFormatter = function(n) {
		if (n == this.axes.y.max) {
			return false;
		}
		return n + ' l/s';
	};

	HumbleFinance.xTickFormatter = function(n) {
		if (n == 0) {
			return false;
		}
		var date = jsonData[parseInt(n)].day;
		// date = date.split('-');
		// date = date[0];
	return date;
	}

	HumbleFinance.init('finance', avgDay, minNight, realLeakage);
	HumbleFinance.setFlags(flagData);
	var xaxis = HumbleFinance.graphs.summary.axes.x;
	var prevSelection = HumbleFinance.graphs.summary.prevSelection;
	var xmin = xaxis.p2d(prevSelection.first.x);
	var xmax = xaxis.p2d(prevSelection.second.x);
	$('dateRange').update(jsonData[xmin].day + ' <---> ' + jsonData[xmax].day);

	Event.observe(HumbleFinance.containers.summary, 'flotr:select', function(e) {
		var area = e.memo[0];
		xmin = Math.floor(area.x1);
		xmax = Math.ceil(area.x2);
		var date1 = jsonData[xmin].day;
		var date2 = jsonData[xmax].day;
		$('dateRange').update(jsonData[xmin].day + ' <---> ' + jsonData[xmax].day);
	});
});

function setYRange() {
	var prevSelection = HumbleFinance.graphs.summary.prevSelection;
	var xaxis = HumbleFinance.graphs.summary.axes.x;
	var xmin = prevSelection ? xaxis.p2d(prevSelection.first.x) : HumbleFinance.bounds.xmin;
	var xmax = prevSelection ? xaxis.p2d(prevSelection.second.x) : HumbleFinance.bounds.xmax;
	HumbleFinance.bounds.ymin = document.getElementById('minY').value ? parseFloat(document.getElementById('minY').value) : null;
	HumbleFinance.bounds.ymax = document.getElementById('maxY').value ? parseFloat(document.getElementById('maxY').value) : null;
    var area = {x1: xmin,
    			y1: HumbleFinance.graphs.summary.selection.first.y,
    			x2: xmax,
    			y2: HumbleFinance.graphs.summary.selection.second.y};
    HumbleFinance.graphs.summary.setSelection(area);
}