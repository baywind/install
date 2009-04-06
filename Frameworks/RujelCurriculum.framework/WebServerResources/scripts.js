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
 
 function highlight(point) {
	var row = get(point,'tr');
	var allRows = row.parentNode.childNodes;;
	for(var i = 0; i < allRows.length ; i++ ) {
		if(allRows[i].className != "highlight2")
			continue;
		var elt = allRows[i].lastChild;
		if(elt.style && elt.style.display=="none") {
			allRows[i].className = elt.className;
			allRows[i].removeChild(elt);
		} else {
			allRows[i].className = row.className;
		}
	}
	var elt = document.createElement('td');
	elt.style.display="none";
	elt.className=row.className;
	row.className = "highlight2";
	row.appendChild(elt);
}

function clickCell(cell,button) {
	var i = cell.getElementsByTagName('input')[0];
	if(button) {
		//var f = get(cell,'form');
		if(i.disabled) {
			ajaxPost(button,cell);
			return false;
		}
	}
	 if(!i.checked)
			i.checked = true;
	return false;
}

function scrollToObj(obj) {
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
		obj.className = "highlight2";
		timer = setTimeout("blink('" + obj.id + "','" + pos + "',2)",300);
	}
	obj = document.getElementsByName('nextReason');
	if(obj && obj.length > 0) {
		for (b = 0; b < obj.length; b++)
			showInfo(obj[b]);
	}
	toggleMove();	
}
var timer;
function blink(objID,nextClass,count) {
	clearTimeout(timer);
	var obj = document.getElementById(objID);
	var tmpClass = obj.className;
	obj.className = nextClass;
	if(count > 0)
		timer = setTimeout("blink('" + objID + "','" + tmpClass + "'," + (count - 1) + ")",150);
}

		function showInfo(button) {
			if(!button.checked)
				return;
			var tmp = get(button,'tr');
			tmp = tmp.getElementsByTagName('div')[0];
			var reasonInfo = document.getElementById('reasonInfo');
			if(tmp && tmp.innerHTML)
				reasonInfo.innerHTML = tmp.innerHTML;
			else
				reasonInfo.innerHTML = '';
		}

			function tick(t) {
				if(t.disabled)
					return false;
				modifyRowClass(t);
				toggleMove();
			}
			
function toggleMove() {
	var counter = document.getElementById("total");
	if(counter) {
		if(counter.value > 0)
			showObj('move');
		else
			hideObj('move');
	}
}