package com.gnbang.webserver.upload;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;


public class ImageResizing {
	private final static Logger logger = LoggerFactory.getLogger(ImageResizing.class);

	final static float MAX_WIDTH = 1600f;
	final static float MAX_HEIGHT = 900f;
	
	enum Rotate{
		ROTATE_0,
		ROTATE_90_CW,
		ROTATE_180,
		ROTATE_270_CW,
		;
	}
	
	public void process(String inputFilename, String outputFilename) {
		if (!(inputFilename.contains(".jpg") || inputFilename.contains(".jpeg"))) {
			logger.debug("please use jpg files");
			return;
		}
		
		Rotate rotate = null;
		Image inImage = new ImageIcon(inputFilename).getImage();
		File jpegFile = new File(inputFilename);
		Metadata metadata;
		try {
			metadata = JpegMetadataReader.readMetadata(jpegFile);
			
			for (Directory directory : metadata.getDirectories()) {
				for (Tag tag : directory.getTags()) {
//					logger.debug("[" + directory.getName() + "] - " + tag.getTagName() + " = " + tag.getDescription());
					if (tag.getTagName().equalsIgnoreCase("orientation")) {
						if (tag.getDescription().contains("Rotate 90 CW")) {
							rotate = Rotate.ROTATE_90_CW;
						}
						else if (tag.getDescription().contains("Rotate 180")) {
							rotate = Rotate.ROTATE_180;
						}
						else if (tag.getDescription().contains("Rotate 270 CW")) {
							rotate = Rotate.ROTATE_270_CW;
						}
						else {
							rotate = Rotate.ROTATE_0;
						}
					}
				}
				if (directory.hasErrors()) {
					for (String error : directory.getErrors()) {
						logger.debug("ERROR: " + error);
					}
				}
			}

		} catch (JpegProcessingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		int width = inImage.getWidth(null);
		int height = inImage.getHeight(null);
//		logger.debug("input image width : " + width);
//		logger.debug("input image height : " + height);
		float resizeWidth, resizeHeight;
		
		if (rotate == Rotate.ROTATE_90_CW || rotate == Rotate.ROTATE_270_CW) {
			if (height > width) {
				logger.debug("Please Check");
				float ratio = MAX_WIDTH / height;
				resizeWidth = width * ratio;
				resizeHeight = height * ratio;
				
			} else {
				//check ok
				float ratio = MAX_HEIGHT/ width;
				resizeWidth = width * ratio;
				resizeHeight = height * ratio;
			}
		}  else {
			if (width > height) {
				//check ok
				float ratio = MAX_HEIGHT / height;
				resizeWidth = width * ratio;
				resizeHeight = height * ratio;
			} else {
				logger.debug("Please Check");
				float ratio = MAX_WIDTH/ height;
				resizeWidth = width * ratio;
				resizeHeight = height * ratio;
			}
		}
		
//		logger.debug("resize image width : " + resizeWidth);
//		logger.debug("resize image height : " + resizeHeight);
		BufferedImage outImage = createResizedCopy(inImage, (int) resizeWidth, (int) resizeHeight, true, rotate);
		try {
			ImageIO.write(outImage, "jpg", new File(outputFilename));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*
		OutputStream os = null;
		try {
			os = new FileOutputStream(outputFilename);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(outImage);
			jep.setQuality(1, true);
			encoder.encode(outImage);
			os.close();
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (ImageFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
	}

	static public BufferedImage createResizedCopy(Image originalImage, int scaledWidth, int scaledHeight,
			boolean preserveAlpha, Rotate rotate) {
		int imageType = preserveAlpha ? BufferedImage.TYPE_INT_RGB : BufferedImage.TYPE_INT_ARGB;
		BufferedImage scaledBI = null;
		if (rotate == Rotate.ROTATE_90_CW) {
			scaledBI = new BufferedImage(scaledHeight, scaledWidth, imageType);
		}
		else if (rotate == Rotate.ROTATE_180) {
			scaledBI = new BufferedImage(scaledWidth, scaledHeight, imageType);
		}
		else if (rotate == Rotate.ROTATE_270_CW) {
			scaledBI = new BufferedImage(scaledHeight, scaledWidth, imageType);
		}
		else {
			scaledBI = new BufferedImage(scaledWidth, scaledHeight, imageType);
		}
		Graphics2D g = scaledBI.createGraphics();
		if (rotate == Rotate.ROTATE_90_CW) {
			g.rotate(Math.toRadians(90));
			g.translate(0, -scaledHeight);
		}
		else if (rotate == Rotate.ROTATE_180) {
			g.rotate(Math.toRadians(180));
			g.translate(-scaledWidth, -scaledHeight);
		}
		else if (rotate == Rotate.ROTATE_270_CW) {
			g.rotate(Math.toRadians(270));
			g.translate(-scaledWidth, 0);
		}
		else {
			
		}
		if (preserveAlpha) {
			g.setComposite(AlphaComposite.Src);
		}
		g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
		g.dispose();
		return scaledBI;
	}

}
