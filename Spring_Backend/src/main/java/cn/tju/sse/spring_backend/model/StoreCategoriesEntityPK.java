package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class StoreCategoriesEntityPK implements Serializable {
    @Column(name = "STORE_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int storeId;
    @Column(name = "COM_CATEGORY")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
        StoreCategoriesEntityPK that = (StoreCategoriesEntityPK) o;
        return storeId == that.storeId && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(storeId, comCategory);
    }
}
