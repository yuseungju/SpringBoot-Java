<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>

// 쿠키 생성
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
//쿠키가져오기
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
/*//id에 해당되는 값들을 저장한다.
function setCookiesAboutIds(){
	//id에 해당되는 값을 쿠키에 보관한다
	for(var i = 0; i < arguments.length; i++)
		setCookie(arguments[i] +"cookieIdToSaveReload",  $("#"+arguments[i]).val(), 1/200);
}
//보관했던 id에 해당되는 값들로 다시 셋팅한다
function getCookiesAboutIds(){
	//쿠키값에 보관한 이전정보를 선택적으로 id값에 설정한다.
	for(var i = 0; i < arguments.length; i++)
		$("#"+arguments[i] + "cookieIdToSaveReload").val(getCookie(arguments[i]));
	//쿠키값다시 리셋
	for(var i = 0; i < arguments.length; i++)
		setCookie(arguments[i] + "cookieIdToSaveReload",  "" , 0);
}

*/
