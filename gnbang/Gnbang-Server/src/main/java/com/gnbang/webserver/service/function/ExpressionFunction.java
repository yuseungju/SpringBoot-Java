package com.gnbang.webserver.service.function;

public class ExpressionFunction {
	public static String convertDisplayedContract(String contract){
		if(contract == null)
			return "";
		if(contract.equals(""))
			return "";
		
		if(contract.length() == 13 || contract.length() == 12)//000-0000-0000 형식이면
			return contract;//그대로 반환
		
		String firstContract ="";
		String secondContract ="";
		String thirdContract ="";
		
		if(4 < contract.length()){
			thirdContract = "-" + contract.substring(contract.length()-4);
			contract = contract.substring(0, contract.length()-4);
		}
		if(4 < contract.length()){
			if(contract.charAt(0) == '0' && contract.charAt(1) == '2'){
				firstContract =  contract.substring(0, 2);
				secondContract = "-" + contract.substring(2);
			}else{
				if(5 == contract.length()){
					firstContract =  contract.substring(0, 2);
					secondContract = "-" +contract.substring(2);
				} else if(6 == contract.length()){
					firstContract =  contract.substring(0, 3);
					secondContract = "-" +contract.substring(3);
				} else if(7 == contract.length()){
					firstContract =  contract.substring(0, 3);
					secondContract = "-" +contract.substring(3);
				} else if(8 == contract.length()){
					firstContract =  contract.substring(0, 4);
					secondContract = "-" +contract.substring(4);
				}
			}
		}else{
			secondContract = contract;
		}
		System.out.println(firstContract + secondContract + thirdContract);
		return firstContract + secondContract + thirdContract;
	}
}
