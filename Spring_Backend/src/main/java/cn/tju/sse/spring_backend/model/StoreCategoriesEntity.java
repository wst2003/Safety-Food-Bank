package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "STORE_CATEGORIES", schema = "food_bank", catalog = "")
@IdClass(StoreCategoriesEntityPK.class)
public class StoreCategoriesEntity {
      
    @Id
    @Column(name = "STORE_ID")
    private int storeId;
      
    @Id
    @Column(name = "COM_CATEGORY")
    private String comCategory;

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
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
        StoreCategoriesEntity that = (StoreCategoriesEntity) o;
        return storeId == that.storeId && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(storeId, comCategory);
    }
}
