<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>

function appendHtml(el, str) {
	var div = document.createElement('div');
	div.innerHTML = str;
	while (div.children.length > 0) {
		el.appendChild(div.children[0]);
	}
}

function loadJQuery(src){
	var oScript = document.createElement("script");
	oScript.type = "text/javascript";
	oScript.charset = "utf-8";	
	oScript.src = src;	
	document.getElementsByTagName("head")[0].appendChild(oScript);
}
