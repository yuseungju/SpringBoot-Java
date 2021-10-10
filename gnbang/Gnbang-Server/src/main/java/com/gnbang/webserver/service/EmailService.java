package com.gnbang.webserver.service;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnbang.webserver.config.GlobalValue;
import com.gnbang.webserver.mapper.EmailMapper;

@Service
public class EmailService {

	@Autowired
	private EmailMapper emailMapper;
	private final static Logger logger = LoggerFactory.getLogger(EmailService.class);

	/*public boolean sendToEmail(String email, String code) {

		try {
			// 메일 관련 정보
			String host = "smtp.worksmobile.com";
			final String username = "no-reply.gnb@ox9osub.kr";
			final String password = "gnb!2017";
			int port = 465;

			///////////////////////////////////////////////////////////////////
			// 메일 내용
			String recipient = email;
			String subject = "강남방 인증코드입니다.";
			String body = "회원님의 인증코드는 " + code + " 입니다.";
			///////////////////////////////////////////////////////////////////

			Properties props = System.getProperties();

			props.put("mail.smtp.host", host); // SMTP Host
			props.put("mail.smtp.socketFactory.port", "465"); // SSL Port
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // SSL
			// Factory
			// Class
			props.put("mail.smtp.auth", "true"); // Enabling SMTP Authentication
			props.put("mail.smtp.port", "465"); // SMTP Port

			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un = username;
				String pw = password;

				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(un, pw);
				}
			});
			session.setDebug(true); // for debug

			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress(username));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			mimeMessage.setSubject(subject);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return false;
		}
		return true;
	}*/

	public int sendRandomCodeToEmail(String email) {
		int code = 0;
		try {
			// 메일 관련 정보
			String host = "smtp.worksmobile.com";
			final String username = "no-reply.gnb@ox9osub.kr";
			final String password = "gnb!2017";


			//랜덤 코드 4자리 생성
			code = (int) (Math.random()*9000 + 1000);

			///////////////////////////////////////////////////////////////////
			// 메일 내용
			String recipient = email;
			String subject = "강남방 인증코드입니다.";
			String body = "회원님의 인증코드는 " + code + " 입니다.";
			///////////////////////////////////////////////////////////////////

			Properties props = System.getProperties();

			props.put("mail.smtp.host", host); // SMTP Host
			props.put("mail.smtp.socketFactory.port", "465"); // SSL Port
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // SSL
			// Factory
			// Class
			props.put("mail.smtp.auth", "true"); // Enabling SMTP Authentication
			props.put("mail.smtp.port", "465"); // SMTP Port

			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un = username;
				String pw = password;

				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(un, pw);
				}
			});
			session.setDebug(true); // for debug

			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress(username));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			mimeMessage.setSubject(subject);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return code;
		}
		return code;
	}

	public boolean sendPasswordLink(String email) {
		String body="";
		try {
			// 메일 관련 정보
			String host = "smtp.worksmobile.com";
			final String username = "no-reply.gnb@ox9osub.kr";
			final String password = "gnb!2017";

			///////////////////////////////////////////////////////////////////
			// 메일 내용
			String recipient = email;
			String subject = "강남방 비밀번호 찾기";
			body = "\n아래 링크를 클릭하셔서 새 비밀번호를 설정해주세요.\n";
			String userLink = GlobalValue.passwordLink;
			body+= userLink;
			body += ("login/new_password");
			body += ("?email="+email);
			
			//패스워드를 숫자로 변환해서 링크로 보냄(메일에서 특수문자는 링크 안되는 현상 방지)
			String pwd = emailMapper.getPassword(email);
			int[] chs = pwd.chars().toArray();
			pwd= "";
			for(int a=0; a<chs.length; a++)
				pwd += chs[a]+"_";
			body += ("&encodedPassword="+pwd);
			///////////////////////////////////////////////////////////////////

			Properties props = System.getProperties();

			props.put("mail.smtp.host", host); // SMTP Host
			props.put("mail.smtp.socketFactory.port", "465"); // SSL Port
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // SSL
			// Factory
			// Class
			props.put("mail.smtp.auth", "true"); // Enabling SMTP Authentication
			props.put("mail.smtp.port", "465"); // SMTP Port

			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un = username;
				String pw = password;

				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(un, pw);
				}
			});
			session.setDebug(true); // for debug

			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress(username));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			mimeMessage.setSubject(subject);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
		} catch (Exception e) {
			return false;
		}
		logger.debug(email + "(email) send / content: " + body);
		return true;
	}

}