package cn.tju.sse.spring_backend;

import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class SpringBackendApplicationTests {

    @Test
    void contextLoads() {
        System.out.println(ObsOperationTool.createFolder("","test"));
        System.out.println(ObsOperationTool.uploadFile("test/","5.jpg","C:\\Users\\Administrator\\Pictures\\5.jpg"));
        System.out.println(ObsOperationTool.createFolder("test/","1"));
        System.out.println(ObsOperationTool.isObjectPathExist("test/"));
        System.out.println(ObsOperationTool.getObjectnamesInFolder("",true));
        System.out.println(ObsOperationTool.deleteObject("test","1",true));
        System.out.println(ObsOperationTool.getObjectnamesInFolder("",false));
    }

}
