package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class CommodityCategoriesEntityPK implements Serializable {
    @Column(name = "COM_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long comId;
    @Column(name = "COM_CATEGORY")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String comCategory;

    public long getComId() {
        return comId;
    }

    public void setComId(long comId) {
        this.comId = comId;
    }

    public String getComCategory() {
        return comCategory;
    }

    public void setComCategory(String comCategory) {
        this.comCategory = comCategory;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommodityCategoriesEntityPK that = (CommodityCategoriesEntityPK) o;
        return comId == that.comId && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, comCategory);
    }
}
