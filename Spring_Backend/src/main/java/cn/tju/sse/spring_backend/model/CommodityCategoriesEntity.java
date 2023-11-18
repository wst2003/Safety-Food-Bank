package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "COMMODITY_CATEGORIES", schema = "food_bank", catalog = "")
@IdClass(CommodityCategoriesEntityPK.class)
public class CommodityCategoriesEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_ID")
    private long comId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_CATEGORY")
    private String comCategory;
    @ManyToOne
    @JoinColumn(name = "COM_ID", referencedColumnName = "COM_ID", nullable = false)
    private CommodityEntity commodityByComId;
    @ManyToOne
    @JoinColumn(name = "COM_CATEGORY", referencedColumnName = "COM_CATEGORY", nullable = false)
    private CommoditiesCategoriesEntity commoditiesCategoriesByComCategory;

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
        CommodityCategoriesEntity that = (CommodityCategoriesEntity) o;
        return comId == that.comId && Objects.equals(comCategory, that.comCategory);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, comCategory);
    }

    public CommodityEntity getCommodityByComId() {
        return commodityByComId;
    }

    public void setCommodityByComId(CommodityEntity commodityByComId) {
        this.commodityByComId = commodityByComId;
    }

    public CommoditiesCategoriesEntity getCommoditiesCategoriesByComCategory() {
        return commoditiesCategoriesByComCategory;
    }

    public void setCommoditiesCategoriesByComCategory(CommoditiesCategoriesEntity commoditiesCategoriesByComCategory) {
        this.commoditiesCategoriesByComCategory = commoditiesCategoriesByComCategory;
    }
}
