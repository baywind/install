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
 
function addCriterion(e) {
	var field = (e.target)?e.target:e.srcElement;
	var num = field.name.substring(1);
//	alert("num = " + num + "\ncritCount = " + field.form.critCount.value);
	field.form.m0.value = '';
	if(num < field.form.critCount.value)
		return isNumberInput(e);
	num++;
	var row = document.getElementById('titles');
	var cell = row.lastChild;
//	alert(cell);
	var tmp = cell.innerHTML.charCodeAt(0);
	tmp++;
//	alert("charChode = " + tmp);
	cell = document.createElement('th');
	cell.innerHTML = String.fromCharCode(tmp);
	row.appendChild(cell);
	row = document.getElementById('maxs');
	cell = document.createElement('td');
	tmp = document.createElement('input');
	tmp.setAttribute('type','text');
	tmp.setAttribute('name','m' + num);
	tmp.setAttribute('size','2');
	tmp.setAttribute('style','text-align:center;');
	if(tmp.addEventListener) {
		//tmp.addEventListener('keypress',addCriterion,true);
		tmp.addEventListener('change',blockCriters,false);
	} else {
		//tmp.attachEvent('onkeypress',addCriterion);
		tmp.attachEvent('onchange',blockCriters);
	}
	tmp.onkeypress = addCriterion;
//	tmp.setAttribute('onkeypress','return isNumberInput(event);');
//	tmp.setAttribute('onchange','addCriterion(this)');
	cell.appendChild(tmp);
	row.appendChild(cell);
	row = document.getElementById('weights');
	cell = document.createElement('td');
	tmp = document.createElement('input');
	tmp.setAttribute('type','text');
	tmp.setAttribute('name','w' + num);
	tmp.setAttribute('size','2');
	tmp.setAttribute('style','text-align:center;');
	if(tmp.addEventListener) {
		tmp.addEventListener('keypress',isNumberInput,true);
	} else {
		tmp.attachEvent('onkeypress',isNumberInput);
	}
	cell.appendChild(tmp);
	row.appendChild(cell);
	field.form.critCount.value = num;
	return isNumberInput(e);
}

function blockCriters(e) {
	var field = (e.target)?e.target:e.srcElement;
	if(field.name == 'm0') {	
		var maxs = document.getElementById('maxs').getElementsByTagName('input');
		for (var i = 0; i < maxs.length; i++) {
			if(field.value) {
				maxs[i].value = '';
			}
		}
	} else {
		field.form.m0.value = '';
	}
}

function setDefaults(flags,weight) {
	var form = document.getElementById('workForm');
	if(weight == null)
		form.weight.value = form.weight.defaultValue;
	else
		form.weight.value = weight;
	form.weight.disabled = (flags & 1);
	form.isHometask.checked = (flags & 16);
	form.isHometask.disabled = (flags & 4);
	form.isCompulsory.checked = (flags & 8);
	form.isCompulsory.disabled = (flags & 2);
}