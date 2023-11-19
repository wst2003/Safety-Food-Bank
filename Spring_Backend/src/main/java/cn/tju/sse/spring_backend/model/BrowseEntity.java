package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "BROWSE", schema = "food_bank", catalog = "")
@IdClass(BrowseEntityPK.class)
public class BrowseEntity {
      
    @Id
    @Column(name = "BRO_TIME_START")
    private Timestamp broTimeStart;
    @Basic
    @Column(name = "BRO_TIME_END")
    private Timestamp broTimeEnd;
      
    @Id
    @Column(name = "COM_ID")
    private int comId;
      
    @Id
    @Column(name = "BROWSER_ID")
    private int browserId;
    @Basic
    @Column(name = "WHETHER_BUY")
    private Integer whetherBuy;

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

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
        this.comId = comId;
    }

    public int getBrowserId() {
        return browserId;
    }

    public void setBrowserId(int browserId) {
        this.browserId = browserId;
    }

    public Integer getWhetherBuy() {
        return whetherBuy;
    }

    public void setWhetherBuy(Integer whetherBuy) {
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
}
