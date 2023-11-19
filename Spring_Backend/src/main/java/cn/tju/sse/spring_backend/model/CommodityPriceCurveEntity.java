package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "COMMODITY_PRICE_CURVE", schema = "food_bank", catalog = "")
@IdClass(CommodityPriceCurveEntityPK.class)
public class CommodityPriceCurveEntity {
      
    @Id
    @Column(name = "COM_PC_TIME")
    private Date comPcTime;
    @Basic
    @Column(name = "COM_PC_PRICE")
    private BigDecimal comPcPrice;
      
    @Id
    @Column(name = "COM_ID")
    private int comId;

    public Date getComPcTime() {
        return comPcTime;
    }

    public void setComPcTime(Date comPcTime) {
        this.comPcTime = comPcTime;
    }

    public BigDecimal getComPcPrice() {
        return comPcPrice;
    }

    public void setComPcPrice(BigDecimal comPcPrice) {
        this.comPcPrice = comPcPrice;
    }

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
        this.comId = comId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommodityPriceCurveEntity that = (CommodityPriceCurveEntity) o;
        return comId == that.comId && Objects.equals(comPcTime, that.comPcTime) && Objects.equals(comPcPrice, that.comPcPrice);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comPcTime, comPcPrice, comId);
    }
}
