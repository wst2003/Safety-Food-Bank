package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "CUSTOMER_LOVE", schema = "food_bank", catalog = "")
@IdClass(CustomerLoveEntityPK.class)
public class CustomerLoveEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "CUS_ID")
    private int cusId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_CATEGORY")
    private String comCategory;
    @Basic
    @Column(name = "CUS_LOVE_WEIGHT")
    private int cusLoveWeight;
    @ManyToOne
    @JoinColumn(name = "CUS_ID", referencedColumnName = "CUS_ID", nullable = false)
    private CustomerEntity customerByCusId;
    @ManyToOne
    @JoinColumn(name = "COM_CATEGORY", referencedColumnName = "COM_CATEGORY", nullable = false)
    private CommoditiesCategoriesEntity commoditiesCategoriesByComCategory;

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

    public int getCusLoveWeight() {
        return cusLoveWeight;
    }

    public void setCusLoveWeight(int cusLoveWeight) {
        this.cusLoveWeight = cusLoveWeight;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerLoveEntity that = (CustomerLoveEntity) o;
        return cusId == that.cusId && cusLoveWeight == that.cusLoveWeight && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cusId, comCategory, cusLoveWeight);
    }

    public CustomerEntity getCustomerByCusId() {
        return customerByCusId;
    }

    public void setCustomerByCusId(CustomerEntity customerByCusId) {
        this.customerByCusId = customerByCusId;
    }

    public CommoditiesCategoriesEntity getCommoditiesCategoriesByComCategory() {
        return commoditiesCategoriesByComCategory;
    }

    public void setCommoditiesCategoriesByComCategory(CommoditiesCategoriesEntity commoditiesCategoriesByComCategory) {
        this.commoditiesCategoriesByComCategory = commoditiesCategoriesByComCategory;
    }
}
