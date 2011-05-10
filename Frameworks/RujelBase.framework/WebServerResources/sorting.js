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
 
function up(obj,span) {
	var prev = obj.previousSibling;
		if(prev == null)
			return;
	while(prev.nodeName.toLowerCase() != obj.nodeName.toLowerCase()) {
		prev = prev.previousSibling;
		if(prev == null)
			return;
	}
	var parent = obj.parentNode;
	if(!span)
		span = 1;
	while(span > 0) {
		var lost = parent.removeChild(obj);
		parent.insertBefore(lost,prev);
		obj = prev.nextSibling;
		while(prev.nodeName.toLowerCase() != obj.nodeName.toLowerCase()) {
			obj = obj.nextSibling;
			if(obj == null)
				return;
		}
		span--;
	}
}

function down(obj,span) {
	if(!span)
		span = 1;
	var next = obj;
	while(span > 0) {
		next = next.nextSibling;
		if(next == null)
			return;
		if(next.nodeName.toLowerCase() == obj.nodeName.toLowerCase())
			span--;
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