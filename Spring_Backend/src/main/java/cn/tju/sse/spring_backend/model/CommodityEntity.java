package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "COMMODITY", schema = "food_bank", catalog = "")
public class CommodityEntity {
      
    @Id
    @Column(name = "COM_ID")
    private int comId;
    @Basic
    @Column(name = "COM_NAME")
    private String comName;
    @Basic
    @Column(name = "COM_INTRODUCTION")
    private String comIntroduction;
    @Basic
    @Column(name = "COM_EXPIRATIONDATE")
    private Date comExpirationdate;
    @Basic
    @Column(name = "COM_UPLOADDATE")
    private Date comUploaddate;
    @Basic
    @Column(name = "COM_LEFT")
    private int comLeft;
    @Basic
    @Column(name = "COM_RATING")
    private BigDecimal comRating;
    @Basic
    @Column(name = "STO_ID")
    private int stoId;
    @Basic
    @Column(name = "COM_ORIPRICE")
    private BigDecimal comOriprice;
    @Basic
    @Column(name = "COM_STATUS")
    private Integer comStatus;

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
        this.comId = comId;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getComIntroduction() {
        return comIntroduction;
    }

    public void setComIntroduction(String comIntroduction) {
        this.comIntroduction = comIntroduction;
    }

    public Date getComExpirationdate() {
        return comExpirationdate;
    }

    public void setComExpirationdate(Date comExpirationdate) {
        this.comExpirationdate = comExpirationdate;
    }

    public Date getComUploaddate() {
        return comUploaddate;
    }

    public void setComUploaddate(Date comUploaddate) {
        this.comUploaddate = comUploaddate;
    }

    public int getComLeft() {
        return comLeft;
    }

    public void setComLeft(int comLeft) {
        this.comLeft = comLeft;
    }

    public BigDecimal getComRating() {
        return comRating;
    }

    public void setComRating(BigDecimal comRating) {
        this.comRating = comRating;
    }

    public int getStoId() {
        return stoId;
    }

    public void setStoId(int stoId) {
        this.stoId = stoId;
    }

    public BigDecimal getComOriprice() {
        return comOriprice;
    }

    public void setComOriprice(BigDecimal comOriprice) {
        this.comOriprice = comOriprice;
    }

    public Integer getComStatus() {
        return comStatus;
    }

    public void setComStatus(Integer comStatus) {
        this.comStatus = comStatus;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommodityEntity that = (CommodityEntity) o;
        return comId == that.comId && comLeft == that.comLeft && stoId == that.stoId && Objects.equals(comName, that.comName) && Objects.equals(comIntroduction, that.comIntroduction) && Objects.equals(comExpirationdate, that.comExpirationdate) && Objects.equals(comUploaddate, that.comUploaddate) && Objects.equals(comRating, that.comRating) && Objects.equals(comOriprice, that.comOriprice) && Objects.equals(comStatus, that.comStatus);
    }

    @Override
    public int hashCode() {
        return Objects.hash(comId, comName, comIntroduction, comExpirationdate, comUploaddate, comLeft, comRating, stoId, comOriprice, comStatus);
    }
}
