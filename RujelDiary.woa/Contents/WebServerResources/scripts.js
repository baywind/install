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
 
 function takeValueForKey(value,key,submit) {
 	var form = document.forms[0];
 	var field = form[key];
 	if(field == null) {
 		field = document.createElement('input');
		field.setAttribute('type','hidden');
		field.setAttribute('name',key);
		form.appendChild(field);	
 	}
 	field.value = value;
 	if(submit) {
 		removeDefault(form);
 		form.submit();
 	}
 }
 
function removeDefault(aForm) {
	var toRemove = [];
	var j = 0;
	for(var i=0;i<aForm.elements.length;i++) {
		var elt = aForm.elements[i];
		//alert(elt.name + " (" + elt.className + "):\nvalue = " + elt.value + "\ndefault = " + elt.defaultValue);
		if(elt.value == null || (elt.value == elt.defaultValue && elt.className == "default")) {
			//alert(elt.name + ":\nvalue = " + elt.value + "\ndefault = " + elt.defaultValue);
			//elt.parentNode.removeChild(elt);
			toRemove[j++] = elt;
		}
	}
	if(j > 0) {
		for(j--;j >=0;j--)
			toRemove[j].parentNode.removeChild(toRemove[j]);
	}
	return true;
}