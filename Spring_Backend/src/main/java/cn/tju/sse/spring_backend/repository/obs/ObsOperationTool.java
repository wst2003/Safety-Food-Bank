package cn.tju.sse.spring_backend.repository.obs;
import com.obs.services.ObsClient;
import com.obs.services.model.*;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;

/**
 * OBS操作类。注意根目录的表示直接为空字符串即可，而不是"/"
 */
public class ObsOperationTool {
    private static String ak = "YVZNNRPETVTV5AQPFLUA";
    private static String sk = "Wtwq1MaRwItbgQ28vtkvVB59NNIheTRxCYxVJ6BB";

    private static String endPoint = "obs.cn-east-3.myhuaweicloud.com";

    private static ObsClient obsClient = new ObsClient(ak, sk,endPoint);

    /**
     * 判断对象是否存在
     * @param objectPath 对象路径
     * @return 该路径是否存在
     */
    public static boolean isObjectPathExist(String objectPath){
        return obsClient.doesObjectExist("food-bank",objectPath);
    }

    /**
     * 在指定位置创建文件夹
     * @param parentFolderPath 目标父文件夹
     * @param folderName 目标文件夹名称
     * @return 是否创建成功
     */
    public static boolean createFolder(String parentFolderPath,String folderName){
        if (!parentFolderPath.endsWith("/") && !parentFolderPath.isEmpty()) {
            parentFolderPath += "/";
        }
        if(!isObjectPathExist(parentFolderPath) && !parentFolderPath.isEmpty()){
            System.out.println("父文件夹不存在!");
            return false;
        }

        if (!folderName.endsWith("/")) {
            folderName += "/";
        }
        String newFolderPath = parentFolderPath+folderName;
        if(isObjectPathExist(newFolderPath)){
            System.out.println(newFolderPath);
            System.out.println("文件夹已经存在!");
            return false;
        }
        PutObjectResult result = obsClient.putObject("food-bank",newFolderPath,new ByteArrayInputStream(new byte[0]));
        if(result.getStatusCode()==200) return true;
        else{
            System.out.println("文件夹创建失败！");
            return false;
        }
    }

    /**
     * 上传网络流（如从前端接到的数据流）作为文件保存
     * @param parentFolderPath 目标文件夹
     * @param objectName 目标文件名
     * @param inputStream 网络流
     * @return 是否上传成功
     */
    public static boolean uploadInputStream(String parentFolderPath, String objectName, InputStream inputStream){
        if (!parentFolderPath.endsWith("/") && !parentFolderPath.isEmpty()) {
            parentFolderPath += "/";
        }
        if(!isObjectPathExist(parentFolderPath) && !parentFolderPath.isEmpty()){
            System.out.println("父文件夹不存在!");
            return false;
        }
        if (objectName.endsWith("/")) {
            objectName = objectName.substring(0,objectName.length()-1);
        }
        String objectPath = parentFolderPath+objectName;
        if(isObjectPathExist(objectPath)){
            System.out.println("文件已经存在!");
            return false;
        }
        PutObjectResult result = obsClient.putObject("food-bank",objectPath,inputStream);
        if(result.getStatusCode()==200) return true;
        else{
            System.out.println("文件上传失败！");
            return false;
        }
    }

    /**
     * 上传本地文件
     * @param parentFolderPath 目标文件夹
     * @param objectName 目标文件名
     * @param filePath 本地文件名
     * @return 是否上传成功
     */
    public static boolean uploadFile(String parentFolderPath, String objectName, String filePath){
        if (!parentFolderPath.endsWith("/") && !parentFolderPath.isEmpty()) {
            parentFolderPath += "/";
        }
        if(!isObjectPathExist(parentFolderPath) && !parentFolderPath.isEmpty()){
            System.out.println("父文件夹不存在!");
            return false;
        }
        if (objectName.endsWith("/")) {
            objectName = objectName.substring(0,objectName.length()-1);
        }
        String objectPath = parentFolderPath+objectName;
        if(isObjectPathExist(objectPath)){
            System.out.println("文件已经存在!");
            return false;
        }
        PutObjectResult result = obsClient.putObject("food-bank",objectPath,new File(filePath));
        if(result.getStatusCode()==200) return true;
        else{
            System.out.println("文件上传失败！");
            return false;
        }
    }

