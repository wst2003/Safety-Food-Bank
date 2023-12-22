package cn.tju.sse.spring_backend.dto.cus.search.mapper;

import cn.tju.sse.spring_backend.dto.cus.search.StoEleDTO;
import cn.tju.sse.spring_backend.dto.cus.search.StoreListResponseDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface StoListMapper {
    StoListMapper INSTANCE = Mappers.getMapper(StoListMapper.class);

    @Mapping(target = "sto_id", source = "sto_id")  // no explicitly
    @Mapping(target = "sto_name", source = "sto_name")
    @Mapping(target = "sto_introduction", source = "sto_introduction")
    @Mapping(target = "com_categories", source = "com_categories")
    @Mapping(target = "user_address", source = "user_address")
    @Mapping(target = "sto_firstImage", source = "sto_firstImage")
    StoreListResponseDTO.StoDTO EleToDTO(StoEleDTO stoEleDTO);
}
