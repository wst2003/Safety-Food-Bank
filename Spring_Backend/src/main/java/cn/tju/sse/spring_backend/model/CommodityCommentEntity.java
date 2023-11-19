package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "COMMODITY_COMMENT", schema = "food_bank", catalog = "")
public class CommodityCommentEntity {
      
    @Id
    @Column(name = "CMT_ID")
    private int cmtId;
    @Basic
    @Column(name = "CMT_FATHER")
    private int cmtFather;
    @Basic
    @Column(name = "CMT_CONTENT")
    private String cmtContent;
    @Basic
    @Column(name = "CMT_TIME")
    private Date cmtTime;
    @Basic
    @Column(name = "COM_ID")
    private int comId;
    @Basic
    @Column(name = "USER_ID")
    private int userId;

    public int getCmtId() {
        return cmtId;
    }

    public void setCmtId(int cmtId) {
        this.cmtId = cmtId;
    }

    public int getCmtFather() {
        return cmtFather;
    }

    public void setCmtFather(int cmtFather) {
        this.cmtFather = cmtFather;
    }

    public String getCmtContent() {
        return cmtContent;
    }

    public void setCmtContent(String cmtContent) {
        this.cmtContent = cmtContent;
    }

    public Date getCmtTime() {
        return cmtTime;
    }

    public void setCmtTime(Date cmtTime) {
        this.cmtTime = cmtTime;
    }

    public int getComId() {
        return comId;
    }

    public void setComId(int comId) {
        this.comId = comId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CommodityCommentEntity that = (CommodityCommentEntity) o;
        return cmtId == that.cmtId && cmtFather == that.cmtFather && comId == that.comId && userId == that.userId && Objects.equals(cmtContent, that.cmtContent) && Objects.equals(cmtTime, that.cmtTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cmtId, cmtFather, cmtContent, cmtTime, comId, userId);
    }
}
