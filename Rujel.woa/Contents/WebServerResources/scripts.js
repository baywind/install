/*
 * Copyright (c) 2008, Gennady & Michael Kushnir
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 * 
 * 	•	Redistributions of source code must retain the above copyright notice, this
 * 		list of conditions and the following disclaimer.
 * 	•	Redistributions in binary form must reproduce the above copyright notice,
 * 		this list of conditions and the following disclaimer in the documentation
 * 		and/or other materials provided with the distribution.
 * 	•	Neither the name of the RUJEL nor the names of its contributors may be used
 * 		to endorse or promote products derived from this software without specific 
 * 		prior written permission.
 * 		
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
var hasChanges = false;
var changed = false;
var unsavedAlert = "Unsaved changes will be lost";
var loading = false;

	function checkChanges(fld) {
		if(hasChanges) {
			changed = true;
			return changed;
		}
		if(formElementChanged(fld)) {
			changed = true;
		} else {
			changed = formHasChanges(fld.form);
		}
		return changed;
	}
	
	function formHasChanges(aForm) {
		var elts = aForm.elements;
		for(var i = 0; i < elts.length; i++) {
			if(formElementChanged(elts[i])) {
				//alert(elts[i]);
				return true;
			}				
		}
		return false;
	}
	
	function formElementChanged(elt) {
		switch (elt.nodeName) {
		case "TEXTAREA":
			return (elt.value != elt.defaultValue);
			break;
		case "INPUT":
			switch (elt.type) {
			case "text":
				return (elt.value != elt.defaultValue);
				break;
			case "hidden":
				return (elt.value != elt.defaultValue);
				break;
			case "checkbox":
				return (elt.checked != elt.defaultChecked);
				break;
			case "radio":
				return (elt.checked != elt.defaultChecked);
				break;
			default:
				return false;
			}
			break;
		case "SELECT":
			var opts = elt.options;
			var curr;
			//var d = false;
			for(var i = 0; i < opts.length; i++) {
				curr = opts[i];
				var val = curr.text;
				if(curr.selected != curr.defaultSelected) {
					if(i > 0 || elt.multiple)
						return true;
				}
				/*  else
						d = true;
				}
				if(d && curr.defaultSelected)
					return true;*/
			}
			return false;
			break;
		default:
			return false;
		}
	}

function checkRun(loc) {
	if(!tryLoad(false))
		return false;
	if(hasChanges || changed) {
		if(confirm(unsavedAlert)) {
			changed=false;
		} else {
			return false;
		}
	}
	if(!changed) {
		var tmp = document.onUnload;
		window.onunload = function() {
			loading=false;
		}
		loading = true;
		window.location=loc;
	}
	return true;
}

function tryLoad(set) {
	if(loading) {
		o = document.getElementById('pleaseWait'); 
		if(o.style.display=='none') {
			o.style.display=''; 
		} else {
			cn = o.className;
			o.className = "selection";
			setTimeout("o.className = '" + cn + "';",200);
		}
		return false;
	} else {
		if(set != null)
			loading = set;
		else
			loading = true;
		
		if(loading) {
			window.onunload = function() {
				loading=false;
			}
		}
		return true;
	}
}

function cancelLoading() {
	loading = false;
	o = document.getElementById('pleaseWait'); 
	o.style.display ='none';
}

function eventKey(event) {
	var key;	
	if(window.event) {
		//alert("window");
		key = window.event.keyCode;
		if(key == 0)
			key = window.event.charCode
	} else if (event) {
		key = event.keyCode;
		if(key == 0)
			key = event.charCode
	} else {
		//alert('none');
		return 0;
	}
	return key;
}

function isNumberInput(event,dot) {
	var key = eventKey(event);
	if(key == null || key < 32 || key == 127)  // spec symbols
		return true;
	if (key >= 48 && key <= 57) // digins
		return true;
	if(dot && key == 46) // dot
		return true;
	return false;
}

function extOnSpace(event,fld,maxLen,message,extParent) {
	if(eventKey(event) == 32) {
		var cont = fld.value;
		if(maxLen != null && (cont == null || cont.length < maxLen))
			return true;
		returnField = fld;
		myPrompt(message, cont + ' ',fld,extParent);
		return false;
	}
	return true;
}

