package com.example;  
  
import java.io.BufferedInputStream;  
import java.io.IOException;  
import java.io.InputStream;  
//중개사의(클라이언트)맥주소 제공하는, 중개사측의 로컬 프로그램
public final class NetworkInfo {  
    public final static String getMacAddress() throws IOException {  
        String os = System.getProperty("os.name");  
        if (os.startsWith("Windows")) {  
            return ParseMacAddress(windowsRunIpConfigCommand());  
        } else if (os.startsWith("Linux")) {  
            return ParseMacAddress(linuxRunIfConfigCommand());  
        } else {  
            throw new IOException("unknown operating system: " + os);  
        }  
    }  
    /* 
     * Linux
     */  
    private final static String linuxRunIfConfigCommand() throws IOException {  
        Process p = Runtime.getRuntime().exec("ifconfig");  
        InputStream stdoutStream = new BufferedInputStream(p.getInputStream());  
  
        StringBuffer buffer = new StringBuffer();  
        for (;;) {  
            int c = stdoutStream.read();  
            if (c == -1)  
                break;  
            buffer.append((char) c);  
        }  
        String outputText = buffer.toString();  
  
        stdoutStream.close();  
  
        return outputText;  
    }  
    /* 
     * Windows
     */  
    private final static String windowsRunIpConfigCommand() throws IOException {  
        Process p = Runtime.getRuntime().exec("ipconfig /all");  
        InputStream stdoutStream = new BufferedInputStream(p.getInputStream());  
  
        StringBuffer buffer = new StringBuffer();  
        for (;;) {  
            int c = stdoutStream.read();  
            if (c == -1)  
                break;  
            buffer.append((char) c);  
        }  
        String outputText = buffer.toString();  
  
        stdoutStream.close();  
  
        return outputText;  
    }  
    public static String ParseMacAddress(String text) {  
        String result = null;  
        String[] list = text.split("\\p{XDigit}{2}(-\\p{XDigit}{2}){5}");  
        int index = 0;  
        for (String str : list) {  
            if (str.length() < text.length()) {  
                index = str.length();  
                result = text.substring(index, index + 17);  
                if (!result.equals("00-00-00-00-00-00")) {  
                    break;  
                }  
                text = text.substring(index + 17);  
            }  
        }  
        return result;  
    }  
}  