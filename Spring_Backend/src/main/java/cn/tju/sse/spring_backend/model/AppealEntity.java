package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "APPEAL", schema = "food_bank", catalog = "")
public class AppealEntity {
      
    @Id
    @Column(name = "APP_ID")
    private int appId;
    @Basic
    @Column(name = "APP_MATTERS")
    private Integer appMatters;
    @Basic
    @Column(name = "APP_CONTENT")
    private String appContent;
    @Basic
    @Column(name = "USER_ID")
    private Integer userId;
    @Basic
    @Column(name = "COM_ID")
    private Integer comId;
    @Basic
    @Column(name = "CMT_ID")
    private Integer cmtId;
    @Basic
    @Column(name = "APP_USERID")
    private Integer appUserid;
    @Basic
    @Column(name = "APP_TIME")
    private Date appTime;

    public int getAppId() {
        return appId;
    }

    public void setAppId(int appId) {
        this.appId = appId;
    }

    public Integer getAppMatters() {
        return appMatters;
    }

    public void setAppMatters(Integer appMatters) {
        this.appMatters = appMatters;
    }

    public String getAppContent() {
        return appContent;
    }

    public void setAppContent(String appContent) {
        this.appContent = appContent;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getComId() {
        return comId;
    }

    public void setComId(Integer comId) {
        this.comId = comId;
    }

    public Integer getCmtId() {
        return cmtId;
    }

    public void setCmtId(Integer cmtId) {
        this.cmtId = cmtId;
    }

    public Integer getAppUserid() {
        return appUserid;
    }

    public void setAppUserid(Integer appUserid) {
        this.appUserid = appUserid;
    }

    public Date getAppTime() {
        return appTime;
    }

    public void setAppTime(Date appTime) {
        this.appTime = appTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AppealEntity that = (AppealEntity) o;
        return appId == that.appId && Objects.equals(appMatters, that.appMatters) && Objects.equals(appContent, that.appContent) && Objects.equals(userId, that.userId) && Objects.equals(comId, that.comId) && Objects.equals(cmtId, that.cmtId) && Objects.equals(appUserid, that.appUserid) && Objects.equals(appTime, that.appTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(appId, appMatters, appContent, userId, comId, cmtId, appUserid, appTime);
    }
}
