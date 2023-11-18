package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "COMMODITY_IMAGE", schema = "food_bank", catalog = "")
@IdClass(CommodityImageEntityPK.class)
public class CommodityImageEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_ID")
    private long comId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_IMAGE")
    private String comImage;
    @ManyToOne
    @JoinColumn(name = "COM_ID", referencedColumnName = "COM_ID", nullable = false)
    private CommodityEntity commodityByComId;

    public long getComId() {
        return comId;
    }

    public void setComId(long comId) {
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

    public CommodityEntity getCommodityByComId() {
        return commodityByComId;
    }

    public void setCommodityByComId(CommodityEntity commodityByComId) {
        this.commodityByComId = commodityByComId;
    }
}
