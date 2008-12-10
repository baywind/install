function up(obj) {
	var prev = obj.previousSibling;
		if(prev == null)
			return;
	while(prev.nodeName.toLowerCase() != obj.nodeName.toLowerCase()) {
		prev = prev.previousSibling;
		if(prev == null)
			return;
	}
	var parent = obj.parentNode;
	var lost = parent.removeChild(obj);
	parent.insertBefore(lost,prev);
}

function down(obj) {
	var next = obj.nextSibling;
		if(next == null)
			return;
	while(next.nodeName.toLowerCase() != obj.nodeName.toLowerCase()) {
		next = next.nextSibling;
		if(next == null)
			return;
	}
	var parent = obj.parentNode;
	var lost = parent.removeChild(next);
	parent.insertBefore(lost,obj);
}

function setValues (root,chooseClass,val)  {
	var nodes = root.childNodes;
	for (var i = 0; i < nodes.length;i++) {
		var cur = nodes[i];
		if(cur.className == chooseClass)
			cur.value = val;
		else if (cur.childNodes)
			setValues(cur,chooseClass,val);
	}
}

function enumerate (root,chooseClass,start)  {
	var nodes = root.childNodes;
	var val = start;
	for (var i = 0; i < nodes.length;i++) {
		var cur = nodes[i];
		if(cur.className == chooseClass) {
			cur.value = val;
			val++;
		}
		else if (cur.childNodes)
			val = enumerate(cur,chooseClass,val);
	}
	return val;
}