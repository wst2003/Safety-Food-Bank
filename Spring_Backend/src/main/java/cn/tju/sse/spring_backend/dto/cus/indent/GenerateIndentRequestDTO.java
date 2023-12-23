package cn.tju.sse.spring_backend.dto.cus.indent;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class GenerateIndentRequestDTO {
    String cus_id;
    List<IndentsDTO> indent_arr;
    @Getter
    @Setter
    public static class IndentsDTO{
        String sto_id;
        String ind_notes;
        List <CommoditiesDTO> com_arr;
    }
    @Getter
    @Setter
    public static class CommoditiesDTO{
        String com_id;
        Integer ind_quantity;
        BigDecimal ind_money;
    }
}
