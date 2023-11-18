package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "FAVORITE", schema = "food_bank", catalog = "")
@IdClass(FavoriteEntityPK.class)
public class FavoriteEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_ID")
    private long comId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "CUS_ID")
    private int cusId;
    @ManyToOne
    @JoinColumn(name = "COM_ID", referencedColumnName = "COM_ID", nullable = false)
    private CommodityEntity commodityByComId;
    @ManyToOne
    @JoinColumn(name = "CUS_ID", referencedColumnName = "CUS_ID", nullable = false)
    private CustomerEntity customerByCusId;

    public long getComId() {
        return comId;
    }

    public void setComId(long comId) {
        this.comId = comId;
    }

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FavoriteEntity that = (FavoriteEntity) o;
        return comId == that.comId && cusId == that.cusId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, cusId);
    }

    public CommodityEntity getCommodityByComId() {
        return commodityByComId;
    }

    public void setCommodityByComId(CommodityEntity commodityByComId) {
        this.commodityByComId = commodityByComId;
    }

    public CustomerEntity getCustomerByCusId() {
        return customerByCusId;
    }

    public void setCustomerByCusId(CustomerEntity customerByCusId) {
        this.customerByCusId = customerByCusId;
    }
}