function extByName(fldName,maxLen,message,extParent) {
	if(fldName == null) return true;
	var fld = document.getElementById(fldName);
	if(fld == null) return true;
	return ext(fld,maxLen,message,extParent);
}

function ext(fld,maxLen,message,extParent) {
	if(fld == null) return true;
	if(typeof fld == 'string') {
		fld = document.getElementById(fld);
		if(fld == null) return true;
	}
	if(!tryLoad(false)) {
		fld.blur();
		return false;
	}
	var cont = fld.value;
	if(maxLen != null && (cont == null || cont.length < maxLen)) return true;
	returnField = fld;
	return myPrompt(message, cont,fld,extParent);
	//cont = prompt(message,cont);
	//if(cont != null) fld.value = cont;
	//checkChanges(fld);
	//return true;
}

var returnField;
function myPrompt(message,cont,pos,extParent) {
	if(cont == null && returnField.value != null)
		cont = returnField.value;
	var prmt = document.createElement('div');
	prmt.setAttribute('id','prompt');
	//prmt.setAttribute('class','backfield2');
	prmt.className = 'prompt';
	/*prmt.style.backgroundColor = '#ccffcc';
	prmt.style.width = '15em';
	prmt.style.padding = '1em';
	prmt.style.position = 'absolute';
	prmt.style.zIndex = 10;*/
	returnField.parentNode.appendChild(prmt);
	var elt;
	if(message) {
		elt = document.createElement('div');
		elt.innerHTML = message;
		prmt.appendChild(elt);
	}
	elt = document.createElement('textarea');
	elt.setAttribute('rows',3);
	elt.style.width = '96%';
	if(elt.addEventListener) {
		elt.addEventListener('keypress',promtKeys,true);
		elt.addEventListener('blur',applyPrompt,false);
	} else {
		elt.attachEvent('onkeypress',promtKeys);
		elt.attachEvent('onblur',applyPrompt);
	}
	elt.tabIndex = returnField.tabIndex;
	prmt.appendChild(elt);
	if(pos == null)
		pos = returnField;
	positionPopup(prmt,getPosition(pos));
	elt.focus();
	elt.value = cont;
	if(extParent != null) {
		var par = get(returnField,extParent);
		elt = document.createElement(extParent);
		elt.style.display = 'none';
		//elt.style.backgroundColor = par.style.backgroundColor;
		elt.className = par.className;
		elt.id = 'colorCash';
		prmt.appendChild(elt);
		/*
		if (prmt.currentStyle) {
			par.style.backgroundColor = prmt.currentStyle.backgroundColor;
		} else {
			elt = document.defaultView.getComputedStyle(prmt, "");
			par.style.backgroundColor = elt.getPropertyValue("background-color");
		}*/
		par.className = "selection";
	}
	return prmt;
}

function promtKeys(event) {
	var key = eventKey(event);
	if(key >= 9 && key <= 13) { //ENTER || TAB
		applyPrompt(event);
		returnField.select();
	} else if(key == 27) { //ESC
		closePrompt();
	}
	return true;
}

function applyPrompt(event) {
	if(event.target)
		returnField.value = event.target.value;
	else if (event.srcElement)
		returnField.value = event.srcElement.value;
	closePrompt();
	try {
		returnField.onchange();
	} catch (e) {
		//alert(e.description);
	}
}

function closePrompt() {
	prmt = document.getElementById('prompt');
	var colorCash = document.getElementById('colorCash');
	if(colorCash != null) {
		get(returnField,colorCash.nodeName).className = colorCash.className;
		//style.backgroundColor = colorCash.style.backgroundColor;
	}
	prmt.parentNode.removeChild(prmt);
//	alert(changed);
}

function focus() {
	o = document.getElementById('focus');
	if(o != null) {
		try {
		o.focus();
		o.select();
		o.click();
		} catch (e) {
		 //alert(e + '\n' + o);
		}
	}
}

