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
	
function confirmAction(action,event) {
	if(event == null) {
		event = window.event;
	}
	if(event.shiftKey)
		return true;
	if(action == null && event.srcElement.value)
		action = event.srcElement.value;
	var message = confirmAlert.replace('%s',action);
	return confirm(message);
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
		var o = document.getElementById('pleaseWait');
		//alert(o.innerHTML);
		if(o.style.display=='none') {
			o.style.display='';
		} else {
			//cn = o.className;
			o.style.backgroundColor = "#00ff00";
			setTimeout("document.getElementById('pleaseWait').style.backgroundColor = '';",200);
		}
		positionPopup(o,getPosition(null)); 
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
		//alert("keyCode = " + event.keyCode + "\ncharCode = " + event.charCode);
	} else if (event) {
		key = event.keyCode;
		//alert("keyCode = " + event.keyCode + "\ncharCode = " + event.charCode);
		if(key == 0)
			key = event.charCode;
	} else {
		//alert('none');
		return 0;
	}
	return key;
}

function isNumberInput(event,dot) {
	//alert("keyCode = " + event.keyCode + "\ncharCode = " + event.charCode);
	if ((event.charCode == null || event.charCode == 0) 
			&& event.keyCode >= 37 && event.keyCode <= 40)
		return true;
	var key = eventKey(event);
	if(key == null || key < 32 || key == 127)  // spec symbols
		return true;
	if (key >= 48 && key <= 57) // digins
		return true;
	if(dot && key == 46) // dot
		return true;
	if(dot && ((key >= 42 && key <= 47) || key == 1073 || key == 1102)) {
		if(event.srcElement)
			insertAtCursor(event.srcElement, '.');
		else if(event.target)
			insertAtCursor(event.target, '.');
	}
	return false;
}

