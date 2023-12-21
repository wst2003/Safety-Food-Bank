package cn.tju.sse.spring_backend.service.cus.search;


import cn.tju.sse.spring_backend.dto.cus.search.GetLocationSortRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.search.GetLocationSortResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.search.SendLocationRepositoryDTO;
import cn.tju.sse.spring_backend.dto.cus.search.SendLocationResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.GetMessageResponseDTO;
import cn.tju.sse.spring_backend.repository.cus.search.LocationRepository;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author lhx
 * @date 2023/12/20
 * @Description 统一管理地理位置排序的服务类
 */
@Service
public class LocationService {
    @Autowired
    private LocationRepository locationRepository;

    /**
     * @author lhx
     * @date 2023/12/20
     * @Description sendLocationServeice
     */
    public SendLocationResponseDTO sendLocation(){
        List<Object[]> items=  locationRepository.getStoreAddresses();
        System.out.println(items);
        SendLocationResponseDTO sendLocationResponseDTO=new SendLocationResponseDTO();
        ArrayList<SendLocationRepositoryDTO> list=new ArrayList<>();
        for (Object[] item:items){
            SendLocationRepositoryDTO sendLocationRepositoryDTO=new SendLocationRepositoryDTO();
            sendLocationRepositoryDTO.setSto_id((Integer)item[0]);
            sendLocationRepositoryDTO.setSto_address((String) item[1]);
            list.add(sendLocationRepositoryDTO);

        }
        sendLocationResponseDTO.setAddress_list(list);
        return sendLocationResponseDTO;
    }

    /**
     * @author lhx
     * @date 2023/12/20
     * @Description getLocationSortServeice
     */
    public GetLocationSortResponseDTO getLocationSort(GetLocationSortRequestDTO request) throws IOException {
        String userID = String.valueOf(request.getUser_id());
        GetLocationSortResponseDTO response=new GetLocationSortResponseDTO();

        String directoryPath = "NearbySto";
        File directory = new File(directoryPath);
        if (!directory.exists()) {
            directory.mkdirs(); // 如果目录不存在，则创建
        }

        String fileName="nearbysto"+userID+".txt";
        File localFile = new File(directory, fileName);
        // 写入文件
        try (OutputStream outputStream = new FileOutputStream(localFile)) {
            for (int item : request.getSto_id()) {
                byte[] bytes = Integer.toString(item).getBytes();
                outputStream.write(bytes);
                outputStream.write('\n');
            }
            System.out.println("商店远近排序文件已保存在本地");
        } catch (IOException e) {
            e.printStackTrace();
            response.setMsg("文件写入出现错误");
            return response;
        }

        response.setMsg("success");
        return response;
    }
}
