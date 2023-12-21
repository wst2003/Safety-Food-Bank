package cn.tju.sse.spring_backend.dto.cus.indent;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class GetIndentListResponseDTO {
    Integer total;
    List<IndentElementDTO> element_arr;

    @Setter
    @Getter
    public static class IndentElementDTO{
        String ind_creationTime;
        String ind_verificationCode;
        String ind_notes;
        Integer sto_id;
        String sto_name;
        List<IndentDTO> indent_arr;
    }
    @Setter
    @Getter
    public static class IndentDTO{
        Integer ind_ID;
        Integer ind_quantity;
        BigDecimal ind_money;
        double ind_rating;
        Integer com_ID;
        String ind_rtime;
        String ind_rmoney;
        String com_firstImg;
        String com_name;
    }

}

