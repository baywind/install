	function modifyRowClass(obj, trueClass, falseClass) {
		row = get(obj,'tr');
		var counter = document.getElementById("total");
		var currCount = 1;
		if(counter != null)
			currCount = counter.value;
		if(obj.checked) {
			if(trueClass)
				row.className = trueClass;
			currCount++;
		} else {
			if(falseClass)
				row.className = falseClass
			currCount--;
		}
		if(counter != null)
			counter.value = currCount;
		changeMass(null);
		return true;
	}
	
function changeMass(value) {
	if(value == all) return;
	try {
		if(value == true) {
			document.getElementById("checkAll").disabled = true;
			document.getElementById("uncheckAll").disabled = false;
			document.getElementById("toggle").style.color = "#999999";
		} else if (value == false) {
			document.getElementById("checkAll").disabled = false;
			document.getElementById("uncheckAll").disabled = true;
			document.getElementById("toggle").style.color = "#999999";
		} else {
			/*if(value == "toggle" && (all == true || all == false)) {
				changeMass(!all);
				return;
			}*/
			document.getElementById("checkAll").disabled = false;
			document.getElementById("uncheckAll").disabled = false;
			document.getElementById("toggle").style.color = "blue";
		}
	} catch (e) {
		// is not inline
	}
	all = value;
}

	function setAll(value) {
		var ls = document.getElementsByName('cb');
		var curr;
		
		for(var i = 0; i < ls.length; i++) {
			curr = ls[i];
			//if(curr.id == "cb") {
				var changed = false;
				switch (value) {
				case null:
					break;
				case "toggle":
					curr.checked = !curr.checked;
					changed = true;
					break;
				case "default":
					if(curr.checked != curr.defaultChecked) {
						curr.checked=curr.defaultChecked;
						changed = true;
					}
					break;
				default:
					if(curr.checked != value) {
						curr.checked=value;
						changed = true;
					}
				}
				if(changed) {
					try {
						curr.onclick();
					} catch (e) {
					}
				}
			//}
		}
		changeMass(value);
	}