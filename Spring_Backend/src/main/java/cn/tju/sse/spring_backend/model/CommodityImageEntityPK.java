package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class CommodityImageEntityPK implements Serializable {
    @Column(name = "COM_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long comId;
    @Column(name = "COM_IMAGE")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String comImage;

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
        CommodityImageEntityPK that = (CommodityImageEntityPK) o;
        return comId == that.comId && Objects.equals(comImage, that.comImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, comImage);
    }
}
