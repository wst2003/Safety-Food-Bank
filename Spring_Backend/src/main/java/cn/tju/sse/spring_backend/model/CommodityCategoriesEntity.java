package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "COMMODITY_CATEGORIES", schema = "food_bank", catalog = "")
@IdClass(CommodityCategoriesEntityPK.class)
public class CommodityCategoriesEntity {
      
    @Id
    @Column(name = "COM_ID")
    private int comId;
      
    @Id
    @Column(name = "COM_CATEGORY")
    private String comCategory;

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
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
        CommodityCategoriesEntity that = (CommodityCategoriesEntity) o;
        return comId == that.comId && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, comCategory);
    }
}