var timerID = null;
var timeout = 1200;
function countdown() {
	if(timerID != null) {
		clearTimeout(timerID);
	}
	o = document.getElementById('sessionTimeout');
	if(timeout <= 60)
		o.style.color="red";
	if(timeout <= 0) {
		o.innerHTML = "- " + formatSeconds(-timeout);
	} else {
		o.innerHTML = formatSeconds(timeout);
	}
	
	timeout = timeout -1;
	timerID = setTimeout("countdown()",1000);
}

function formatSeconds(sumSeconds) {
	minutes = Math.floor(sumSeconds / 60);
	if(minutes > 60) {
		hours = Math.floor(minutes / 60);
		minutes = minutes % 60;
		if(minutes < 10)
			minutes = '0' + minutes;
		minutes = hours + ':' + minutes;
	}
	seconds = sumSeconds % 60;
	if(seconds < 10) seconds = '0' + seconds;
	return minutes + ':' + seconds;
}



function ajaxRequest() {
	var xmlHttp;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
    } catch (e) {
		// Internet Explorer
		try {
		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				alert("Your browser does not support AJAX!");
				return null;
			}
		}
    }
	return xmlHttp;
}

function onReadyStateChange(pos) {
	timeout = startTimeout;
	container = document.getElementById('ajaxMask');
	container.style.display='block';
	container.innerHTML = xmlHttp.responseText;
	cancelLoading();
	if(pos != null) {
		positionPopup(container.firstChild,pos);
	}
}

function ajaxPopupAction (action,aevent) {
	if(!tryLoad(false))
		return false;
	if(changed) {
		if(confirm(unsavedAlert)) {
			changed=false;
		} else {
			return false;
		}
	}
	var pos = null;
	try {
		pos = getPosition(aevent);
	} catch (e) {
		try {
			pos = getPosition(window.event);
		} catch (e) {
			try {
				pos = getPosition(window.event.srcElement);
			} catch (e) {
				pos = getPosition(null);
			}
		}
	}
	xmlHttp = ajaxRequest();
    xmlHttp.onreadystatechange=function() {
 		//alert('(' + xmlHttp.readyState + ')' + aevent.type + ' : ' + aevent.clientX);
    	if(xmlHttp.readyState==4)
    		onReadyStateChange(pos);
	}
    xmlHttp.open("GET",action,true);
    xmlHttp.send(null);
	loading = true;
	return true;
}

function ajaxPost(ini) {
	if(!tryLoad(false))
		return false;
	if(typeof ini == "String")
		ini = document.getElementById(ini);
	var aForm = ini;
	if(ini.form && ini.type == "submit")
		aForm = ini.form;
	else
		ini = null;
	var params = "";
	for(var i=0;i<aForm.elements.length;i++) {
		var elt = aForm.elements[i];
		if(elt == null || elt.name == null || elt.value == null)
			continue;
		if((elt.type == "radio" || elt.type == "checkbox") && !elt.checked)
			continue;
		if(elt.type == "submit" && elt != ini)
			continue;
		if(elt.type == "button")
			continue;
		if(params.length > 0)
			params = params + '&';
		params = params.concat(elt.name,'=',elt.value);
		//alert(elt.name + ' = ' + elt.value);
	}
	xmlHttp = ajaxRequest();
    xmlHttp.onreadystatechange=function() {
    	if(xmlHttp.readyState==4)
    		onReadyStateChange();
	}
	xmlHttp.open("POST",aForm.action,true);
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send(params);
	loading = true;
	return false;
}

