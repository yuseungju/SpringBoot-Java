<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>

 /* 1. 스레드 개념
 * 스레드의 우선순위가 다른것에 비해 낮으므로, 다른 스레드작업이 없을때만 정확히 작동 
-> 원래 기본process 또는 다른 스레드에서 10초가 소요된다면, 지연 5초를 두어도 10으로 지연됨   */

var pause_state = [];
var millisecond_global = [];
var date = [];
var play = [];
//모든 지연 해제
function CancelAllThreadSleep(row){
	pause_state[row] = true;
}
//millisecond동안 지연
function threadSleep(millisecond, interrupt_unit, row){
	millisecond_global[row] = millisecond;
	pause_state[row] = false;
    date[row]= new Date();
    play[row] = setInterval(function() {
	   if((new Date()) - date[row] > millisecond_global[row]  ||  pause_state[row])
		   clearInterval(play[row]);
	}, interrupt_unit);
}
//남은 지연시간은  thread delay지연 -> busy waiting로 지연변경 (다른 모든 작업이 동작할 수 없음)
function threadBreak(row){
	clearInterval(play[row]);
	while(true){
	   if((new Date()) - date[row] >  millisecond_global[row]  ||  pause_state[row]){
		   break;
	   }
	}
}
//함수를 millisecond동안 실행시킨다.
function threadSleepFuntion(func, millisecond){
    var date = new Date();
	func();
    var play = setInterval(function() {
	   if((new Date()) - date > millisecond){
		   clearInterval(play);
	   }
	}, 200);
}