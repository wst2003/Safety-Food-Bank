package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;

public class CommodityPriceCurveEntityPK implements Serializable {
    @Column(name = "COM_PC_TIME")
    @Id
      
    private Date comPcTime;
    @Column(name = "COM_ID")
    @Id
      
    private int comId;

    public Date getComPcTime() {
        return comPcTime;
    }

    public void setComPcTime(Date comPcTime) {
        this.comPcTime = comPcTime;
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
        CommodityPriceCurveEntityPK that = (CommodityPriceCurveEntityPK) o;
        return comId == that.comId && Objects.equals(comPcTime, that.comPcTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comPcTime, comId);
    }
}