function getPosition(pos) {
	var r = new Object();
	r.isCalculated = true;
	if(pos.clientX) {
		r.x = pos.clientX;
		r.y = pos.clientY;
		//alert("event: x=" + x + "; y=" + y);
	} else if (pos.nodeName) {
		//alert('pos : ' + pos);
		if(pos.style.display == 'none')
			pos = pos.parentNode;
		r.x = pos.offsetLeft + (pos.offsetWidth/2);
		r.y = pos.offsetTop + (pos.offsetHeight/2);
		//alert("curr: x=" + x + "; y=" + y);
		r.w = document.documentElement.offsetWidth;
		r.h = document.documentElement.offsetHeight;
		while(pos.offsetParent) {
			//alert("curr: x=" + x + "; y=" + y);
			pos = pos.offsetParent;
			/*if(pos.style.position == 'absolute') {
				//alert(pos);
				w = pos.offsetWidth;
				h = pos.offsetHeight;
				break;
			}*/
			r.x += pos.offsetLeft;
			r.y += pos.offsetTop;			
			/* if(!abs) {
				if(pos.offsetWidth > w) {
					//alert(pos + ' : ' + pos.offsetWidth);
					w = pos.offsetWidth;
				}
				if(pos.offsetHeight > h)
					h = pos.offsetHeight;
			}*/
 			r.h = Math.max(r.h,pos.offsetHeight);
			r.w = Math.max(r.w,pos.offsetWidth);
		}
		//alert("Element: x=" + r.x + "; y=" + r.y + "\nWindow: h=" + r.h + "; w=" + r.w);
	} else {
		//alert('center');
		r.x = document.documentElement.offsetWidth / 2;
		r.y = document.documentElement.offsetHeight / 2;
	}
	//alert("Position: x=" + r.x + "; y=" + r.y);
	return r;
}

function positionPopup(popup,pos) {
	//alert(pos);
	if(popup == null)
		return;
	var w, h, pheight, pwidth, x = 0, y = 0, p , abs;
	pheight = popup.offsetHeight;
	pwidth = popup.offsetWidth;
	//w = document.documentElement.offsetWidth;
	//h = document.documentElement.offsetHeight;
	//alert ('h= ' + h + '\nw= ' + w);

	if(!pos.isCalculated)
		pos = getPosition(pos);
	p = popup;
	if(p != null) {
		abs = false;
		while(p.offsetParent) {
			p = p.offsetParent;
			abs = ((p.style.position == 'absolute') || (p.style.position == 'fixed'));
			if(abs)
				break;
		}
		if(abs) {
			//alert('abs: ' + p);
			w = p.offsetWidth;
			h = p.offsetHeight;
			x -= p.offsetLeft;
			y -= p.offsetTop;
/* 			while(p.offsetParent) {
				p = p.offsetParent;			
				x -= p.offsetLeft;
				y -= p.offsetTop;
			} */
		} else {
			h = pos.h;
			w = pos.w;
		}
		//alert('X=' + x + '\nY=' + y);
	}

	popup.style.position = 'absolute';
	
	//pos = getPosition(pos);
	//alert (pos.toString);
	x += pos.x;
	y += pos.y;

	//alert('X=' + x + '\nY=' + y + '\n\nh=' + h + '\nw=' + w);
	popup.style.top = Math.max(10,y - pheight/2) + 'px';
	popup.style.left = Math.max(10,x - pwidth/2) + 'px';	
	fitWindow(popup,h,w);
}

function fitWindow(w,ph,pw) {
	if (w == null)
		w = document.getElementById('ajaxPopup');
	else if(typeof w == "String")
		w = document.getElementById(w);
	
	if(pw == null) {
		var parent = (w.offsetParent)?w.offsetParent:document.documentElement;
		pw = parent.offsetWidth;
		ph = parent.offsetHeight;
		//alert("calculated: ph = " + ph + "; pw = " + pw);
	}
	var ww = w.offsetWidth;
	var wh = w.offsetHeight;

	//alert ("doc height: " + ph + "\nwin height: " + wh + "\nwin pos: " + w.offsetTop);
	if(w.offsetTop + wh - ph > 10) {
		//alert("was top: " + w.style.top);
		w.style.top = (ph - wh - 10) + 'px';
		//alert("top: " + w.style.top);
	}
	//alert ("doc width: " + pw + "\nwin width: " + ww + "\nwin pos: " + w.offsetLeft);
	if(w.offsetLeft + ww - pw > 10) {
		//alert("was left: " + w.style.left);
		w.style.left = (pw - ww - 10) + 'px';
		//alert("left: " + w.style.left);
	}
}

function closePopup(aForm) {
	container = document.getElementById('ajaxMask');
	container.style.display='none';
	if(aForm != null) {
		for(var i = 0; i < document.forms.length; i++) {
			if(document.forms[i] == aForm)
				continue;
			changed = formHasChanges(document.forms[i]);
		}
	}
}
