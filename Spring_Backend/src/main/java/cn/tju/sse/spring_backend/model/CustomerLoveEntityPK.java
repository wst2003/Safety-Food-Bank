package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class CustomerLoveEntityPK implements Serializable {
    @Column(name = "CUS_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cusId;
    @Column(name = "COM_CATEGORY")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String comCategory;

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
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
        CustomerLoveEntityPK that = (CustomerLoveEntityPK) o;
        return cusId == that.cusId && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cusId, comCategory);
    }
}
