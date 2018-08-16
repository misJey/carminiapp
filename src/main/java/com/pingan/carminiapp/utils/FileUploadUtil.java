package com.pingan.carminiapp.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author 作者 : 舒
 * @date 创建时间：2018年8月6日 下午3:21:52
 * @version 1.0
 * @since JDK1.8
 * @Description (这里用一句话描述这个类的作用)
 */
public class FileUploadUtil {
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年8月6日 下午3:23:13
	 * @version 1.0
	 * @since JDK1.8
	 * @param file
	 * @return
	 * String 
	 * @Description 上传图片到临时目录下
	 */
	public static String writeUploadFile(MultipartFile file,HttpServletRequest request) {
        String filename = file.getOriginalFilename();
        //String realpath = request.getSession().getServletContext().getRealPath("/");
        //临时目录与正式目录存在检查
        String realpath = "C://tempfile//";
        String realpath2 = "C://img//";
        File fileDir = new File(realpath);
        File fileDir2 = new File(realpath2);
        if (!fileDir.exists())
            fileDir.mkdirs();
        if (!fileDir2.exists())
        	fileDir2.mkdirs();
 
        String extname = FilenameUtils.getExtension(filename);
        String allowImgFormat = "gif,jpg,jpeg,png";
        if (!allowImgFormat.contains(extname.toLowerCase())) {
            return "NOT_IMAGE";
        }
         
        filename = UUID.randomUUID().toString().replace("-", "")+"."+extname;//Math.abs(file.getOriginalFilename().hashCode()) + RandomUtils.createRandomString( 4 ) + "." + extname;
        InputStream input = null;
        FileOutputStream fos = null;
        try {
            input = file.getInputStream();
            fos = new FileOutputStream(realpath + filename);
            IOUtils.copy(input, fos);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            IOUtils.closeQuietly(input);
            IOUtils.closeQuietly(fos);
        }
        return filename;
    }
	
	/**
	 * 
	 * @author 作者 : 舒
	 * @date 创建时间：2018年8月6日 下午4:25:55
	 * @version 1.0
	 * @since JDK1.8
	 * @param filename
	 * @return
	 * boolean 
	 * @Description 将临时目录下的图片复制到正式目录下
	 */
	public static boolean saveFile(String imageNew,String imageOld,HttpServletRequest request){
		boolean flag = false;
		if("noupdate".equals(imageOld)){
			return false;//没有上传新的图片
		}
		InputStream fis = null;
//		String path = request.getSession().getServletContext().getRealPath("");
//		String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(new File("C://tempfile//"+imageNew));
			if(StringUtils.isNotEmpty(imageOld)){
				fos = new FileOutputStream(new File("C://img//"+imageOld));//更新图片，覆盖原有图上但名称不变
			}else{
				fos = new FileOutputStream(new File("C://img//"+imageNew));//新增
			}
			byte[] read = new byte[1024];
	        int len = 0;
	        while((len = fis.read(read))!= -1){
	            fos.write(read,0,len);
	        }
	        flag = true;
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				fis.close();
				fos.flush();
		        fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return flag;
	}
}
