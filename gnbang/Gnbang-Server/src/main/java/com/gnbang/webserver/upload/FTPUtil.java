package com.gnbang.webserver.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FTPUtil {
	
	enum STATUS {CONNECTED, DISCONNECTED, IS_UPLOADING, }

	private final Logger logger = LoggerFactory.getLogger(FTPUtil.class);
	
	private static FTPUtil instance = null;

	private String address;
	private int port;
	private String id;
	private String password;

	private FTPClient ftpClient = null;
	
	private boolean isUploading = false;
	
	private List<FTPFile> uploadQueue;
	private List<FTPFile> successList;
	private List<FTPFile> failList;
	
	public synchronized static FTPUtil getInstance(String address, int port, String id, String password) {
		if (instance == null) {
			instance = new FTPUtil(address, port, id, password);
		}
		return instance;
	}
	
	private FTPUtil(String address, int port, String id, String password) {
		this.address = address;
		this.port = port;
		this.id = id;
		this.password = password;
		
		this.ftpClient = new FTPClient();
		uploadQueue = new ArrayList<FTPFile>();
		successList = new ArrayList<FTPFile>();
		failList = new ArrayList<FTPFile>();
	}

	private void showServerReply(FTPClient ftpClient) {
		String[] replies = ftpClient.getReplyStrings();
		if (replies != null && replies.length > 0) {
			for (String aReply : replies) {
				logger.debug("SERVER: " + aReply);
			}
		}
	}
	

	public boolean connect() {
		if (ftpClient == null) {
			ftpClient = new FTPClient();
		}
		else {
			if (ftpClient.isConnected()) {
				//logger.debug("connected now");
				return true;
			}
		}
		try {
			ftpClient.setControlEncoding("UTF-8");
			ftpClient.connect(address, port);
			int replyCode = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(replyCode)) {
				logger.debug("Operation failed. Server reply code: " + replyCode);
				return false;
			}
			boolean success = ftpClient.login(id, password);
			showServerReply(ftpClient);
			ftpClient.enterLocalPassiveMode();
			showServerReply(ftpClient);
			if (!success) {
				logger.debug("Could not login to the server");
				return false;
			}
			return true;
		} catch (SocketException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}
	
/*	public boolean checkDirectoryExists(String dirPath) {
		connect();
        try {
			ftpClient.changeWorkingDirectory(dirPath);
	        int returnCode = ftpClient.getReplyCode();
	        if (returnCode == 550) {
				ftpClient.changeWorkingDirectory("..");
	            return false;
	        }
			ftpClient.changeWorkingDirectory("..");
	        return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
    }*/
	public boolean createDirestories(String directoryNames) throws IOException{
		String[] directoryArr = directoryNames.split("/");
        boolean success = false;
        String directory ="";
		for(int a=1; a<directoryArr.length; a++){
			directory += ("/" +  (directoryArr[a]));
			try{
				if(ftpClient.makeDirectory(directory+"/"))
					success= true;
			}
			catch(Exception e){
			}
		}
		return success;
	}
	
	public boolean createDirectory(String directory) {
		connect();
        boolean success = false;
		try {
			success = createDirestories(directory);
			showServerReply(ftpClient);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
		}
        if (success) {
        	logger.debug("Successfully created directory: " + directory);
        	return true;
        } else {
        	logger.debug("Failed to create directory. See server's reply. ");
        	logger.debug("allready directory is");
            return false;
        }
	}
	
	public boolean changeWorkingDirectory(String directory) {
		connect();
        boolean success = false;
		try {
			success = ftpClient.changeWorkingDirectory(directory);
	        showServerReply(ftpClient);
		} catch (IOException e) {
			e.printStackTrace();
		}

        if (success) {
        	logger.debug("Successfully changed working directory.");
        	return true;
        } else {
        	logger.debug("Failed to change working directory. See server's reply.");
        	return false;
        }
	}
	
	private void upload(FTPFile ftpFile) {
		isUploading = true;
		connect();
		try {
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
			showServerReply(ftpClient);
			File inputLocalFile = new File(ftpFile.getInputFile());
			InputStream inputStream = new FileInputStream(inputLocalFile);

			logger.debug("Start uploading " + ftpFile.getInputFile() + " start");
			OutputStream outputStream = ftpClient.storeFileStream(ftpFile.getOutputFile());
			byte[] bytesIn = new byte[4096];
			int read = 0;

			while ((read = inputStream.read(bytesIn)) != -1) {
				outputStream.write(bytesIn, 0, read);
			}
			inputStream.close();
			outputStream.close();

			boolean completed = ftpClient.completePendingCommand();
			showServerReply(ftpClient);
			changeWorkingDirectory("/");
			if (completed) {
				uploadQueue.remove(ftpFile);
				successList.add(ftpFile);
				logger.debug("The " + ftpFile.getInputFile() + " file is uploaded successfully.");
			} else {
				uploadQueue.remove(ftpFile);
				failList.add(ftpFile);
				logger.debug("The " + ftpFile.getInputFile() + " file is uploaded fail.");
			}
			if (!uploadQueue.isEmpty()) {
				upload(uploadQueue.get(0));
			}
		} catch (SocketException e) {
			ftpClient = null;
			upload(ftpFile);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (ftpClient != null)
				ftpClient.disconnect();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ftpClient = null;
		isUploading = false;
	}

	public void addUploadQueue(FTPFile ftpFile) {
		logger.debug("add" + ftpFile.getInputFile());
        uploadQueue.add(ftpFile);
        if (!isUploading) {
        	upload(ftpFile);
        }
	}
	
	public synchronized void clearList(FTPFile ftpFile) {
		successList.remove(ftpFile);
		failList.remove(ftpFile);
	}
	
	public UploadStatus checkStatus(FTPFile ftpFile) {
		if (uploadQueue.contains(ftpFile)) {
			return UploadStatus.NOT_YET;
		}
		else if (successList.contains(ftpFile)) {
			return UploadStatus.SUCCESS;
		}
		else if (failList.contains(ftpFile)) {
			return UploadStatus.FAIL;
		}
		else {
			logger.debug("please check upload, success, fail list");
			return UploadStatus.NOT_YET;
		}
	}
	
	public boolean disconnect() {
		if (ftpClient != null) {
			try {
				if (ftpClient.isConnected()) {
					ftpClient.logout();
				}
				ftpClient.disconnect();
				return true;
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
		}
		return false;
	}

}
