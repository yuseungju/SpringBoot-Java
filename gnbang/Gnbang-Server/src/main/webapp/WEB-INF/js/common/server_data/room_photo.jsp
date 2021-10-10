<%@ page language ="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gnbang.webserver.config.GlobalValue" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
/*
function RoomPhotoJs() {
	this.upload_form_id = "upload_file_frm";
	this.input_id = "upload_file";
	
    this._createUploadForm = function() {
		var html = "<form id=\""+this.upload_form_id+"\" onsubmit=\"return false;\">";
		html += "<input id=\""+this.input_id+"\" type=\"file\" name=\"uploadFile\" accept=\"image/*\"  style='display: none;' onchange=\"selectUploadPhoto(this);\" />";
		html += "</form>";
		appendHtml(document.body, html);
	}
	this._createUploadForm();
	
    this.clickeUpload = function() {
    	document.all.uploadFile.click();
    }
    
	//매물번호에 해당되는 사진의 수를 가져온다.
	//input *  매물번호(db/ 매물번호 : ROOM_PHOTO의 room_item_no)
	//process1 * 매물번호에 해당되는 사진을 찾음(db/ 매물번호 : ROOM_PHOTO의 room_item_no)
	//output 매물번호에 해당되는 사진 개수
	this.getRoomPhotoCount = function(room_no) {
		//등록된 사진의 개수를 가져온다.
		var room_cnt = 0;
		$.ajax({
			type : "GET",
			dataType : "json",
				url: "/api/room/photo_count?room_no="  + room_no,
				async: false,//필수 등록이전 방의 수를 확인하기위해 동기화시켜야함
				success: function(data) {
				room_cnt = data;
			},
		      error: function(jqXHR, textStatus, errorThrown) {
				room_cnt = 9999;//에러시에 방사진 추가 못하도록 함
			}
		});
		return room_cnt;
	}

	//미리보기 섬네일  
	this.setPreviewInImg = function(img_tag_id) {
		var upload = document.getElementById(this.input_id);
		var holder = document.getElementById(img_tag_id);
		var file = upload.files[0], reader = new FileReader();
		reader.onload = function(event) {
			var img = new Image();
			img.src = event.target.result;
			holder.src = reader.result;
		};
		reader.readAsDataURL(file);
	}
}*/

//사진을 가져옴
function getRoomPhoto(room_no){
	var return_data ='';
	jQuery.ajax({
		type : "GET",
		dataType : "json",
		url : "/api/room/photo?room_no="+ room_no,
		async : false,//총 검색개수를 받아온 이후 다음 절차수행, 반드시 동기 false로
		success : function(data) {//msg를 받는 것이 성공하면
			return_data  = data.photoList;
		},
		error : function(xhr, status, error) {
		}
	});
	return return_data;
}