<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.io.*, java.net.*, java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<sec:authentication var="principal" property="principal"/>
     <!-- 필터추가 단추를 누를경우  filter_opened 클래스추가-->
     <div class="sidebar">
          <div class="sidebar_inner">
              <!--div class="sidebar filter_opened"-->
              <div class="side_header">
                <p class="count">
                  <strong id="search_type_name"></strong>
                  <strong id ="allSearchCount">총 0개</strong>
                </p>
                <!--div class="sort opened" 소트목록 오픈된상태-->
                <div class="sort">
                  <a href="#sort_list" class="sort_title" id ="sort_title" onclick ="sortBtnStateChange(); return false;" >방정렬</a>
                  <!--.sort_title 클릭되면 #sort_list 토클-->
                  <div id="sort_list" class="dropdown">
                    <ul class="drop_item">
                      <li>
                        <a href="#" onclick="sortSearch('date_desc'); return false;"><span>최신등록순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('main_address, sub_address'); return false;"><span>번지수 오름차순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('stand_doposit_desc'); return false;"><span>기준가 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('stand_doposit_asc'); return false;"><span>기준가 낮은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('monthly_rent_desc'); return false;"><span>월세 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('monthly_rent_asc'); return false;"><span>월세 낮은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('deposit_desc'); return false;"><span>보증금 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('deposit_asc'); return false;"><span>보증금 낮은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('exclusive_area_desc'); return false;"><span>전용면적 높은 순</span></a>
                      </li>
                      <li>
                        <a href="#" onclick="sortSearch('exclusive_area_asc'); return false;"><span>전용면적 낮은 순</span></a>
                      </li>
                    </ul>
                  </div><!--sort_item마감-->
                </div><!--sort_list마감-->
              </div><!--side_heade마감r-->
              <div class="filter ">
                <div class="filter_section">
                  <!--거래종류-->
                  <div class="row intro_filter">
                    <div>
                      <div class="filter_label">
                        <label >거래종류</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col3 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                전체
                              </span>
                              <span class="input">
                                <input type="checkbox" checked ="checked"  id ="all_type" onclick ="checkBoxAllTradeType()"/>
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col3 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                매매
                              </span>
                              <span class="input">
                                <input type="checkbox"  name ="trade_type"  id ="trade" onclick ="checkBoxTradeType()"/>
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col3 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                전세
                              </span>
                              <span class="input">
                                <input type="checkbox"  name ="trade_type"  id ="charter" onclick ="checkBoxTradeType()"/>
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col3 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                전월세
                              </span>
                              <span class="input">
                                <input type="checkbox"  name ="trade_type"  id="monthly_and_charter" onclick ="checkBoxTradeType()" />
                              </span> </label>
                          </div>
                        </div>
                       <div class="filter_item col3 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                월세
                              </span>
                              <span class="input">
                                <input type="checkbox"  name ="trade_type"  id="monthly" onclick ="checkBoxTradeType()"/>
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col3 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                단기임대
                              </span>
                              <span class="input">
                                <input type="checkbox"  name ="trade_type"  id="short_lease" onclick ="checkBoxTradeType()" />
                              </span> </label>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div><!--row intro_filter 거래종류마감-->
                  <!--보증금-->
                  <div class="row intro_filter">
                    <div >
                      <div class="filter_label">
                        <label >보증금</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <div class="input">
                              <span>
                                <input type="text" id="depositmin" placeholder="보증금최소가" />
                              </span>
                            </div>
                            <div class="txt">
                              ~
                            </div>
                          </div>
                        </div>
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <div class="input">
                              <span>
                                <input type="text" id="depositmax" placeholder="보증금최고가"/>
                              </span>
                            </div>
                            <div class="txt">
                              만원
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 보증금row intro_filter마감-->
                  <!--월세-->
                  <div class="row intro_filter">
                    <div>
                      <div class="filter_label">
                        <label >월세</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="monthmin" class="blind">월세최소</label>
                            <div class="input">
                              <span>
                                <input type="text" id="monthmin" placeholder="월세최소가" />
                              </span>
                            </div>
                            <div class="txt">
                              ~
                            </div>
                          </div>
                        </div>
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="monthmax" class="blind">월세최고</label>
                            <div class="input">
                              <span>
                                <input type="text" id="monthmax" placeholder="월세최고가"/>
                              </span>
                            </div>
                            <div class="txt">
                              만원
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 월세  row intro_filter마감-->
                  <!--전세가-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >전세가</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="leasemin" class="blind">전세최소</label>
                            <div class="input">
                              <span>
                                <input type="text" id="chartermin"  placeholder="전세최소가" />
                              </span>
                            </div>
                            <div class="txt">
                              ~
                            </div>
                          </div>
                        </div>
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="leasemax" class="blind">전세최고</label>
                            <div class="input">
                              <span>
                                <input type="text" id="chartermax"  placeholder="전세최고가"/>
                              </span>
                            </div>
                            <div class="txt">
                              만원
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 전세가 row intro_filter마감-->
                  <!--기준가-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >기준가</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="standardmin" class="blind">기준가최소</label>
                            <div class="input">
                              <span>
                                <input type="text" id="standardmin"  placeholder="기준최소가" />
                              </span>
                            </div>
                            <div class="txt">
                              ~
                            </div>
                          </div>
                        </div>
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="standardmax" class="blind">기준가최고</label>
                            <div class="input">
                              <span>
                                <input type="text" id="standardmax"  placeholder="기준최고가"/>
                              </span>
                            </div>
                            <div class="txt">
                              만원
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 기준가 row intro_filter마감-->
                  <!--건물종류-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >건물종류</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                전체
                              </span>
                              <span  class="input">
                                <input type="checkbox" checked ="checked" onclick="checkBoxAllBuildingType()" id="all_building_type"/>
                              </span> </label>
                          </div>
                        </div>
                       <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span  class="txt">
                               아파트
                              </span>
                              <span class="input">
                                <input type="checkbox"   name="building_type" onclick="checkBoxBuildingType()" id="apartment" />
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                오피스텔
                              </span>
                              <span class="input">
                                <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="officetel"  />
                              </span> </label>
                          </div>
                        </div>
                       <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                주택
                              </span>
                              <span class="input">
                                <input type="checkbox"   name="building_type"  onclick="checkBoxBuildingType()" id="house" />
                              </span> </label>
                          </div>
                        </div>
                       <div class="filter_item col4 sm_col2 panel check" style ="display:none">
                          <div class="inner">
                            <label >
                              <span  class="txt">
                                원룸
                              </span>
                              <span class="input">
                                <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()"  id="normal_room" />
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span  class="txt">
                                상가
                              </span>
                              <span class="input">
                                <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id= "shop" />
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span class="txt">
                                사무실
                              </span>
                              <span class="input">
                                <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="office" />
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span  class="txt">
                                건물
                                </span>
                              <span class="input">
                                <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()" id="building"  />
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span  class="txt">
                                재개발
                                </span>
                              <span class="input">
                                <input type="checkbox"   name="building_type"  onclick="checkBoxBuildingType()" id="redevelopment" />
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 panel check">
                          <div class="inner">
                            <label >
                              <span  class="txt">
                                이벤트
                                </span>
                              <span class="input">
                                <input type="checkbox"  name="building_type"  onclick="checkBoxBuildingType()"  id="event" />
                              </span> </label>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 건물종류 row intro_filter마감-->
                  <!--준공년도-->
                  <div class="row col2">
                    <div class="odd">
                      <div class="filter_label">
                        <label >준공년도</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col select">
                          <div class="inner">
                            <label for="built" class="blind">준공년도</label>
                            <div class="input">
                              <span>
                                <select id="built">
                                  <option>전체</option>
									<c:forEach var="i" begin="2000" end="2015">
                                  		<option value ="${ i }">${ i } 이전</option>
									</c:forEach>
                                </select> </span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div><!-- 준공년도 row intro_filter마감-->
                  <!--번지-->
                  <div class="row col2">
                    <div class="even">
                      <div class="filter_label">
                        <label >번지</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col text">
                          <div class="inner">
                            <label for="address" class="blind">번지</label>
                            <div class="input no_txt">
                              <span>
                                <input type="text"  id="address"  placeholder="예)123-45"/>
                              </span>
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 번지 row intro_filter마감-->
                  <!--룸개수-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >룸종류</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" onclick ="checkRoomType()" id=all_room_type checked="checked"/>
                              </span>
                              <span class="txt">
                                상관없음   
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox" name ="room_type" id="open_room" onclick ="checkAnyRoomType()" />
                              </span>
                              <span class="txt">
                                오픈형
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox"  name ="room_type"  id="part_room" onclick ="checkAnyRoomType()"/>
                              </span>
                              <span  class="txt">
                                분리형
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox"   name ="room_type"  id="duplex_room" onclick ="checkAnyRoomType()"/>
                              </span>
                              <span class="txt">
                                복층형
                              </span> </label>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div><!-- 룸개수 row intro_filter마감-->
                  <!--룸종류-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >룸개수</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col4  sm_col2 check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox" onclick="checkRoomNum()" id=all_room_count checked="checked"/>
                              </span>
                              <span class="txt">
                                상관없음    
                              </span> </label>
                          </div> 
                        </div>
                        <div class="filter_item col4  sm_col2 check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox" name="room_num" id= "one_room"  onclick="checkAnyRoomNum()" />
                              </span>
                              <span class="txt">
                                원룸
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4  sm_col2 check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox" name="room_num" id= "two_room"  onclick="checkAnyRoomNum()" />
                              </span>
                              <span class="txt">
                                투룸
                              </span> </label>
                          </div>
                        </div>
                       <div class="filter_item col4  sm_col2 check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox" name="room_num" id = "three_room"  onclick="checkAnyRoomNum()" />
                              </span>
                              <span class="txt">
                                쓰리룸+
                              </span> </label>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div><!-- 룸종류 row intro_filter마감-->
                  <!--층수-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >층수</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col5  sm_col3  check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox"  onclick="checkRoomPosition()" id="all_room_position" checked="checked"/>
                              </span>
                              <span class="txt">
                                상관없음 
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5  sm_col3  check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox"  name ="room_position"  id="up_ground" onclick="checkAnyRoomPosition()" />
                              </span>
                              <span class="txt">
                                지상
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5  sm_col3  check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox" name ="room_position" id="under_ground" onclick="checkAnyRoomPosition()" />
                              </span>
                              <span class="txt">
                                지하
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5  sm_col3  check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox"  name ="room_position"  id="semi_basement"  onclick="checkAnyRoomPosition()" />
                              </span>
                              <span class="txt">
                                반지하
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5  sm_col3  check">
                          <div class="inner">
                            <label >
                              <span class="input">
                                <input type="checkbox"  name ="room_position"  id="rooftop" onclick="checkAnyRoomPosition()"/>
                              </span>
                              <span class="txt">
                                옥탑방
                              </span> </label>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div>
                  <!-- 층수 row intro_filter마감-->
                  <!--공급면적-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >공급면적</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="area1min" class="blind">공급면적최소</label>
                            <div class="input">
                              <span>
                                <input type="text" id="leased_area_min"  placeholder="공급면적최소" />
                              </span>
                            </div>
                            <div class="txt">
                              ~
                            </div>
                          </div>
                        </div>
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="area1max" class="blind">공급면적최고</label>
                            <div class="input">
                              <span>
                                <input type="text" id="leased_area_max"  placeholder="공급면적최고"/>
                              </span>
                            </div>
                            <div class="txt">
                              m&sup2;
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 공급면적 row intro_filter마감-->
                  <!--전용면적-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >전용면적</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="area2min" class="blind">전용면적최소</label>
                            <div class="input">
                              <span>
                                <input type="text" id="exclusive_area_min"  placeholder="전용면적최소" />
                              </span>
                            </div>
                            <div class="txt">
                              ~
                            </div>
                          </div>
                        </div>
                        <div class="filter_item col2 text">
                          <div class="inner">
                            <label for="area2max" class="blind">전용면적최고</label>
                            <div class="input">
                              <span>
                                <input type="text" id="exclusive_area_max"  placeholder="전용면적최고"/>
                              </span>
                            </div>
                            <div class="txt">
                              m&sup2;
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>
                  </div><!-- 전용면적 row intro_filter마감-->
                  <!--옵션-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >옵션</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id="full_option_room"/>
                              </span>
                              <span class="txt">
                                풀옵션
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id="airconditioner"/>
                              </span>
                              <span class="txt">
                                에어컨
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                       <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="refrigerator"/>
                              </span>
                              <span class="txt">
                               냉장고
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                       <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="washer"/>
                              </span>
                              <span class="txt">
                                세탁기
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="tv"/>
                              </span>
                              <span class="txt">
                                TV
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="microwave"/>
                              </span>
                              <span class="txt">
                                전자레인지
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="induction"/>
                              </span>
                              <span class="txt">
                                인덕션
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="sink"/>
                              </span>
                              <span class="txt">
                                싱크대
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                      <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="gasrange"/>
                              </span>
                              <span class="txt">
                                가스레인지
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="sofa"/>
                              </span>
                              <span class="txt">
                                소파
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                       <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="bed"/>
                              </span>
                              <span class="txt">
                                침대
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="built_in_closet"/>
                              </span>
                              <span class="txt">
                                붙박이장
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="dressing_table"/>
                              </span>
                              <span class="txt">
                                화장대
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox"  name="inside_option" id ="veranda"/>
                              </span>
                              <span class="txt">
                               베란다
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="inside_option" id ="shoe_closet"/>
                              </span>
                              <span class="txt">
                               신발장
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                      </div>
                    </div>
                  </div><!--옵션 row intro_filter마감-->
                  <!--현관보안-->
                  <div class="row">
                    <div>
                      <div class="filter_label">
                        <label >보안시설</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" checked ="checked"  onclick="checkAllSecurityType()" id ="all_security" />
                              </span>
                              <span class="txt">
                                전체
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox" name="security_type"  onclick="checkSecurityType()"  id="door_security"/>
                              </span>
                              <span class="txt">
                                현관보안
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox"  name="security_type"  onclick="checkSecurityType()"  id ="cctv"/>
                              </span>
                              <span class="txt">
                               CCTV
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        <div class="filter_item col4 sm_col2 check">
                          <div class="inner">
                            <label >
                              <span  class="input">
                                <input type="checkbox"  name="security_type"  onclick="checkSecurityType()"  id ="number_key"/>
                              </span>
                              <span class="txt">
                                번호키
                              </span> </label>
                          </div>
                        </div><!--filter_item마감-->
                        
                      </div>
                    </div>
                  </div><!--현관보안 row intro_filter마감-->
                  <!--추가사항-->
                  <div class="row ">
                    <div>
                      <div class="filter_label">
                        <label >추가사항</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label  class="longtext">
                              <span class="input">
                                <input type="checkbox" name ="add_option" id="elevator"/>
                              </span>
                              <span class="txt">
                                엘리베이터
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label  >
                              <span class="input">
                                <input type="checkbox" name ="add_option" id ="parking"/>
                              </span>
                              <span class="txt">
                                주차가능
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label  >
                              <span class="input">
                                <input type="checkbox" name ="add_option" id="animal"/>
                              </span>
                              <span class="txt">
                                반려동물
                              </span> </label>
                          </div>
                        </div>
                      <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label  >
                              <span class="input">
                                <input type="checkbox" name ="add_option" id="empty"/>
                              </span>
                              <span class="txt">
                                공실
                              </span> </label>
                          </div>
                        </div>
                        <div class="filter_item col5 sm_col3 check">
                          <div class="inner">
                            <label  >
                              <span class="input">
                                <input type="checkbox" name ="add_option" id="sale"/>
                              </span>
                              <span class="txt">
                                매물
                              </span> </label>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div><!--추가사항 row intro_filter마감-->
                  <div class="row filter_last">
                    <div>
                      <div class="filter_label">
                        <label >사진 및 영상</label>
                      </div>
                      <div class="filter_group">
                        <div class="filter_item col4 sm_col2 radio">
                          <div class="inner">
                            <label  class="longtext">
                              <span  class="input">
                                <input type="radio" name="pic" id="pic_keep"/>
                              </span>
                              <span  class="txt">
                                사진있음
                              </span> </label>
                          </div>
                        </div>
                         <div class="filter_item col4 sm_col2 radio">
                          <div class="inner">
                            <label  class="longtext">
                              <span  class="input">
                                <input type="radio" name="pic" id="pic_none" />
                              </span>
                              <span  class="txt">
                                사진없음
                              </span> </label>
                          </div>
                        </div>
                         <div class="filter_item col4 sm_col2 radio">
                          <div class="inner">
                            <label  class="longtext">
                              <span  class="input">
                                <input type="radio"  name="movie" id="movie_keep"/>
                              </span>
                              <span  class="txt">
                                영상있음
                              </span> </label>
                          </div>
                        </div>
                         <div class="filter_item col4 sm_col2 radio">
                          <div class="inner">
                            <label  class="longtext">
                              <span  class="input">
                                <input type="radio"  name="movie" id="movie_none"/>
                              </span>
                              <span  class="txt">
                                영상없음
                              </span> </label>
                        </div>
                        
                        
                      </div>
                    </div>
                  </div>
                  <div class="row filter_footer ">
                    <div>
                      <div class="filter_group button">
                        <div class="reset btn">
                          <button type="reset" onclick= "searchExceptDetail()">
                            <span>초기화</span>
                          </button>
                        </div>
                        <div class="submit  btn">
                          <button type="submit" onclick ="searchDetail()">
                            <span>필터적용</span>
                          </button>
                        </div>
                      </div><!-- filter_group마감-->
                    </div>
                  </div><!-- row filter_footer마감-->
                </div><!-- filter_section마감-->
              </div><!-- 필터마감-->
              <!--filter_app-->
              <div class="filter_app" id="filter_app">
                <button class="btn open_btn">
                  <span>검색필터설정</span>
                </button>
                <ul class="applied_filter">
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_trade')" id ="filter_trade">
                   	 거래종류<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_deposit')" id ="filter_deposit">
                  	  보증금<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_month')" id ="filter_month">
                   	 월세<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_charter')" id ="filter_charter">
                   	 전세가<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_standard')" id ="filter_standard">
                   	 기준가<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_building_type')" id ="filter_building_type">
                   	 건물종류<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_built_year')" id ="filter_built_year">
                  	  준공년도<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_address')" id ="filter_address">
                   	 번지<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_room_type')" id ="filter_room_type">
                   	 룸종류<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_room_num')" id ="filter_room_num">
                   	 룸개수<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_room_position')" id ="filter_room_position">
                 	   층수<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_leased_area')" id ="filter_leased_area">
                   	 공급면적<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_exclusive_area')" id ="filter_exclusive_area">
                   	 전용면적<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_inside_option')" id ="filter_inside_option">
                  	  옵션<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_security')" id ="filter_security">
                    	보안<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_add_option')" id ="filter_add_option">
                   	 추가사항<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_pic')" id ="filter_pic">
                   	 사진<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                  <li class="btn f_name hide" onclick ="searchExceptFilterBox('filter_movie')" id ="filter_movie">
                 	   동영상<i class="remove"><span class="blind">필터제거</span></i>
                  </li>
                </ul>
              </div><!-- filter_app마감-->
              
             <!--s_result-->
             <div class="filter_app">
				 <%-- <sec:authorize access="hasRole('ROLE_AGENT')">
		              <button class="btn"  onclick ="printRoom()">
		                  <span>인쇄출력</span>
		              </button>
	              </sec:authorize> --%>
                  </div>
		              <div class="s_result">
		                <div class="page_wrap">
		                <p class="paging" id ="paging">
		                <a href="#" onClick="posChangeSubmit('pre'); return false;" class="bor" id="pre_page"><span class="blind">이전</span>&lt;</a>
		                   <a href="#" onClick="posChangeSubmit('pos1'); return false;" class="current" id ="pos1">1</a>
		                   <a href="#" onClick="posChangeSubmit('pos2'); return false;" id ="pos2">2</a>
		                   <a href="#" onClick="posChangeSubmit('pos3'); return false;" id ="pos3">3</a>
		                   <a href="#" onClick="posChangeSubmit('pos4'); return false;" id ="pos4">4</a>
		                   <a href="#" onClick="posChangeSubmit('pos5'); return false;" id ="pos5">5</a>
		                   <a href="#" onClick="posChangeSubmit('next'); return false;" class="bor" id="next_page"><span class="blind">다음</span>&gt;</a>
		                </p>
		              </div><!--page_wrap마감 -->
	              </div><!--s_result마감-->
	          </div><!--sidebar_inner-->
               <!--m_filter_btn 클릭시 -->
	          <div class="m_filter_btn">
	              <div class="inner">
	                <button>검색필터</button>
	              </div>
	          </div><!--ㅡm_filter_btn마감-->
	     </div><!--sidebar마감-->
	</div>
	<div class="btn_agent_cart">
		<sec:authorize access="hasRole('ROLE_AGENT')">
			<a href="#agent_cart" title="관심매물창보기"> <span class="blind">관심매물메뉴</span></a>
		</sec:authorize>
	</div>
	