    /**
     * 列举文件夹下所有对象名称
     * @param folderPath 要列举的文件夹名称
     * @param recursive 是否递归列举
     * @return 该文件夹下所有对象名称
     */
    public static ArrayList<String> getObjectnamesInFolder(String folderPath,boolean recursive){
        if (!folderPath.endsWith("/") && !folderPath.isEmpty()) {
            folderPath += "/";
        }
        if(!isObjectPathExist(folderPath) && !folderPath.isEmpty()){
            System.out.println("父文件夹不存在!");
            return null;
        }
        ListObjectsRequest request = new ListObjectsRequest("food-bank");
        // 设置文件夹对象名为前缀
        request.setPrefix(folderPath);
        request.setMaxKeys(1000);

        ObjectListing result;
        ArrayList<String> objectNameList = new ArrayList<>();
        do{
            result = obsClient.listObjects(request);
            for (ObsObject obsObject : result.getObjects())
            {
                if(recursive){
                    if(!obsObject.getObjectKey().equals(folderPath)) objectNameList.add(obsObject.getObjectKey());
                }
                else{
                    if(obsObject.getObjectKey().split("/").length == (folderPath.isEmpty()?1: folderPath.split("/").length+1 )){
                        objectNameList.add(obsObject.getObjectKey());
                    }
                }
            }
            String t = result.getNextMarker();
            request.setMarker(t);
        }while(result.isTruncated());
        return objectNameList;
    }

    /**
     * 删除对象（文件夹或者文件）
     * @param parentFolderPath 父文件夹名称
     * @param objectName  对象名称
     * @param isFolder 该对象是否是文件夹（是则递归删除）
     * @return 是否删除成功
     */
    public static boolean deleteObject(String parentFolderPath, String objectName ,boolean isFolder){
        if (!parentFolderPath.endsWith("/") && !parentFolderPath.isEmpty()) {
            parentFolderPath += "/";
        }
        if(!isObjectPathExist(parentFolderPath) && !parentFolderPath.isEmpty()){
            System.out.println("父文件夹不存在!");
            return false;
        }
        if(isFolder&&!objectName.endsWith("/"))objectName+="/";
        String objectPath = parentFolderPath+objectName;
        if(!isObjectPathExist(objectPath)){
            System.out.println(objectPath);
            System.out.println("文件本就不存在!");
            return false;
        }
        DeleteObjectResult result;
        if(isFolder){
            ListObjectsRequest listObjectsRequest = new ListObjectsRequest("food-bank");
            listObjectsRequest.setPrefix(objectPath);

            // 列出文件夹中的所有对象
            ObjectListing objectListing = obsClient.listObjects(listObjectsRequest);
            for (ObsObject obsObject : objectListing.getObjects()) {
                // 删除每个对象
                obsClient.deleteObject("food-bank", obsObject.getObjectKey());
            }

            // 删除文件夹本身
            result = obsClient.deleteObject("food-bank", objectPath);
        }
        else{
            result = obsClient.deleteObject("food-bank",objectPath);
        }
        if(result.getStatusCode()==204) return true;
        else{
            System.out.println("文件删除失败！");
            return false;
        }
    }

    public static boolean moveObject(String srcPath, String dstPath){
        if(!isObjectPathExist(srcPath)){
            System.out.println(srcPath);
            System.out.println("文件本就不存在!");
            return false;
        }
        if(isObjectPathExist(dstPath)){
            System.out.println("文件已经存在!");
            return false;
        }
        PutObjectResult result = obsClient.putObject("food-bank",dstPath,obsClient.getObject("food-bank",srcPath).getObjectContent());
        if(result.getStatusCode()==200)
            return true;
        else{
            System.out.println("文件移动失败！");
            return false;
        }
    }
}