function insertAtCursor(myField, myValue) {
  if (document.selection) {
  //IE support
    myField.focus();
    sel = document.selection.createRange();
    sel.text = myValue;
  } else if (myField.selectionStart || myField.selectionStart == '0') {
  //MOZILLA/NETSCAPE support
    var startPos = myField.selectionStart;
    var endPos = myField.selectionEnd;
    myField.value = myField.value.substring(0, startPos)
                  + myValue
                  + myField.value.substring(endPos, myField.value.length);
    myField.selectionEnd = startPos + myValue.length;
  } else {
    myField.value += myValue;
  }
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
	//debug(pos);
	timeout = startTimeout;
	container = document.getElementById('ajaxMask');
	container.style.height = pos.h + 'px';
	container.style.width = pos.w + 'px';
	container.style.display='block';
	if(navigator.appName.search("Explorer") > 0) {
		container.style.backgroundImage = 'none';
		//container.style.backgroundColor = "#999999";
		//container.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=50)";
	}
	/*
	container = document.getElementById('popupContainer');
	if(container == null) {
		container = document.createElement('div');
		container.setAttribute('id','popupContainer');
		document.documentElement.appendChild(container);
	} else {
		container.style.display='block';
	}*/
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
	if(aevent != null) {
	try {
		pos = getPosition(aevent);
	} catch (e) {
		if(window.event) {
		try {
			pos = getPosition(window.event);
		} catch (e) {
			try {
				pos = getPosition(window.event.srcElement);
			} catch (e) {
				;
			}
		}
		}
	}
	}
	if(pos == null) {
		pos = getPosition(null);
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

function ajaxPost(ini,aevent) {
	if(!tryLoad(false))
		return false;
	if(document.getElementById(ini))
		ini = document.getElementById(ini);
	var aForm = ini;
	if(ini.form)
		aForm = ini.form;
	if(ini.type != "submit")
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
	var pos = null;
	if(aevent != null) {
	try {
		pos = getPosition(aevent);
	} catch (e) {
		if(window.event) {
		try {
			pos = getPosition(window.event);
		} catch (e) {
			try {
				pos = getPosition(window.event.srcElement);
			} catch (e) {
				;
			}
		}
		}
	}
	}
	if(pos == null) {
		pos = getPosition(null);
	}
	xmlHttp = ajaxRequest();
    xmlHttp.onreadystatechange=function() {
    	if(xmlHttp.readyState==4)
    		onReadyStateChange(pos);
	}
	xmlHttp.open("POST",aForm.action,true);
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send(params);
	loading = true;
	return false;
}

function getXscroll() {
	if(window.pageXOffset >= 0)
		return window.pageXOffset;
	else if (document.documentElement.scrollLeft >= 0)
		return document.documentElement.scrollLeft;
	return 0;
}

function getYscroll() {
	if(window.pageYOffset >= 0)
		return window.pageYOffset;
	else if (document.documentElement.scrollTop >= 0)
		return document.documentElement.scrollTop;
	return null;
}

function getPosition(pos) {
	//debug(pos);
	var r = new Object();
	r.isCalculated = true;
	var doc = document.documentElement;
	r.w = Math.max(doc.scrollWidth,doc.clientWidth - 5);
	r.h = Math.max(doc.scrollHeight,doc.clientHeight - 5);
	
	if(pos != null && pos.clientX) { // event
		r.clientX = pos.clientX;
		r.clientY = pos.clientY;
		r.x = pos.pageX;
		r.y = pos.pageY;
		if(! (r.x >= 0)) {
			r.x = r.clientX + getXscroll();
			r.y = r.clientY + getYscroll();
		}
		//alert("event: x=" + x + "; y=" + y);
	} else if (pos != null && pos.nodeName) { // DOM element
		//alert('pos : ' + pos);
		if(pos.style.display == 'none')
			pos = pos.parentNode;
		r.x = pos.offsetLeft + (pos.offsetWidth/2);
		r.y = pos.offsetTop + (pos.offsetHeight/2);
		//alert("curr: x=" + x + "; y=" + y);
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
		if(window.innerWidth) {
			r.x = window.innerWidth / 2;
			r.y = window.innerHeight / 2;
		} else if(document.documentElement.clientWidth) {
			r.x = document.documentElement.clientWidth / 2;
			r.y = document.documentElement.clientHeight / 2;
		}
		r.x += getXscroll();
		r.y += getYscroll();
	}
	//debug(r);
	return r;
}

function positionPopup(popup,pos) {
	//debug(pos);
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
	//debug(pos);
	fitWindow(popup,h,w);
}

function fitWindow(w,ph,pw) {
	if (w == null)
		w = document.getElementById('ajaxPopup');
	else if(document.getElementById(w))
		w = document.getElementById(w);
	
	//alert("window = " + window.innerWidth + "\nclient = " + document.documentElement.clientWidth);
	if(document.documentElement.clientWidth) {
		pw = document.documentElement.clientWidth;
		ph = document.documentElement.clientHeight;
	} else if(window.innerWidth) {
		pw = window.innerWidth;
		ph = window.innerHeight;
	}
	
	pw += getXscroll();
	ph += getYscroll();
	
	var ww = w.offsetWidth;
	var wh = w.offsetHeight;

	if(w.offsetTop + wh - ph > 10) {
		w.style.top = Math.max(getYscroll() + 10,(ph - wh - 10)) + 'px';
	} else if (w.offsetTop < (getYscroll() + 10)) {
		w.style.top = (getYscroll() + 10) + 'px';
	}
	if(w.offsetLeft + ww - pw > 10) {
		w.style.left = Math.max(getXscroll() + 10,(pw - ww - 10)) + 'px';
	} else if(w.offsetLeft < (getXscroll() + 10)) {
		w.style.left = (getXscroll() + 10) + 'px';
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
//	container = document.getElementById('popupContainer');
//	container.style.display='none';
}

	function debug(obj) {
		var result = typeof obj;
		for (var prop in obj) {
			result = result + '\n' + prop + " = " + obj[prop];
		}
		alert(result);
	}

function scrollToObj(obj,blinkClass) {
	if(document.getElementById(obj)) {
		obj = document.getElementById(obj);
	}
	if(obj && obj.id) {
		var height = window.innerHeight;
		if( !height) {
			height = document.documentElement.clientHeight;
		}
		var pos = getPosition(obj);
		if(height < pos.y + obj.offsetHeight/2) {
			window.scrollTo(0,pos.y - height/2);
		}
		pos = obj.className;
		if(blinkClass) {
			obj.className = blinkClass;
			blinkTimer = setTimeout("blink('" + obj.id + "','" + pos + "',2)",300);
		}
	}
}

var blinkTimer;
function blink(objID,nextClass,count) {
	clearTimeout(blinkTimer);
	var obj = document.getElementById(objID);
	var tmpClass = obj.className;
	obj.className = nextClass;
	if(count > 0)
		blinkTimer = setTimeout("blink('" + objID + "','" + tmpClass + "'," + (count - 1) + ")",150);
}