<script>
	searchUrl='';//검색 메인 url(지도위치/ 매물번호/ 지하철번호의 정보포함)
	beforeSearchUrl = '';//이전 검색 메인 url(지도위치/ 매물번호/ 지하철번호의 정보포함)
	filterUrl='';//상세검색 필터적용
	sortUrl = '';//정렬
	var location_type='';//표시될 지도 검색 기준(지역명, 지하철역이름)
	var location_name='';//표시될 지도 위치
	$(document).ready(function() {
		//검색
		beforeSearchUrl = searchUrl;
		searchUrl = "${url}";
		if(searchUrl ==''){//기본: 강남구 범위검색
			beforeSearchUrl = searchUrl;
			searchUrl = "/api/search/geo?s="+37.45049693760036 +"&w="+126.98951220288383 +"&n="+ 37.57353330485798+"&e="+ 127.13511634995348;
			expressMap("allLocation" , "");
		}
		setSectionCount();
		posChangeSubmit(1);
		
		//지도이동
		location_type = "${location_type}";
		location_name = "${location_name}";
		if(location_type == 'metro'){
			expressMap('metro' , location_name);
		}else if(location_type == 'local'){
			expressMap('local' , location_name);
		}else if(location_type == 'integration'){//통합검색 종류에 맞게 출력
			searchIntegrationAboutWord(location_name);
		}
		showLocal();//검색한 지역의 지역명 표시
	});
	
	//*******************************paging***************************
	var currentPg = 1;
	var currentBlock =0; 
	var nextPage = false;
	function setCurrentPage(pos){
		//currentBlock값 변경 
		if(pos == 'pre'){
			if(0 < currentBlock){
				currentBlock--;
				currentPg = (currentBlock)*5 + 1;
			}
			pos = 'pos1';
		} else if(pos == 'next'){
			currentBlock++;
			currentPg = currentBlock*5 + 1;
			pos = 'pos1';
		}
		//currentpg 값 변경
		if(pos == 'pos1' || pos == 'pos2' || 
				pos == 'pos3' || pos == 'pos4' || 
					pos == 'pos5' ){//페이지 버튼으로 페이지 변경시
			$("#"+pos).addClass("current");//현재 페이지 클릭표시 설정
			currentPg = currentBlock*5 + pos.substring(3)*1;//block를 통해 상대적으로 페이지를 구함
		}else{//원하는 페이지를 숫자로 입력받으면
			currentPg = pos;
			currentBlock = (pos-1)/5;
		}
	}
	var all_count = 0;
	function setPageIndex(currentBlock){
		 //이전 화살표 표시 설정
	 	 var pre_page = document.getElementById("pre_page");  
	 	 pre_page.style.display = 'none';  
		 if(0 < currentBlock){//이전 화살표를 표시해야되면
			   pre_page.style.display = 'inline-block';  
		 }
		 //페이지 버튼 페이지값 셋팅
		 $("#pos1").text(currentBlock*5 + 1);
		 $("#pos2").text(currentBlock*5 + 2);
		 $("#pos3").text(currentBlock*5 + 3);
		 $("#pos4").text(currentBlock*5 + 4);
		 $("#pos5").text(currentBlock*5 + 5);
	 	 var pos1 = document.getElementById("pos1"); 
	 	 var pos2 = document.getElementById("pos2");  
	 	 var pos3 = document.getElementById("pos3");  
	 	 var pos4 = document.getElementById("pos4");  
	 	 var pos5 = document.getElementById("pos5"); 
		 pos1.style.display ='none';  
		 pos2.style.display ='none';   
		 pos3.style.display ='none';  
		 pos4.style.display ='none';   
		 pos5.style.display ='none';  
		 if(currentBlock*10*5 + 10*0 < all_count)//page 1을  표시해야되면
			 pos1.style.display ='inline-block';  
		 if(currentBlock*10*5 + 10*1 < all_count)//page 2을  표시해야되면
			 pos2.style.display ='inline-block'; 
		 if(currentBlock*10*5 + 10*2 < all_count)//page 3을  표시해야되면
			 pos3.style.display ='inline-block';  
		 if(currentBlock*10*5 + 10*3 < all_count)//page 4을  표시해야되면
			 pos4.style.display ='inline-block';  
		 if(currentBlock*10*5 + 10*4 < all_count)//page 5을  표시해야되면
			 pos5.style.display ='inline-block';   
		 
		 //페이지 클릭 초기화
		 $("#pos1").removeClass("current");
		 $("#pos2").removeClass("current");
		 $("#pos3").removeClass("current");
		 $("#pos4").removeClass("current");
		 $("#pos5").removeClass("current");
		 //현재 페이지 클릭표시 설정
		 $("#pos"+ ((currentPg-1)%5 + 1)).addClass("current");
		 //다음 화살표 표시 설정
		 var next_page = document.getElementById("next_page");  
	     next_page.style.display = 'none'; 
		 if((currentBlock+1)*10*5 < all_count){//다음 화살표를 표시해야되면
		      next_page.style.display = 'inline-block';  
		 }
	}
	
	//******************검색할 페이지로 페이지상태를 변경하고 검색******************
	function posChangeSubmit(pos){
		//alert(searchUrl + "/"+filterUrl + "/"+sortUrl);
		setFilterUrl();
		setCurrentPage(pos);//현재페이지 설정
		search(searchUrl + filterUrl + sortUrl, currentPg);
		setPageIndex(currentBlock);//페이지 인덱스 표시 설정 (이전, 1 ~ 5 ,다음 버튼)
	}
	
	//**********************검색할 페이지와 url을 통해 방 검색************
	var specific_room_item ='';//검색된 매물들의 정보를 가짐
	function search(url, pg){
		setInfor(null);//정보지우기
		threadSleep(200,100,1);//0.1초 스레드 지연 (검색시 깜빡임 표시)
		jQuery.ajax({
			type : "GET",
			dataType : "json",
			url : url+"&pg=" + pg,
			async : false,//총 개수를 가져온 이후 다른 처리를 해야함, 반드시 false
			success : function(data) {//msg를 받는 것이 성공하면
				threadBreak(1);//0.1초 지연이 완료됐으면
				setInfor(data);//검색된 정보 출력
				specific_room_item = data.roomList;
				all_count = data.allSearchCount;
			},
			error : function(xhr, status, error) {
			}
		});
	}
	
	//***********************검색한 데이터를 뷰에 세팅******************
	function setInfor(data){ 
		if(data == null || data == ''){
			$(".row.col2.odd").empty();
			return;
		}
	
		//프린트할 데이터
		address_pre_print =[];
		address_post_print =[];
		room_print=[];
		contact1_print=[];
		who1_print=[];
		contact2_print=[];
		who2_print=[];
		contact3_print=[];
		who3_print=[];
		room_price = [];
		var address_pre_print_str='';
		var address_post_print_str='';
		
/* 		//마커표시할 데이터 초기화
		marker_address = [];//상세주소를 제외한 모든주소
		marker_detail_address = [];//상세주소
		markerLat = [];
		markerLng = []; */
	
		//뷰 설정데이터
		var str;
		$(".row.col2.odd").empty();
		str ="";
		//뷰설정
		for(var a= 0; a < data.roomList.length ; a++){
			var  infor = data.roomList[a];
			
			//주소값 설정
			var  gungu_dong =  data.roomList[a].gungu +' ' + data.roomList[a].dong;

			var  detail_address ="";
			if(infor.main_address != 0)
				detail_address += infor.main_address;
			if(infor.sub_address != 0)
				detail_address += "-" + infor.sub_address;
			if(infor.last_address != "")
				detail_address += " " + infor.last_address;
 			if(infor.main_address == 0 && infor.sub_address == 0 && infor.last_address == "")
 				detail_address+= " " + "기기인증 필요";
 			
		    //방위치 설정
		    var kind;
			if(infor.rooftop == 1)
				kind = '옥탑방' ;
			else if (infor.semi_basement == 1)
				kind = '반지하' ;
			else if (infor.floor_no < 0)
				kind = '지하' ;
			else if (infor.floor_no > 0)
				kind = "("+infor.floor_no + "층 /" +infor.all_floor+"층)";
		    
		    //매물번호설정
			var no =  infor.no;

		    //거래 종류 설정
			var type ='';
		    if(0 != (infor.type&1)) 
		    	type +='매매,';
		    if((infor.type&2) != 0  && (infor.type&4) != 0)
		    	type +='전월세,';
		    if((infor.type&2) != 0)
		    	type +='전세,';
		    if((infor.type&4) != 0)
		    	type +='월세,';
		    if((infor.type&8) != 0)
			    type +='단기임대,';

		    //전세/월세/임대에 따라 거래가 설정
			//1매매/2전세/4월세/6전월세/8단기임대
		    var charter_deposit =  commaMoney(infor.charter_deposit);// 전세가
		    var sale_price = commaMoney(infor.sale_price);//매매가
			var deposit= commaMoney(infor.deposit);// 보증금
			var monthly_rent= commaMoney(infor.monthly_rent);//월세
			var maintenance_cost = infor.maintenance_cost/10000;
			maintenance_cost= commaMoney(maintenance_cost);//관리비
			var deposit_modify= commaMoney(infor.deposit_modify);//보증금협의가능
			var trade_price ='';
			if((infor.type&1) != 0){//매매이면
				//매매가표시
				trade_price = "<span class=\"deposit\"> "+ sale_price + "</span>";
			}
			if((infor.type&2) != 0  && (infor.type&4) != 0){//전월세 이면
				//전세,보증금,월세,관리비 표시
				trade_price = "<span class=\"deposit\"> "+ charter_deposit + "</span>" + "<span class=\"bar\">/</span>";
				trade_price += ("<span class=\"month\">" + deposit);
				if(deposit_modify == 1)
					trade_price += "(협의가능)";
				trade_price += ("/" + monthly_rent);
				trade_price += ("/" + maintenance_cost+ "</span>");
			}
			else if((infor.type&2) != 0){//전세이면(전월세에 포함)
				//전세가/관리비 표시
				trade_price = "<span class=\"deposit\"> "+ charter_deposit + "/" + maintenance_cost + "</span>";
			}
			else if((infor.type&4) != 0){//월세이면(전월세에 포함)
				//보증금/월세/관리비 표시
				trade_price = "<span class=\"deposit\"> "+ deposit + "</span>"+
				"<span class=\"bar\">/</span>"+
				"<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost  + "</span>";
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
			}else if((infor.type&8) != 0){//단기임대이면(전월세, 월세에 포함)
				//보증금/월세 /관리비 표시
				trade_price = "<span class=\"deposit\"> "+ deposit + "</span>"+
				"<span class=\"bar\">/</span>"+
				"<span class=\"month\">" +  monthly_rent + "/" + maintenance_cost  +"</span>";
				if(deposit_modify == 1)
					trade_price += "(보증급 협의가능)";
			}
			
		    //추천 및 급 설정
			var recommend ="";
 			if(infor.recommend == 1){
				recommend += "    <p class=\"recommend on\" >";
				recommend += "      <!--추천매물일때 클래스 on추가-->";
				recommend += "      <span class=\"txt\">추천</span>";
				recommend += "     </p>";
			}	
 			var urgent_sale ="";
 			if(infor.urgent_sale == 1){
 				urgent_sale += "     <p class=\"urgent  on\">";
 			    urgent_sale += "       <!--급매물일때 클래스 on추가-->";
 			    urgent_sale += "<span class=\"txt\">급</span>";
 			    urgent_sale += "     </p>";
			}
 			
 			var zzim ='';
 			if(infor.zzim_no != 0)
 	 			zzim += "<div class=\"fav fav_check\" id=\"zzim"+a+"\">";
 	 		else
 	 	 		zzim += "<div class=\"fav\" id=\"zzim"+a+"\">";
 			zzim += "  <!--찜하기를 선택했을때  fav_check 클래스 추가-->";
 			zzim += "	<p class=\"btn_fav_check\"  onclick =\"delZzim("+no+" , "+a+")\">";
 			zzim += "    	<span class=\"blind\" >찜하기</span>";
 			zzim += "    </p>";
 			zzim += "    <p class=\"btn_fav_uncheck\"   onclick =\"addZzim("+no+", "+a+")\">";
 			zzim += "    	 <span class=\"blind\" >찜하기취소</span>";
 			zzim += "    </p>";
 			zzim += "</div><!-- fav마감-->";
 			
 			//옵션 첫번빼 설정 
			var option1 = "";
 			if(infor.elevator == 1)
 				option1 += "<span>엘리베이터</span>  ";
 			if(infor.parking)
 				option1 += "<span>주차가능</span> ";
 			if(infor.empty == 1)
 				option1 += "<span>공실</span>";
 			if(infor.animal == 1)
 				option1 += "<span>반려동물</span> ";
 			if(infor.digital_doorlock == 1)
 				option1 += "<span>현관도어락</span>  ";
 			if(infor.veranda == 1)
 				option1 += "<span>베란다</span>  ";
 			if(infor.room_type == 1)
 				option1 += "<span>오픈형</span>  ";
 			else if(infor.room_type == 2)
 		 		option1 += "<span>분리형</span>  ";
 	 		else if(infor.room_type == 3)
 	 		 	option1 += "<span>복층형</span>  ";
 	 		else if(infor.room_type == 4)
 	 		 	option1 += "<span>사무용</span>  ";
 	 		else if(infor.room_type == 5)
 	 		 	option1 += "<span>주거용</span>  ";
 	 	 	else if(infor.room_type == 6)
 	 	 		 option1 += "<span>일부층사용</span>  ";
 	 	 	else if(infor.room_type == 7)
 	 	 	 	option1 += "<span>전층사용</span>  ";
			else if(infor.room_type == 8)
 	 	 	 	 option1 += "<span>원룸원거실</span>  ";
 	 	 	else if(infor.room_type == 9)
 	 	 	 	 option1 += "<span>세미분리</span>  ";	 
 			if(option1 == '')
 				option1 = "<span>옵션 해당사항 없음</span>";
			//옵션 두번째 설정
 			/* var option2="";
 			if(infor.airconditioner == 1)
 				option2 += "<span>에어컨,</span>  ";
 			if(infor.refrigerator == 1)
 	 			option2 += "<span>냉장고,</span>  ";
 	 		if(infor.washer == 1)
 	 	 		option2 += "<span>세탁기,</span>  ";
 	 	 	if(infor.tv == 1)
 	 	 	 	option2 += "<span>tv,</span>  ";
 	 	  	if(infor.microwave == 1)
 	 	 	 	option2 += "<span>전자레인지,</span>  ";
 	 	 	if(infor.induction == 1)
 	 	 	 	option2 += "<span>인덕션,</span>  ";
 	 	 	if(infor.gasrange == 1)
 	 	 	 	option2 += "<gasrange>가스레인지,</span>  ";
 	 	 	if(infor.bed == 1)
 	 	 	 	 option2 += "<span>침대,</span>  "; 	
 	 	 	if(infor.built_in_closet == 1)
 	 	 	 	 option2 += "<span>붙박이장,</span>  "; 	 	
 	 		if(infor.closet == 1)
 	  	 	 	 option2 += "<span>옷장,</span>  "; 	 	
 	  		if(infor.dressing_table == 1)
 	  	  		 option2 += "<span>화장대,</span>  "; 	
			if(infor.other_option.indexOf("식탁") != -1)
				option2 +='식탁,';
			if(infor.other_option.indexOf("쇼파") != -1)
				option2 +='쇼파,';
			if(infor.other_option.indexOf("싱크대") != -1)
				option2 +='싱크대,';			
			if(option2 =='')
				option2 ='가구 해당사항 없음'; */
	 	 	 	
 			//방수 설정
 			var room_cnt = " ";
 			if(1 <= infor.room_count){
 				room_cnt = " " + infor.room_count + '룸';
 			}else if(infor.room_count_onepointfive == 1){
 				room_cnt = " " + '1.5룸';
 			}
 			
 			//건물형태 설정
 			var buildingType="";
 			if(infor.apartment == 1)
 				buildingType = "아파트";
 			else if(infor.officetel == 1)
 				buildingType = "오피스텔";
 			else if(infor.house == 1)
 				buildingType = "주택";
 			else if(infor.shop == 1)
 				buildingType = "상가";
 			else if(infor.office == 1)
 				buildingType = "사무실";
 			else if(infor.building == 1)
 				buildingType = "건물";
 			else if(infor.event == 1)
 				buildingType = "이벤트";
 			else if(infor.normal_room == 1)
 				buildingType = "원룸";
 			else if(infor.full_option_room == 1)
 				buildingType = "플옵션";
 			else if(infor.land == 1)
 				buildingType = "땅";
 			buildingType += room_cnt;

 			//매물  프린트할 데이터 확보
 			address_pre_print_str='';
 			address_post_print_str='';
 			address_pre_print_str+= infor.si+" ";// 시
 			address_pre_print_str+= infor.gungu+" ";// 군 또는 구
 			address_pre_print_str+= infor.dong+" ";// 동
			if(infor.main_address != 0)
 				address_pre_print_str+= infor.main_address;// 번지 처음
 			if(infor.sub_address != 0)
 				address_pre_print_str+= "-" + infor.sub_address;// 번지 마지막
 	 		if(infor.last_address != "")
 				address_post_print_str+= " " + infor.last_address+" ";// 기타주소
 				
 			address_post_print_str+= kind;//방위치
 			address_pre_print.push(address_pre_print_str);
 			address_post_print.push(address_post_print_str);
 			room_print.push(no);//매물번호
 			room_price.push(trade_price);//매물가격
			
			str += "<div class=\"row col2 odd\">";
			str += "<div class=\"row_inner shadow_gray\">";
			str += "  <div class=\"ribbon \">";
			str +=	recommend;
		    str += "   </div><!-- ribbon마감-->";
			str +=	urgent_sale;
			str += zzim;
	        str += "<div class=\"thum  image_list\">";
	        str += "   <div class=\"inner\">";
	        str += "    <ul class=\"thum_list\">";
	        str += "      <li>";
	        str += "<a href=\""+"/room/"+no+"\" target=\"_blank\"  onclick =\"clickRoomDetail("+no+");\" class=\"media_photo media_cover\" value =\""+no+"\">";
	        str += "        <div class=\"media_cover\">";
	        if (typeof(infor.fake_url[0]) == "undefined")//사진등록이 안되었으면 기본이미지로 설정
	            str += "<img src=\"" + "${pageContext.request.contextPath}/images/common/pic_base.jpg" +"\" alt=\"샘플집\" class=\"res_height\"/>";
	        else//사진등록이 됐으면 이미지의 첫번쨰로 대표이미지 설정
	        	str += "<img onerror=\"this.src='${pageContext.request.contextPath}/images/common/pic_base.jpg'\" src=\"" + "http://112.175.245.57"+infor.fake_url[0] +"\" alt=\"샘플집\" class=\"res_height\" />";
	        str += "          </div></a>";
			str += "        </li>";
	        str += "      </ul>";
	        str += "    </div><!-- inner마감-->";
	        str += " </div><!-- thum마감-->";
	        str += "      <div class=\"info_grounp\">";
	        str += "        <div class=\"inner\">";
	        str += "         <div class=\"info1 info\">";
	        str += "           <a href=\"#\">";
	        str += "            <p class=\"address  fl\">";
	        str += "            <span>" + gungu_dong + "</span>";
	        str += "           </p>";
	        str += "           <p class=\"floor fl\">";
	        str += 	 kind;
	        str += "          </p>";
	        str += "        </a>";
	        str += "     </div><!-- info1마감-->"; 
	        if(<%=request.isUserInRole("ROLE_AGENT") %>){//중개사, 일반,임대인로그인 경우만
		        str += "      <div class=\"info2 info\">";  
		        str += "      <p class=\"no fl\">";
		        str += "        	  <span class=\"txt\"> 상세주소: " + detail_address + "</span>";
		        str += "      </p>";
		        str += "      </div> <!-- info2마감-->";
	        }
	        str += "      <div class=\"info2 info\">";  
	        str += "         <a href=\"#\"><p class=\"no fl\">";
	        str += "        	  <span class=\"txt\">매물번호:</span><span class=\"num\">"+no+"</span>";
	        str += "        	</p></a>";
	        str += "      </div> <!-- info2마감-->";
	        str += "    <div class=\"info3 info\">";
	        str += "       <a href=\"#\"><p class=\"tradetype btn fl\">";
	        str += "      	  <span> " + type + "</span>";
	        str += "      	</p>";
	        str += "     	<p class=\"buldingtype btn fl\">";
	        str += "     	  <span>" + buildingType + "</span>";
	        str += "       	</p>";
	        str += "      	<p class=\"price fl\">";
	        str += trade_price;
	        str += "       	</p></a>";
	        str += " <!--agent_check 중개사만 표시 매물담기-->";
	   
	        if( <%=request.isUserInRole("ROLE_AGENT") %>){//중개사, 일반,임대인로그인 경우만 zzim여부표시 --%>
	   	        str += "     <div class=\"agent_check\">";
		        str += "       <div class=\"input\"><input type=\"checkbox\" value=\"" + no + "\" name=\"interest_room_no\" /> </div><!-- input마감-->";
		        str += "     </div><!-- agent_check마감-->";
			}
	        str += "     </div>";
	        str += "         <!-- info3마감-->";
	        str += "         <div class=\"info4 info\">";
	        str += "             <a href=\"#\" ><p class=\"option\">";
	        str +=   option1;
	        str += "          	</p></a>";
	        str += " </div><!-- info4마감-->";
	        str += "   <div class=\"info5 info\">";
	        str += "         <a href=\"#\"><p>";
	        str += "        	</p></a>";
	        str += "       </div><!-- info5마감-->";
	        str += "      </div><!-- inner마감-->";
	        str += "      </div><!-- info_group마감-->";
	        str += "      </div><!-- row_inner마감-->";
	        str += "      </div><!-- row col2 odd마감-->";
	        
			//임대인 연락처 인쇄용 데이터 저장
			contact1_print.push(infor.contact_phone_1);
			who1_print.push(infor.contact_who_1);
			contact2_print.push(infor.contact_phone_2);
			who2_print.push(infor.contact_who_2);
			contact3_print.push(infor.contact_phone_3);
			who3_print.push(infor.contact_who_3);
			
/* 			//지도에 보여 지는 마커 (클러스터된) 추가
			var marker_address_str ='';
			var marker_detail_address_str='';
			marker_address_str += ("매물번호:" + no + " <br>");
			marker_address_str += ("위치:" + infor.si+ " " + infor.gungu +" " +  infor.dong + " <br>");
			marker_address_str += ("번지:" + infor.main_address + "-" + infor.sub_address    + "<br>");
			marker_detail_address_str += ("상세주소:" + infor.last_address + " <br>");
			
			marker_address.push(marker_address_str);
			marker_detail_address.push(marker_detail_address_str);
 			markerLat.push(infor.lat);
 			markerLng.push(infor.lng); */
		}
		$(".s_result").prepend(str);
		
		$("#allSearchCount").text(data.allSearchCount+'개');
	}
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
</script>
<script>
//************************찜, 최근본방, 조회수**************************
	//찜추가
	function addZzim(no, row){
		if(!<%= request.isUserInRole("ROLE_ADMIN") || request.isUserInRole("ROLE_SUPER") || 
				request.isUserInRole("ROLE_AGENT") ||  request.isUserInRole("ROLE_USER")  
				|| request.isUserInRole("ROLE_LESSOR")%>){//중개사, 일반,임대인로그인 경우만 zzim여부표시
				alert('로그인이 필요합니다.');
				return;
		}
		$("#zzim"+row).addClass("fav_check");
	 	$.ajax({
			 	type : "PUT",
		        url: "/api/room/"+no+"/zzim",
		        async: false,
		        success: function() {
		        	//setComment(1);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		 }); 
	}
	//찜취소
	function delZzim(no, row){
		//alert(no);
		//alert(row);
		$("#zzim"+row).removeClass("fav_check");
		//alert('찜취소!');
	 	$.ajax({
			 	type : "DELETE",
		        url: "/api/room/"+no+"/zzim",
		        async: false,
		        success: function() {
		        	//setComment(4);
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		        }
		 }); 
	}
	//조회수를 하나 증가
	function increaseReadCnt(no){
		$.ajax({
			type : 'PUT',
			url : "/api/room/" + no + "/increaseReadCount",
			async : true,
			success : function() {
			},
			error : function(jqXHR, textStatus, errorThrown) {
			}
		});
	}
	//최근본방에 추가
	function insertRecently(no) {
		$.ajax({
			type : "POST",
			url : "/api/room/recently?room_no=" + no,
			async : true
		});
	}
	function clickRoomDetail(no){
		insertRecently(no);
		increaseReadCnt(no);
	}
</script>
<script>
//************************컴포넌트 상태변화*******************
	//방정렬 드롭다운 열기/닫기
	function sortBtnStateChange(){
		if($(".sort").hasClass("opened")) {
			 $(".sort").removeClass("opened");
		}else{
			 $(".sort").addClass("opened");	
			 document.getElementById("sort_title").innerHTML = "방정렬";
		}
	}
	//월세/전세/단기임대/전월게/매매 의 체크박스 전체선택 및 해제
	function checkBoxAllTradeType(){
		//거래종류 전체 체크 및 해제
		$("#all_type").prop("checked", true);
		$("#monthly").prop("checked", false);
		$("#monthly_and_charter").prop("checked", false);
		$("#charter").prop("checked", false);
		$("#trade").prop("checked", false);
		$("#short_lease").prop("checked", false);
	}
	//단일선택시 전체체크박스의 선택및 해제
	function checkBoxTradeType(){
		//단일선택시 전체체크박스 상태 변화
		if($("#monthly").is(":checked") 
			&& $("#monthly_and_charter").is(":checked")
			&& $("#charter").is(":checked")
			&& $("#trade").is(":checked")
			&& $("#short_lease").is(":checked")){//모든사항체크시
			$("#all_type").prop("checked", true);//전체선택체크
			$("#monthly").prop("checked", false);
			$("#monthly_and_charter").prop("checked", false);
			$("#charter").prop("checked", false);
			$("#trade").prop("checked", false);
			$("#short_lease").prop("checked", false);
		}else if (
				!$("#monthly").is(":checked") 
				&& !$("#monthly_and_charter").is(":checked") 
				&& !$("#charter").is(":checked") 
				&& !$("#trade").is(":checked") 
				&& !$("#short_lease").is(":checked") )
		{//체크가 전부안되어있으면 전체체크박스 체크
			$("#all_type").prop("checked", true);
		}else{
			$("#all_type").prop("checked", false);
		}
	}
	
	//아파트/오피스텔/주택/원룸/상가/사무실/건물/재개발/이벤트 의 체크박스 전체선택 및 해제
	function checkBoxAllBuildingType(){
			$("#all_building_type").prop("checked", true);
			$("#apartment").prop("checked", false);
			$("#officetel").prop("checked", false);
			$("#house").prop("checked", false);
			$("#normal_room").prop("checked", false);
			$("#shop").prop("checked", false);
			$("#office").prop("checked", false);
			$("#building").prop("checked", false);
			$("#redevelopment").prop("checked", false);
			$("#event").prop("checked", false);
	}
	//아파트/오피스텔/주택/원룸/상가/사무실/건물/재개발/이벤트 의 단일체크시 체크박스상태변화
	function checkBoxBuildingType(){
		if (
			$("#apartment").is(":checked") 
			&& $("#officetel").is(":checked") 
			&& $("#house").is(":checked") 
			&& $("#normal_room").is(":checked") 
			&& $("#shop").is(":checked") 
			&& $("#office").is(":checked") 
			&& $("#building").is(":checked") 
			&& $("#redevelopment").is(":checked") 
			&& $("#event").is(":checked")){//체크박스 모두체크시
			$("#all_building_type").prop("checked", true);
			$("#apartment").prop("checked", false);
			$("#officetel").prop("checked", false);
			$("#house").prop("checked", false);
			$("#normal_room").prop("checked", false);
			$("#shop").prop("checked", false);
			$("#office").prop("checked", false);
			$("#building").prop("checked", false);
			$("#redevelopment").prop("checked", false);
			$("#event").prop("checked", false);
		}else if (
				!$("#apartment").is(":checked") 
				&& !$("#officetel").is(":checked") 
				&& !$("#house").is(":checked") 
				&& !$("#normal_room").is(":checked") 
				&& !$("#shop").is(":checked") 
				&& !$("#office").is(":checked") 
				&& !$("#building").is(":checked") 
				&& !$("#redevelopment").is(":checked") 
				&& !$("#event").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_building_type").prop("checked", true);
		}else{
			$("#all_building_type").prop("checked", false);
		}
	}
	
	//현관보안/ 보안/ cctv 의 체크박스 전체선택 및 해제
	function checkAllSecurityType(){
		$("#all_security").prop("checked", true);
		$("#door_security").prop("checked", false);
		$("#cctv").prop("checked", false);
		$("#number_key").prop("checked", false);
	}
	//현관보안/ 보안/ cctv 의 체크박스 단일선택
	function checkSecurityType(){
		if (
			$("#door_security").is(":checked") 
			&& $("#cctv").is(":checked") 
			&& $("#number_key").is(":checked")){//체크박스 모두체크시
			$("#all_security").prop("checked", true);
			$("#door_security").prop("checked", false);
			$("#cctv").prop("checked", false);
			$("#number_key").prop("checked", false);
		}else if (
				!$("#door_security").is(":checked") 
				&& !$("#cctv").is(":checked") 
				&& !$("#number_key").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_security").prop("checked", true);
		}else{
			$("#all_security").prop("checked", false);
		}
	}

	//방형태 상관없음 선택시
	function checkRoomType(){
		$("#all_room_type").prop("checked", true);
		$("#open_room").prop("checked", false);
		$("#part_room").prop("checked", false);
		$("#duplex_room").prop("checked", false);
	}
	//룸형태 사항 체크시
	function checkAnyRoomType(){
		if ($("#open_room").is(":checked") &&
		$("#part_room").is(":checked") &&
		$("#duplex_room").is(":checked")) {
			$("#all_room_type").prop("checked", true);
			$("#open_room").prop("checked", false);
			$("#part_room").prop("checked", false);
			$("#duplex_room").prop("checked", false);
		}else if (
				!$("#open_room").is(":checked") 
				&& !$("#part_room").is(":checked") 
				&& !$("#duplex_room").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_room_type").prop("checked", true);
		}else{
			$("#all_room_type").prop("checked", false);
		}
	}
	
	//방수 상관없음 선택시
	function checkRoomNum(){
		$("#all_room_count").prop("checked", true);
		$("#one_room").prop("checked", false);
		$("#two_room").prop("checked", false);
		$("#three_room").prop("checked", false);
	}
	//룸의 수사항 체크시
	function checkAnyRoomNum(){
		if ($("#one_room").is(":checked") &&
		$("#two_room").is(":checked") &&
		$("#three_room").is(":checked")) {
			$("#all_room_count").prop("checked", true);
			$("#one_room").prop("checked", false);
			$("#two_room").prop("checked", false);
			$("#three_room").prop("checked", false);
		}else if (
				!$("#one_room").is(":checked") 
				&& !$("#two_room").is(":checked") 
				&& !$("#three_room").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_room_count").prop("checked", true);
		}else{
			$("#all_room_count").prop("checked", false);
		}
	}
	
	//방위치 상관없음 선택시
	function checkRoomPosition(){
		$("#all_room_position").prop("checked", true);
		$("#up_ground").prop("checked", false);
		$("#under_ground").prop("checked", false);
		$("#semi_basement").prop("checked", false);
		$("#rooftop").prop("checked", false);
	}
	//룸의 위치 사항 체크시
	function checkAnyRoomPosition(){
		if ($("#up_ground").is(":checked") &&
		$("#under_ground").is(":checked") &&
		$("#semi_basement").is(":checked") &&
		$("#rooftop").is(":checked")) {
			$("#all_room_position").prop("checked", true);
			$("#up_ground").prop("checked", false);
			$("#under_ground").prop("checked", false);
			$("#semi_basement").prop("checked", false);
			$("#rooftop").prop("checked", false);
		}else if (
				!$("#up_ground").is(":checked") 
				&& !$("#under_ground").is(":checked") 
				&& !$("#semi_basement").is(":checked")
				&& !$("#rooftop").is(":checked")
			){//체크가 전부안되어있으면 전체체크박스 체크
				$("#all_room_position").prop("checked", true);
		}else{
			$("#all_room_position").prop("checked", false);
		}
	}
	
	//모든 상세검색 조건 내용 초기화
	function initFilter(){
		$("#charter").prop("checked", false);
		$("#monthly_and_charter").prop("checked", false);
		$("#monthly").prop("checked", false);
		$("#short_lease").prop("checked", false);
		$("#trade").prop("checked", false);
		$("#all_type").prop("checked", true);

		document.getElementById("depositmin").value = "";
		document.getElementById("depositmax").value = "";
		document.getElementById("monthmin").value = "";
		document.getElementById("monthmax").value = "";
		document.getElementById("chartermin").value = "";
		document.getElementById("chartermax").value = "";
		document.getElementById("standardmin").value = "";
		document.getElementById("standardmax").value = "";
		
		$("#apartment").prop("checked", false);
		$("#officetel").prop("checked", false);
		$("#house").prop("checked", false);
		$("#normal_room").prop("checked", false);
		$("#shop").prop("checked", false);
		$("#office").prop("checked", false);
		$("#building").prop("checked", false);
		$("#redevelopment").prop("checked", false);
		$("#event").prop("checked", false);
		$("#all_building_type").prop("checked", true);
		
		$("#filter_building_type").addClass("hide");
		$('#built option:eq(0)').attr('selected', 'selected');
		document.getElementById("address").value = "";
		
		$("#all_room_type").prop("checked", true);
		$("#open_room").prop("checked", false);
		$("#part_room").prop("checked", false);
		$("#duplex_room").prop("checked", false);

		$("#all_room_count").prop("checked", true);
		$("#one_room").prop("checked", false);
		$("#two_room").prop("checked", false);
		$("#three_room").prop("checked", false);

		$("#all_room_position").prop("checked", true);
		$("#up_ground").prop("checked", false);
		$("#under_ground").prop("checked", false);
		$("#semi_basement").prop("checked", false);
		$("#rooftop").prop("checked", false);
		
		document.getElementById("leased_area_min").value = "";
		document.getElementById("leased_area_max").value = "";
		document.getElementById("exclusive_area_min").value = "";
		document.getElementById("exclusive_area_max").value = "";

		$("#full_option_room").prop("checked", false);
		$("#airconditioner").prop("checked", false);
		$("#refrigerator").prop("checked", false);
		$("#washer").prop("checked", false);
		$("#tv").prop("checked", false);
		$("#microwave").prop("checked", false);
		$("#induction").prop("checked", false);
		$("#sink").prop("checked", false);
		$("#gasrange").prop("checked", false);
		$("#sofa").prop("checked", false);
		$("#bed").prop("checked", false);
		$("#built_in_closet").prop("checked", false);
		$("#dressing_table").prop("checked", false);
		$("#veranda").prop("checked", false);
		$("#shoe_closet").prop("checked", false);
		
		$("#door_security").prop("checked", false);
		$("#cctv").prop("checked", false);
		$("#number_key").prop("checked", false);
		$("#all_security").prop("checked", true);
		
		$("#elevator").prop("checked", false);
		$("#parking").prop("checked", false);
		$("#animal").prop("checked", false);
		$("#empty").prop("checked", false);
		$("#sale").prop("checked", false);
		
		$("#pic_keep").prop("checked", false);
		$("#pic_none").prop("checked", false);
		$("#movie_keep").prop("checked", false);
		$("#movie_none").prop("checked", false);
		$(".sidebar").removeClass("filter_opened");
		
		showFilterBox();//필터박스 선택된항목만 보이기
	}
	//체크한항목만 필터박스로 보이기
 	function showFilterBox(){
		$("#filter_trade").addClass("hide");
 		if($("input:checkbox[name='trade_type']").is(":checked"))//거래 종류 선택시
 			$("#filter_trade").removeClass("hide");

		$("#filter_deposit").addClass("hide");
 		if($("#depositmin").val() != "" || $("#depositmax").val() != "")//보증금  입력시 
 			$("#filter_deposit").removeClass("hide");
		$("#filter_month").addClass("hide");
 		if($("#monthmin").val() != "" || $("#monthmax").val() != "")//월세 입력시 
 			$("#filter_month").removeClass("hide");
		$("#filter_charter").addClass("hide");
 		if($("#chartermin").val() != "" || $("#chartermax").val() != "")//전세가 입력시 
 			$("#filter_charter").removeClass("hide");
		$("#filter_standard").addClass("hide");
 		if($("#standardmin").val() != "" || $("#standardmax").val() != "")//기준가 입력시 
 			$("#filter_standard").removeClass("hide");

		$("#filter_building_type").addClass("hide");
 		if($("input:checkbox[name='building_type']").is(":checked"))//건물 형태 체크시
 			$("#filter_building_type").removeClass("hide");
		$("#filter_built_year").addClass("hide");
 		if($("#built option").index($("#built option:selected")) != 0)//준공년도 선택 인덱스가 초기상태이면
 			$("#filter_built_year").removeClass("hide");
		$("#filter_address").addClass("hide");
 		if($("#address").val() != "")//번지수 입력시 
 			$("#filter_address").removeClass("hide");

		$("#filter_room_type").addClass("hide");
 		if($("input:checkbox[name='room_type']").is(":checked"))//방형태 선택시
 			$("#filter_room_type").removeClass("hide");
		$("#filter_room_num").addClass("hide");
 		if($("input:checkbox[name='room_num']").is(":checked"))//방의 수 선택시
 			$("#filter_room_num").removeClass("hide");
		$("#filter_room_position").addClass("hide");
 		if($("input:checkbox[name='room_position']").is(":checked"))//방위치 선택시
 			$("#filter_room_position").removeClass("hide");

		$("#filter_standard").addClass("hide");
 		if($("#standardmin").val() != "" || $("#standardmax").val() != "")//기준가 입력시 
 			$("#filter_standard").removeClass("hide");

		$("#filter_exclusive_area").addClass("hide");
 		if($("#exclusive_area_min").val() != "" || $("#exclusive_area_max").val() != "")//전용면적 입력시
 			$("#filter_exclusive_area").removeClass("hide");
		$("#filter_leased_area").addClass("hide");
 		if($("#leased_area_min").val() != "" || $("#leased_area_max").val() != "")//공급면적 입력시
 			$("#filter_leased_area").removeClass("hide");

		$("#filter_inside_option").addClass("hide");
 		if($("input:checkbox[name='inside_option']").is(":checked"))//실내 옵션(가구 , 베란다 등의 옵션 포함)체크시
 			$("#filter_inside_option").removeClass("hide");
		$("#filter_security").addClass("hide");
 		if($("input:checkbox[name='security_type']").is(":checked"))//보안 체크시
 			$("#filter_security").removeClass("hide");
		$("#filter_add_option").addClass("hide");
 		if($("input:checkbox[name='add_option']").is(":checked"))//추가옵션(엘리베이터, 주차 등) 체크시 
 			$("#filter_add_option").removeClass("hide");

		$("#filter_pic").addClass("hide");
 		if($("input:radio[name='pic']").is(":checked"))//사진 여부 라디오 체크시
 			$("#filter_pic").removeClass("hide");
		$("#filter_movie").addClass("hide");
 		if($("input:radio[name='movie']").is(":checked"))//동영상 여부 라디오 체크시
 			$("#filter_movie").removeClass("hide");
	} 
	//검색 상세 입력내용과  필터박스  초기화(필터박스 제거선택 항목만)
 	function removeFilterAboutBox(target){
		//검색 상세내용 입력 및 체크사항 초기화(필터박스  제거선택 항목만)
		if(target == 'filter_trade'){
			$("#charter").prop("checked", false);
			$("#monthly_and_charter").prop("checked", false);
			$("#monthly").prop("checked", false);
			$("#short_lease").prop("checked", false);
			$("#trade").prop("checked", false);
			$("#all_type").prop("checked", true);
		}if(target == 'filter_deposit'){
			document.getElementById("depositmin").value = "";
			document.getElementById("depositmax").value = "";
		}if(target == 'filter_month'){
			document.getElementById("monthmin").value = "";
			document.getElementById("monthmax").value = "";
		}if(target == 'filter_charter'){
			document.getElementById("chartermin").value = "";
			document.getElementById("chartermax").value = "";
		}if(target == 'filter_standard'){
			document.getElementById("standardmin").value = "";
			document.getElementById("standardmax").value = "";
		}if(target == 'filter_building_type'){	
			$("#apartment").prop("checked", false);
			$("#officetel").prop("checked", false);
			$("#house").prop("checked", false);
			$("#normal_room").prop("checked", false);
			$("#shop").prop("checked", false);
			$("#office").prop("checked", false);
			$("#building").prop("checked", false);
			$("#redevelopment").prop("checked", false);
			$("#event").prop("checked", false);
			$("#all_building_type").prop("checked", true);
		}if(target == 'filter_built_year'){
			$('#built option:eq(0)').attr('selected', 'selected');
		}if(target == 'filter_address'){
			document.getElementById("address").value = "";
		}if(target == 'filter_room_type'){
			$("#all_room_type").prop("checked", true);
			$("#open_room").prop("checked", false);
			$("#part_room").prop("checked", false);
			$("#duplex_room").prop("checked", false);
		}if(target == 'filter_room_num'){
			$("#all_room_count").prop("checked", true);
			$("#one_room").prop("checked", false);
			$("#two_room").prop("checked", false);
			$("#three_room").prop("checked", false);
		}if(target == 'filter_room_position'){
			$("#all_room_position").prop("checked", true);
			$("#up_ground").prop("checked", false);
			$("#under_ground").prop("checked", false);
			$("#semi_basement").prop("checked", false);
			$("#rooftop").prop("checked", false);
		}if(target == 'filter_exclusive_area'){
			document.getElementById("exclusive_area_min").value = "";
			document.getElementById("exclusive_area_max").value = "";
		}if(target == 'filter_leased_area'){	
			document.getElementById("leased_area_min").value = "";
			document.getElementById("leased_area_max").value = "";
		}if(target == 'filter_inside_option'){
			$("#full_option_room").prop("checked", false);
			$("#airconditioner").prop("checked", false);
			$("#refrigerator").prop("checked", false);
			$("#washer").prop("checked", false);
			$("#tv").prop("checked", false);
			$("#microwave").prop("checked", false);
			$("#induction").prop("checked", false);
			$("#sink").prop("checked", false);
			$("#gasrange").prop("checked", false);
			$("#sofa").prop("checked", false);
			$("#bed").prop("checked", false);
			$("#built_in_closet").prop("checked", false);
			$("#dressing_table").prop("checked", false);
			$("#veranda").prop("checked", false);
			$("#shoe_closet").prop("checked", false);
		}if(target == 'filter_security'){
			$("#door_security").prop("checked", false);
			$("#cctv").prop("checked", false);
			$("#number_key").prop("checked", false);
			$("#all_security").prop("checked", true);
		}if(target == 'filter_add_option'){
			$("#elevator").prop("checked", false);
			$("#parking").prop("checked", false);
			$("#animal").prop("checked", false);
			$("#empty").prop("checked", false);
			$("#sale").prop("checked", false);
		}if(target == 'filter_pic'){
			$("#pic_keep").prop("checked", false);
			$("#pic_none").prop("checked", false);
		}if(target == 'filter_movie'){
			$("#movie_keep").prop("checked", false);
			$("#movie_none").prop("checked", false);
		}
 	}
</script>
<script>
	//************************필터 검색 *******************	
	function setFilterUrl(){//필터 url생성
		var numberInput = false;
		var url='';	

		//거래 종류
		if ($('input:checkbox[id="trade"]').is(":checked") != "")//매매
			url +="1";url +=":";
		if ($('input:checkbox[id="charter"]').is(":checked") != "") //전세
			url +="2";url +=":";
		if ($('input:checkbox[id="monthly_and_charter"]').is(":checked")!= "") //전월세
			url +="6";url +=":";
		if ($('input:checkbox[id="monthly"]').is(":checked")!= "") //월세
			url +="4";url +=":";
		if ($('input:checkbox[id="short_lease"]').is(":checked") != "") //단기임대
			url +="8";url +=":";
		//금액
		if ($("#depositmin").val() == ''){//보증금 최소
			url +="0";
		} else{
			url +=$("#depositmin").val();
			numberInput =true;
		}
		url +=":";
		if ($("#depositmax").val() == ''){//보증금 최대
			url +=999999999;
		} else {
			url += $("#depositmax").val();
			numberInput =true;
		}
		url +=":";			
		if ($("#monthmin").val() == ''){//월세 최소
			url +="0";
		} else {
			url +=$("#monthmin").val();
			numberInput =true;
		}
		url +=":";
		if ($("#monthmax").val() == ''){//월세 최대
			url +=999999999;
		} else{
			url += $("#monthmax").val();
			numberInput =true;
		}
		url +=":";
		if ($("#chartermin").val() == ''){//전세 최소
			url +="0";
		} else{
			url +=$("#chartermin").val();
			numberInput =true;
		}
		url +=":";
		if ($("#chartermax").val() == ''){//전세 최대
			url +=999999999;
		} else{
			url += $("#chartermax").val();
			numberInput =true;
		}
		url +=":";
		if ($("#standardmin").val() == ''){//기준가 최소
			url +="0";
		} else{
			url +=$("#standardmin").val();	
			numberInput =true;
		}
		url +=":";
		if ($("#standardmax").val() == ''){//기준가 최대
			url +=999999999;
		} else{
			url +=$("#standardmax").val();
			numberInput =true;
		}
		url +=":";
		
		//건물종류 : 아파트/오피스텔/주택/원룸/상가/사무실/건물/재개발/이벤트
		if ($('input:checkbox[id="apartment"]').is(":checked") != "") //아파트
			url +="1";url +=":";
		if ($('input:checkbox[id="officetel"]').is(":checked") != "") //오피스텔
			url +="1";url +=":";
		if ($('input:checkbox[id="house"]').is(":checked") != "") //주택
			url +="1";url +=":";	
		if ($('input:checkbox[id="normal_room"]').is(":checked") != "") //원룸
			url +="1";url +=":";
		if ($('input:checkbox[id="shop"]').is(":checked") != "") //상가
			url +="1";url +=":";	
		if ($('input:checkbox[id="office"]').is(":checked") != "") //사무실
			url +="1";url +=":";
		if ($('input:checkbox[id="building"]').is(":checked") != "") //건물
			url +="1";url +=":";	
		if ($('input:checkbox[id="redevelopment"]').is(":checked") != "") //재개발
			url +="1";url +=":";
		if ($('input:checkbox[id="event"]').is(":checked") != "") //이벤트
			url +="1";url +=":";
			
		//준공년도
		if($("#built option:selected").val() != '전체'){
			url +=$("#built option:selected").val();url +=":"
			numberInput = true;
		}else{
			url +=new Date().getFullYear();url +=":"
		}
			
		//번지
		url +=$("#address").val();url +=":";
		//룸종류
		/* if($('input:checkbox[id="all_room_type"]').is(":checked") != ""){//방 형태 상관없음 체크시
			url +="1";url +=":"; 
			url +="1";url +=":";
			url +="1";url +=":";
		} else{ */
			if ($('input:checkbox[id="open_room"]').is(":checked")) //오픈형
				url +="1";
			url +=":";  			
			if ($('input:checkbox[id="part_room"]').is(":checked")) //분리형
				url +="1";
			url +=":";  		
			if ($('input:checkbox[id="duplex_room"]').is(":checked")) //복층형
				url +="1";
			url +=":";  
		/* } */
			
		/* //룸개수 room_count
		if($('input:checkbox[id="all_room_count"]').is(":checked") != ""){//룸개수 상관없음 체크시
			url +="1";	url +=":"; 	
			url +="1";	url +=":";
			url +="1"; url +=":";  
		} else{ */
			if ($('input:checkbox[id="one_room"]').is(":checked") != "") //월룸
				url +="1";	
			url +=":"; 		
			if ($('input:checkbox[id="two_room"]').is(":checked") != "") //투룸
				url +="1";	
			url +=":"; 		
		    if ($('input:checkbox[id="three_room"]').is(":checked") != "") //쓰리룸
				url +="1"; 
		    url +=":";  
		/* } */
		
		//층수
		/* if($('input:checkbox[id="all_room_position"]').is(":checked") != ""){//룸위치(층수) 상관없음 체크시
			url +="1";url +=":";	
			url +="1";url +=":";
			url +="1";url +=":";  
			url +="1";url +=":";  
		} else{ */
			if ($('input:checkbox[id="up_ground"]').is(":checked") != "") //지상
				url +="1";url +=":";			
			if ($('input:checkbox[id="under_ground"]').is(":checked") != "") //지하
				url +="1";url +=":";			
			if ($('input:checkbox[id="semi_basement"]').is(":checked") != "") //반지하
				url +="1";url +=":";  			
			if ($('input:checkbox[id="rooftop"]').is(":checked") != "") //옥탑방
				url +="1";url +=":";  
		/* } */

		//전용면적 최소 최대     
		if ($("#exclusive_area_min").val() == ''){//전용면적 최소 
			url +=0;
		}else{
			url +=$("#exclusive_area_min").val();
			numberInput =true;
		}
		url +=":";  
		if ($("#exclusive_area_max").val() == ''){//전용면적 최대
			url +=999999999;
		} else{
			url +=$("#exclusive_area_max").val();
			numberInput =true;
		}
		url +=":";  
            
	   //공급면적 최소 최대
		if ($("#leased_area_min").val() == ''){//공급면적 최소
			url +=0;
		}else{
			url +=$("#leased_area_min").val();
			numberInput =true;
		}
		url +=":"; 
		if ($("#leased_area_max").val() == ''){//공급면적 최대
			url +=999999999;
		}else{
			url +=$("#leased_area_max").val();
			numberInput =true;
		}
		url +=":"; 
		
		//옵션
		if ($('input:checkbox[id="full_option_room"]').is(":checked") != "") //풀옵션
			url +="1";url +=":";			
		if ($('input:checkbox[id="airconditioner"]').is(":checked") != "") //에어컨
			url +="1";url +=":";			
		if ($('input:checkbox[id="refrigerator"]').is(":checked") != "") //냉장고
			url +="1";url +=":";  
		if ($('input:checkbox[id="washer"]').is(":checked") != "") //세탁기
			url +="1";url +=":";			
		if ($('input:checkbox[id="tv"]').is(":checked") != "") //tv
			url +="1";url +=":";    
		if ($('input:checkbox[id="microwave"]').is(":checked") != "") //전자레인지
			url +="1";url +=":";			
		if ($('input:checkbox[id="induction"]').is(":checked") != "") //인덕션
			url +="1";url +=":";  
		if ($('input:checkbox[id="sink"]').is(":checked") != "") //싱크대
			url +="1";url +=":";			
		if ($('input:checkbox[id="gasrange"]').is(":checked") != "") //가스레인지
			url +="1";url +=":";     
		if ($('input:checkbox[id="sofa"]').is(":checked") != "") //소파
			url +="1";url +=":";			
		if ($('input:checkbox[id="bed"]').is(":checked") != "") //침대
			url +="1";url +=":";   
		if ($('input:checkbox[id="built_in_closet"]').is(":checked") != "") //붙박이장
			url +="1";url +=":";			
		if ($('input:checkbox[id="dressing_table"]').is(":checked") != "") //화장대
			url +="1";url +=":";   		
		if ($('input:checkbox[id="veranda"]').is(":checked") != "") //베란다
			url +="1";url +=":";			
		if ($('input:checkbox[id="shoe_closet"]').is(":checked") != "") //신발장
			url +="1";url +=":";   		

		//보안
		if ($('input:checkbox[id="door_security"]').is(":checked") != "") //현관보안
			url +="1";url +=":";   
		if ($('input:checkbox[id="cctv"]').is(":checked") != "") //cctv
			url +="1";url +=":";   
		if ($('input:checkbox[id="number_key"]').is(":checked") != "") //자동번호키
			url +="1";url +=":";   		
		
		//기타옵션
		if ($('input:checkbox[id="elevator"]').is(":checked") != "") //엘리베이터
			url +="1";url +=":";   		
		if ($('input:checkbox[id="parking"]').is(":checked") != "") //주차가능
			url +="1";url +=":"; 	
		if ($('input:checkbox[id="animal"]').is(":checked") != "") //반려동물
			url +="1";url +=":"; 
		if ($('input:checkbox[id="empty"]').is(":checked") != "") //공실
			url +="1";url +=":";   		
		if ($('input:checkbox[id="sale"]').is(":checked") != "") //매물
			url +="1";url +=":"; 	

		//사진 동영상 보유사항
		if ($('input:radio[id="pic_keep"]').is(":checked") != ""){//사진있음
			url +="1"; url +=":";
			numberInput =true;
		} else {
			url +=":";
		}  
		if ($('input:radio[id="pic_none"]').is(":checked") != ""){ //사진없음
			 url +="1"; url +=":";
			numberInput =true;
		}else{
			url +=":";
		}

		if ($('input:radio[id="movie_keep"]').is(":checked") != ""){//사진있음
			url +="1"; url +=":";
			numberInput =true;
		} else {
			url +=":";
		}
		if ($('input:radio[id="movie_none"]').is(":checked") != ""){ //사진없음
			 url +="1"; url +=":";
			 numberInput =true;
		} else{
			url +=":";
		}

		filterUrl ="&p=" + url;
		if(171 < url.length || numberInput)//필터적용 했으면
			return true;
		else//필터적용 안하면
			return false;
		//alert("filter change/ full url : "+searchUrl +"/"+ filterUrl +"/"+ sortUrl);
	}
	
	function searchDetail(){
		//필터 검색 닫기
		$(".sidebar").removeClass("filter_opened");
		//페이지초기화
		posChangeSubmit(1);
		setSectionCount();//섹션 검색결과수 설정
		showFilterBox();
	} 
	function searchExceptDetail(){
		//필터 검색 닫기
		$(".sidebar").removeClass("filter_opened");
		//필터초기화
		initFilter();//필터적용값 초기화
		//페이지초기화
		posChangeSubmit(1);//검색
		setSectionCount();//섹션 검색결과수 설정

		showFilterBox();
	} 
	function searchExceptFilterBox(target){
		//필터일부 제외후 적용
		removeFilterAboutBox(target);
		posChangeSubmit(1);//검색
		setSectionCount();//섹션 검색결과수 설정
		showFilterBox();
	} 
	
	function cancle(){
		$(".sidebar").reset("filter_opened");
		$(".sidebar").removeClass("filter_opened");
	} 
</script>
<!-- 정렬기능 -->
<script>
    //***********************정렬 기능*******************
 	function sortSearch(kind){
		if(kind == 'date_desc'){
			sortUrl = '&sort=date desc';
			document.getElementById("sort_title").innerHTML = "최신등록순";
		}
		else if(kind == 'main_address, sub_address'){
			sortUrl = '&sort=main_address, sub_address asc';
			document.getElementById("sort_title").innerHTML = "번지수 오름차순";
		}
		else if(kind == 'stand_doposit_desc'){
			sortUrl = '&sort=standard_deposit desc';
			document.getElementById("sort_title").innerHTML = "기준가 높은 순";
		}
		else if(kind == 'stand_doposit_asc'){
			sortUrl = '&sort=standard_deposit asc';
			document.getElementById("sort_title").innerHTML = "기준가 낮은 순 ";
		}
		else if(kind == 'monthly_rent_desc'){
			sortUrl = '&sort=monthly_rent desc';
			document.getElementById("sort_title").innerHTML = "월세 높은 순";
		}
		else if(kind == 'monthly_rent_asc'){
			sortUrl = '&sort=monthly_rent asc';
			document.getElementById("sort_title").innerHTML = "월세 낮은 순";
		}
		else if(kind == 'deposit_desc'){
			sortUrl = '&sort=deposit desc';
			document.getElementById("sort_title").innerHTML = "보증금 높은 순";
		}
		else if(kind == 'deposit_asc'){
			sortUrl = '&sort=deposit asc';
			document.getElementById("sort_title").innerHTML = "보증금 낮은 순";
		}
		else if(kind == 'exclusive_area_desc'){
			sortUrl = '&sort=exclusive_area desc';
			document.getElementById("sort_title").innerHTML = "전용면적 높은 순";
		}
		else if(kind == 'exclusive_area_asc'){
			sortUrl = '&sort=exclusive_area asc';
			document.getElementById("sort_title").innerHTML = "전용면적 낮은 순";
		}
		if($(".sort").hasClass("opened")) 
			 $(".sort").removeClass("opened");//정렬 드롭박스 숨기기
		//페이지초기화
		posChangeSubmit(1);
	}
 </script>     
 <!-- 프린트 페이지 -->
 <script>
	 var address_post_print =[];
	 var address_pre_print =[];
	 var room_print =[];
	 var room_price =[];
	 var win=null;
	 function printRoom(){
		var str ='';
		str += " <table border ='1'>";
		str += " <tr>";
		str += " <p> 매물 정보 page"+1+" </p>";
		str += " <th>매물번호</th> <th>주소</th> <th>구분</th> <th>연락처</th>  <th>가격</th> ";
		str += " </tr>";
		for(var i = 0 ; i < room_print.length; i++){
			   str += " <tr>";
			   str += " <td>"+room_print[i]+"</td><td>"+address_pre_print[i]+"<br>"+ address_post_print[i] + "</td>";
			   str += " <td>"+who1_print[i]+"<br>" +who2_print[i] +"<br>"+ who3_print[i] +"</td>";
			   str += " <td>"+contact1_print[i]+"<br>" +contact2_print[i] +"<br>"+ contact3_print[i] +"</td>";
			   str += " <td>"+ room_price[i] +"</td>";
			   str += " </tr>";
			   if(0 < i && i % 15 == 0){
				    str += " </table>";
				    str += " <table border ='1'>";
				    str += " <p style=\"page-break-before: always;\"> 매물 정보 page"+(i/15+1)+" </p>";
				    str += " <th>매물번호</th> <th>주소</th> <th>구분</th> <th>연락처</th>  <th>가격</th> ";
			   }
		}
		str += " </table>";
		win = window.open();
		self.focus();
		win.document.open();
		win.document.write('<'+'html'+'><'+'head'+'><'+'style'+'>');
		win.document.write('body, td { font-family: Verdana; font-size: 10pt;}');
		win.document.write('<'+'/'+'style'+'><'+'/'+'head'+'><'+'body'+'>');
		win.document.write(str);
		win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
		win.document.close();
		win.print();
		win.close();
	 }
</script> 