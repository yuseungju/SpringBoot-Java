<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>

//금액을 천단위로 표시
function commaMoney(str){
	var result_str = "";
	str +="";
	var first_index;
	for(var current_index = str.length; 0 < current_index; current_index-=3){
		if(current_index -3 < 0)
			first_index = 0;
		else
			first_index = current_index -3;
		result_str = str.substring(first_index, current_index) + result_str;
		if(first_index != 0)
			result_str = "," + result_str;
	}
	return result_str;
}