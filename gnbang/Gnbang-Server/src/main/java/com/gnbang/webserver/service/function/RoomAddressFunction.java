package com.gnbang.webserver.service.function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RoomAddressFunction {
	private static String sameStr(String str, String expression){
		Pattern p = Pattern.compile(expression); 
		Matcher m = p.matcher(str); 
		if(m.find())
			str = m.group(0);
		else
			str ="";
		return " " + str + " ";
	}
	 public static String getDongType(String str){
		String dong ="";
		//ex) str = " 현대하이빌 A 2동 ";  -> 건물 이름 뒤에 숫자가오고 이후에 숫자 + 동이 오면
		dong = " " + str + " ";//dong = " 현대하이빌 A 2동  "
		dong = sameStr(dong, "^.+[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+.*( ).*([0-9]{1,4}|[a-zA-Z]|가|나|다|라|마|바|사|아|west|east|north|south)( )?동( )");//dong = " 현대하이빌 A 2동 "
		dong = sameStr(dong, "([0-9]{1,4}|[a-zA-Z]|가|나|다|라|마|바|사|아|west|east|north|south)( )?동");//dong = " 현대하이빌 A 2동 "
		if("  ".length() < dong.length())
			return getOnlyDongValue(dong);
		
		//ex) str = " w아퓨트2212동 나아2동아 이동 유2층 ";  -> 건물 이름 뒤에 동이름만
		dong = " " + str + " ";//dong = " w아퓨트2212동 나아2동아 이동 유2층 "
		dong = sameStr(dong, "^.+[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+( )?([0-9]{1,4}+|[a-zA-Z])+동?( )");//dong = " w아퓨트2212동 나아2동"
		dong = sameStr(dong, "([0-9]{1,4}|[a-zA-Z])+동");//dong = "2212동"
		dong = sameStr(dong, "( )([0-9]{1,4}|[a-zA-Z])+[동( )]");//dong = "2212동"
		if("  ".length() < dong.length())
			return getOnlyDongValue(dong);
		
		//ex) str == " 사2동아아파트 아 무 것2동 아냐 10동 2층 3호-202호 "  -> 동앞에 숫자 및 알파벳, 가-하,  south등 4방위가 올때
		dong = " " + str + " ";//dong == " 사2동아아파트 아 무 것2동 아냐 10동 2층 3호-202호 "
		dong = sameStr(dong, "( )([0-9]{1,4}|[a-zA-Z]|가|나|다|라|마|바|사|아|west|east|north|south)동( )");//dong == "10동"
		dong = sameStr(dong, "([0-9]{1,4}|[a-zA-Z]|가|나|다|라|마|바|사|아|west|east|north|south)동( )$");//dong == "10동"
		if("  ".length() < dong.length())
			return getOnlyDongValue(dong);
		
		//ex) str == " 102동 3층 303호 "  -> 동이름 + 동이 먼저왔을때
		dong = " " + str + " ";//dong == " 102동 "
		dong = sameStr(dong, "( )([0-9]{1,4}|[a-zA-Z]|가|나|다|라|마|바|사|아|west|east|north|south)동( )");//dong == "10동"
		if("  ".length() < dong.length())
			return getOnlyDongValue(dong);
		
		return null;
	}
	public static String getFloorType(String str){
		String floor ="";
		floor = " " + str + " ";//3차 22층 반지하101호 
		//반지하의 경우
		floor = sameStr(floor, "반?지하 ?[0-9]{0,4}");//반지하101호 
		if( sameStr(floor, "반?지하 ?").length() + 1 < sameStr(floor, "반?지하 ?[0-9]{1,4}").length())
			floor = sameStr(floor, "반?지하");//반지하
		if("  ".length() < floor.length())
			return getOnlyFloorValue(floor);

		//일반층의 경우
		floor = " " + str + " ";//3차 22층 반지하101호 
		floor = sameStr(floor, "[0-9]{1,2}층");
		if("  ".length() < floor.length())
			return getOnlyFloorValue(floor);
		
		//일반층의 경우
		floor = " " + str + " ";//3차 22층 반지하101호 
		floor = sameStr(floor, "옥탑");
		if("  ".length() < floor.length())
			return getOnlyFloorValue(floor);
		
		return null;
	}
	public static String getHoType(String str){
		String ho =""; 

		ho = " " + str + " ";
		ho = sameStr(ho, "(B|b)[0-9]{2,4}호");
		if("  ".length() < ho.length())
			return getOnlyHoValue(ho);

		ho = " " + str + " ";
		ho = sameStr(ho, "[0-9]{1,4}호");
		if("  ".length() < ho.length())
			return getOnlyHoValue(ho);

		ho = " " + str + " ";
		ho = sameStr(ho, "(B|b)[0-9]{2,4} $");
		if("  ".length() < ho.length())
			return getOnlyHoValue(ho);
		
		ho = " " + str + " ";
		ho = sameStr(ho, "[0-9]{3,4} $");
		if("  ".length() < ho.length())
			return getOnlyHoValue(ho);
		
		
		return null;
	}
	private static String getOnlyDongValue(String str){
		str = str.trim();
		if(str.lastIndexOf("동") != -1)
			str = str.substring(0, str.lastIndexOf("동"));
		return str;
	}
	private static String getOnlyFloorValue(String str) {
		str = str.trim();
		if(str.lastIndexOf("층") != -1)
			str = str.substring(0, str.lastIndexOf("층"));
		return str;
	}
	private static String getOnlyHoValue(String str) {
		str = str.trim();
		if(str.lastIndexOf("호") != -1)
			str = str.substring(0, str.lastIndexOf("호"));
		return str;
	}
	
	public static boolean isSameLastAddress(String basicAddress, String newAddress){
		//"호실은 확인되지않아서 임의로" 라는글씨가 오면 , 기본 중복검사 대상에서 제외
		if("※ 호실은 확인되지 않아서".equals(basicAddress))
			return false;
		//층 동 호의 값을 추출하여 가져옴
		String newDong = getDongType(newAddress) == null ? "" : getDongType(newAddress);
		String basicDong = getDongType(basicAddress)  == null ? "" : getDongType(basicAddress);
		String newFloor = getFloorType(newAddress)  == null ? "" : getFloorType(newAddress);
		String basicFloor = getFloorType(basicAddress)  == null ? "" : getFloorType(basicAddress);
		String newHo = getHoType(newAddress)  == null ? "" : getHoType(newAddress);
		String basicHo= getHoType(basicAddress)  == null ? "" : getHoType(basicAddress);
		if(newDong == null)
			newDong ="";

		//기존 상세주소값에 층 동 호 가 없으면  새주소와 중복되지않음
		if(basicDong.equals("") && basicFloor.equals("") && basicHo.equals(""))
			return false;
			
		//존재하는 층 동 호 중에 값이있는 것들을 비교하여 중복되지않으면  새주소와 상세주소는 중복되지않음
		if(!newDong.equals(basicDong) && !basicDong.equals("")&& !newDong.equals(""))
			return false;//같지않음
		if(!newFloor.equals(basicFloor) && !basicFloor.equals("") && !newFloor.equals(""))
			return false;//같지않음
		if(!newHo.equals(basicHo) && !basicHo.equals("") && !newHo.equals(""))
			return false;//같지않음
				
		return true;
	}
	
	public static void test(String str){
		System.out.println("*******************************" + str +"*******************************");
		System.out.println(getHoType(str));
		System.out.println(getDongType(str));
		System.out.println(getFloorType(str));
	}
}

