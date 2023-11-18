package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "COMMODITIES_CATEGORIES", schema = "food_bank", catalog = "")
public class CommoditiesCategoriesEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_CATEGORY")
    private String comCategory;
    @OneToMany(mappedBy = "commoditiesCategoriesByComCategory")
    private Collection<CommodityCategoriesEntity> commodityCategoriesByComCategory;
    @OneToMany(mappedBy = "commoditiesCategoriesByComCategory")
    private Collection<CustomerLoveEntity> customerLovesByComCategory;
    @OneToMany(mappedBy = "commoditiesCategoriesByComCategory")
    private Collection<StoreCategoriesEntity> storeCategoriesByComCategory;

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
        CommoditiesCategoriesEntity that = (CommoditiesCategoriesEntity) o;
        return Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comCategory);
    }

    public Collection<CommodityCategoriesEntity> getCommodityCategoriesByComCategory() {
        return commodityCategoriesByComCategory;
    }

    public void setCommodityCategoriesByComCategory(Collection<CommodityCategoriesEntity> commodityCategoriesByComCategory) {
        this.commodityCategoriesByComCategory = commodityCategoriesByComCategory;
    }

    public Collection<CustomerLoveEntity> getCustomerLovesByComCategory() {
        return customerLovesByComCategory;
    }

    public void setCustomerLovesByComCategory(Collection<CustomerLoveEntity> customerLovesByComCategory) {
        this.customerLovesByComCategory = customerLovesByComCategory;
    }

    public Collection<StoreCategoriesEntity> getStoreCategoriesByComCategory() {
        return storeCategoriesByComCategory;
    }

    public void setStoreCategoriesByComCategory(Collection<StoreCategoriesEntity> storeCategoriesByComCategory) {
        this.storeCategoriesByComCategory = storeCategoriesByComCategory;
    }
}
