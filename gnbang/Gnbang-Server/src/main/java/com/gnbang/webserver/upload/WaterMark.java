package com.gnbang.webserver.upload;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;


public class WaterMark {

	private static String watermark1 = "watermark_center.png";
	private static String watermark2 = "watermark_right_bottom.png";

	public static boolean addImageWatermark(File sourceImageFile, File destImageFile, String watermarkDir) {
		try {
			BufferedImage sourceImage = ImageIO.read(sourceImageFile);
			BufferedImage watermarkImage1 = ImageIO.read(new File(watermarkDir + watermark1));
			BufferedImage watermarkImage2 = ImageIO.read(new File(watermarkDir + watermark2));

			Graphics2D g2d = (Graphics2D) sourceImage.getGraphics();
			AlphaComposite alphaChannel = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 1f);
			g2d.setComposite(alphaChannel);
			
			int topLeftX = (sourceImage.getWidth() - watermarkImage1.getWidth()) / 2;
			int topLeftY = (sourceImage.getHeight() - watermarkImage1.getHeight()) / 2;
			
			g2d.drawImage(watermarkImage1, topLeftX, topLeftY, null);
			
			topLeftX = sourceImage.getWidth() - watermarkImage2.getWidth() - 20;
			topLeftY = sourceImage.getHeight() - watermarkImage2.getHeight() - 20;
			g2d.drawImage(watermarkImage2, topLeftX, topLeftY, null);
			ImageIO.write(sourceImage, "jpg", destImageFile);
			g2d.dispose();		
			return true;
		}
		catch (IOException e) {
			return false;
		}
	}
}
