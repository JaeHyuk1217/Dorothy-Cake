package com.dorothy.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUploadUtil {
	
	/**********************************************************************
	 * �뙆�씪 �뾽濡쒕뱶 �뤃�뜑 �깮�꽦
	 **********************************************************************/
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {
			return;
		}
		fileDir.mkdirs();
	}
	
	/*****************************************************************************
	 * �뙆�씪 �뾽濡쒕뱶 硫붿꽌�뱶
	 * �뙆�씪紐낆씠 以묐났�떆 �빐寃� 諛⑸쾿
	 * System.currentTimeMillis()瑜� �궗�슜�븯嫄곕굹 UUID�뒗 128鍮꾪듃�쓽 �닔�씠�떎.
	 * �몴以� �삎�떇�뿉�꽌 UUID�뒗 32媛쒖쓽 16吏꾩닔濡� �몴�쁽�릺硫� 珥� 36媛쒖쓽 臾몄옄(32媛� 臾몄옄�� 4媛쒖쓽 �븯�씠�뵂)�쑝濡�
	 * �맂 8-4-4-4-12 �씪�뒗 5媛쒖쓽 洹몃９�쓣 �븯�씠�뵂�쑝濡� 援щ텇�븳�떎. �씠瑜쇳뀒硫� �떎�쓬怨� 媛숇떎.
	 * �씠�븣 UUID.randomUUID().toString()瑜� �씠�슜�빐�꽌 �뼸�뒗�떎.
	 * 50e8400-e29b-41d4-a716-446655440000
	 *****************************************************************************/
	public static String fileUpload(MultipartFile file, String fileName) throws IOException{
		log.info("fileName �샇異� �꽦怨�");
		
		String real_name = null;
		//MultipartFile �겢�옒�뒪�쓽 getFile() 硫붿꽌�뱶濡� �겢�씪�씠�뼵�듃媛� �뾽濡쒕뱶�븳 �뙆�씪
		String org_name = file.getOriginalFilename();
		log.info("�뾽濡쒕뱶 �뙆�씪紐� : "+ org_name);
		
		// �뙆�씪紐� 蹂�寃�(以묐났�릺吏� �븡寃�)
		if(org_name != null && (!org_name.equals(""))) {
			real_name = fileName +"_"+System.currentTimeMillis()+"_"+ org_name; //���옣�븷 �뙆�씪 �씠由�
			
			String docRoot = "C://dorothyUpload//"+fileName;
			makeDir(docRoot);
			
			File fileAdd = new File(docRoot+"/"+real_name);
			log.info("�뾽濡쒕뱶�븷 �뙆�씪(fileAdd) : "+ fileAdd);
			
			file.transferTo(fileAdd); // �씠 硫붿꽌�뱶�뿉�쓽�빐 ���옣 寃쎈줈�뿉 �떎吏덉쟻�쑝濡� File�씠 �깮�꽦�맖
		}
		return real_name; // �꽌踰꾩뿉 ���옣�맂 �뙆�씪紐� 諛섑솚
	}
	
	/*********************************************************************************
	 * �뙆�씪 �궘�젣 硫붿꽌�뱶
	 * 寃쎈줈 諛� �뙆�씪紐� : board/board_1658205347977_cat.jpg
	 * Thumbnail 寃쎈줈 諛� �뙆�씪紐� : board/thumbnail/thumbnail_board_ 1658205347977_cat.jpg
	 *********************************************************************************/
	public static void fileDelete(String fileName) throws IOException{ // fileName = thumbnail_board_1658205347977_cat.jpg
		log.info("fileDelete �샇異� �꽦怨�");
		boolean result = false;
		String startDirName = "", docRoot = "";
		String dirName = fileName.substring(0, fileName.indexOf("_")); // dirName = thumbnail
		
		if(dirName.equals("thumbnail")) {
			startDirName = fileName.substring(dirName.length()+1, fileName.indexOf("_", dirName.length()+1)); // board
			docRoot = "C://dorothyUpload//"+startDirName+"//"+dirName; // G://uploadStorage//board//thumbnail
		}else {
			docRoot = "C://dorothyUpload//"+dirName; // docRoot = G://uploadStorage//board
		}
		
		File fileDelete = new File(docRoot+"/"+fileName); // G://uploadStorage//board
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("�뙆�씪 �궘�젣�뿬遺�(true/false) : " + result);
	}
	
	/**************************************************************************
	 * �뙆�씪 Tumbnail �깮�꽦 硫붿꽌�뱶
	 * Thumbnail 寃쎈줈 諛� �뙆�씪紐� : thumbnail/thumbnail_board_ 1658205347977_cat.jpg
	 **************************************************************************/
	public static String makeThumbnail(String fileName) throws Exception{ // fileName = board_ 1658205347977_cat.jpg
		String dirName = fileName.substring(0, fileName.indexOf("_")); // dirName = board
		//�씠誘몄�媛� 議댁옱�븯�뒗 �뤃�뜑 異붿텧
		String imgPath = "C://dorothyUpload//"+dirName;
		//異붿텧�맂 �뤃�뜑�쓽 �떎�젣 寃쎈줈(臾쇰━�쟻 �쐞移� : G:\...)
		File fileAdd = new File(imgPath, fileName); // G://uploadStorage//board//board_ 1658205347977_cat.jpg
		log.info("�썝蹂� �씠誘몄� �뙆�씪(fileAdd) : " + fileAdd);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd); // fileAdd�뿉 �빐�떦�븯�뒗 �씠誘몄� �뙆�씪�쓣 �씫�뼱���꽌 �뜲�씠�꽣濡� ���옣.
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 133);// �겕湲곕�� 議곗젙�븯�뿬 �씠誘몄� �뜲�씠�꽣 ���옣
								   // resize(���긽[BufferedImage ���엯]= �썝蹂몄씠誘몄�, �썝蹂몃퉬�쑉(媛�濡쒖꽭濡쒕퉬�쑉), �넂�씠 �삉�뒗 �꼫鍮�, �겕湲�)
		
		String thumbnailName = "thumbnail_"+ fileName; // thumbnail_board_ 1658205347977_cat.jpg
		String docRoot = imgPath+"/thumbnail"; // G://uploadStorage//board//thumbnail
		makeDir(docRoot); // �뤃�뜑 �깮�꽦�빐�씪�엵
		
		File newFile = new File(docRoot, thumbnailName); // G://uploadStorage//board//thumbnail//thumbnail_board_ 1658205347977_cat.jpg << �셿�꽦
		log.info("�뾽濡쒕뱶�븷 �뙆�씪(newFile) : " + newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1); // �솗�옣�옄: jpg
		log.info("�솗�옣�옄(formatName) : " + formatName);
		
		ImageIO.write(destImg, formatName, newFile); // 議곗젙�븳 �씠誘몄� �뜲�씠�꽣瑜� �깮�꽦�븳 �뙆�씪�뿉 ���옣.
		
		return thumbnailName; // �꽌踰꾩뿉 ���옣�맂 �뙆�씪紐� 諛섑솚(thumbnail_board_ 1658205347977_cat.jpg)
	}
}
