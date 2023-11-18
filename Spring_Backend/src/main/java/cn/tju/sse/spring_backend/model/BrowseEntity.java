package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "BROWSE", schema = "food_bank", catalog = "")
@IdClass(BrowseEntityPK.class)
public class BrowseEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "BRO_TIME_START")
    private Timestamp broTimeStart;
    @Basic
    @Column(name = "BRO_TIME_END")
    private Timestamp broTimeEnd;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_ID")
    private long comId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "BROWSER_ID")
    private int browserId;
    @Basic
    @Column(name = "WHETHER_BUY")
    private BigInteger whetherBuy;
    @ManyToOne
    @JoinColumn(name = "COM_ID", referencedColumnName = "COM_ID", nullable = false)
    private CommodityEntity commodityByComId;
    @ManyToOne
    @JoinColumn(name = "BROWSER_ID", referencedColumnName = "CUS_ID", nullable = false)
    private CustomerEntity customerByBrowserId;

    public Timestamp getBroTimeStart() {
        return broTimeStart;
    }

    public void setBroTimeStart(Timestamp broTimeStart) {
        this.broTimeStart = broTimeStart;
    }

    public Timestamp getBroTimeEnd() {
        return broTimeEnd;
    }

    public void setBroTimeEnd(Timestamp broTimeEnd) {
        this.broTimeEnd = broTimeEnd;
    }

    public long getComId() {
        return comId;
    }

    public void setComId(long comId) {
        this.comId = comId;
    }

    public int getBrowserId() {
        return browserId;
    }

    public void setBrowserId(int browserId) {
        this.browserId = browserId;
    }

    public BigInteger getWhetherBuy() {
        return whetherBuy;
    }

    public void setWhetherBuy(BigInteger whetherBuy) {
        this.whetherBuy = whetherBuy;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BrowseEntity that = (BrowseEntity) o;
        return comId == that.comId && browserId == that.browserId && Objects.equals(broTimeStart, that.broTimeStart) && Objects.equals(broTimeEnd, that.broTimeEnd) && Objects.equals(whetherBuy, that.whetherBuy);
    }

    @Override
    public int hashCode() {
        return Objects.hash(broTimeStart, broTimeEnd, comId, browserId, whetherBuy);
    }

    public CommodityEntity getCommodityByComId() {
        return commodityByComId;
    }

    public void setCommodityByComId(CommodityEntity commodityByComId) {
        this.commodityByComId = commodityByComId;
    }

    public CustomerEntity getCustomerByBrowserId() {
        return customerByBrowserId;
    }

    public void setCustomerByBrowserId(CustomerEntity customerByBrowserId) {
        this.customerByBrowserId = customerByBrowserId;
    }
}
