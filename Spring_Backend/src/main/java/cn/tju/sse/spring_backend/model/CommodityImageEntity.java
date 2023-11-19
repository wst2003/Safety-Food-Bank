package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "COMMODITY_IMAGE", schema = "food_bank", catalog = "")
@IdClass(CommodityImageEntityPK.class)
public class CommodityImageEntity {
      
    @Id
    @Column(name = "COM_ID")
    private int comId;
      
    @Id
    @Column(name = "COM_IMAGE")
    private String comImage;

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
        this.comId = comId;
    }

    public String getComImage() {
        return comImage;
    }

    public void setComImage(String comImage) {
        this.comImage = comImage;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommodityImageEntity that = (CommodityImageEntity) o;
        return comId == that.comId && Objects.equals(comImage, that.comImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, comImage);
    }
}
