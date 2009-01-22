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
 
var tmp;

function dim(obj) {
	tmp = {
	backgroundColor: obj.style.backgroundColor,
	textDecoration: obj.style.textDecoration,
	cursor: obj.style.cursor
	};
	obj.style.textDecoration = "underline";
	obj.style.cursor = "pointer";
	
	var color = recursiveRGBColor(obj);
	if(color == null) {
		obj.style.backgroundColor = "grey";
		return;
	}
	color.r -= 0x33;
	if(color.r < 0)
		color.r = 0;
	color.g -= 0x33;
	if(color.g < 0)
		color.g = 0;
	color.b -= 0x33;
	if(color.b < 0)
		color.b = 0;
	obj.style.backgroundColor = color.toHex();
}

function unDim(obj) {
	obj.style.backgroundColor = tmp.backgroundColor;
	obj.style.textDecoration = tmp.textDecoration;
	obj.style.cursor = tmp.cursor;
}

 function get(point, toGet, skip) {
	if(skip == null)
		skip = 0;
	var found = 0;
	while (found <= skip) {
		point = point.parentNode;
		if(point.nodeName.toLowerCase() == toGet.toLowerCase())
			found++;
	}
	return point;
}

function setDisplay(obj,value) {
	if(typeof obj == 'string') {
		obj = document.getElementById(obj);
		if(obj == null) return false;
	}
	obj.style.display = value;
	return obj;
}

function showObj(obj) {
	return setDisplay(obj,'');
}

function hideObj(obj) {
	return setDisplay(obj,'');
}

function toggleObj(obj) {
	if(typeof obj == 'string') {
		obj = document.getElementById(obj);
		if(obj == null) return false;
	}
	if(obj.style.display == 'none')
		obj.style.display = '';
	else
		obj.style.display = 'none';
	return obj;
}

function recursiveRGBColor(obj) {
	var result = getBgRGBColor(obj);
	if(result != null || obj.parentNode == null)
		return result;
	return recursiveRGBColor(obj.parentNode);
}

function getBgRGBColor(obj) {
	try {
		var color = null;
		if (obj.currentStyle) {
			color = obj.currentStyle.backgroundColor;
		} else {
			color = document.defaultView.getComputedStyle(obj, "");
			color = color.getPropertyValue("background-color");
		}
		if(color == null && obl.bgColor) {
			color = obj.bgColor;
		}
		if(color == null) {
			return null;
		}
		color = new RGBColor(color);
		if(!color.ok) {
			return null;
		}
		return color;
	} catch (e) {
		//alert(e);
		return null;
	}
}
