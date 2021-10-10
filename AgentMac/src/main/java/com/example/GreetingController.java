package com.example;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class GreetingController {
    @RequestMapping(value = "/client_macaddress", method = RequestMethod.GET)
    @ResponseBody 
    public String getClientMacaddress(HttpServletResponse res)  throws IOException {
    	res.setHeader("Access-Control-Allow-Origin", "*");
    	res.setHeader("Access-Control-Allow-Headers", "X-Requested-With");
        return NetworkInfo.getMacAddress();
    }
}