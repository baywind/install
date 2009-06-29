var obj;
function toggleObj(id) {
	if(obj) {
		obj.style.display = 'none';
		if(obj.id == id) {
			obj = null;
			return obj;
		}
	}
	obj = document.getElementById(id);
	if(obj == null) return false;
		obj.style.display = 'block';
	return obj;
}

function dim(obj) {
	obj.style.backgroundColor='#999999';
}

function unDim(obj) {
	obj.style.backgroundColor='';
}

var pageName;
function updateFrame(head) {
	var frame = window.parent.frames["content"];
	try {
		var href = frame.location.href;
		var idx = href.lastIndexOf("/");
		if(idx > 0 && href.indexOf("\\",idx) < 0)
			pageName = href.substring(idx);
	} catch (e) {
	}
	frame.location = head.substring(0,head.lastIndexOf("/")) + pageName;
}
