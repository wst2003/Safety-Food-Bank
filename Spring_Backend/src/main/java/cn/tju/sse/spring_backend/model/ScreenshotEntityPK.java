package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class ScreenshotEntityPK implements Serializable {
    @Column(name = "APP_ID")
    @Id
      
    private int appId;
    @Column(name = "SCT_IMAGE")
    @Id
      
    private String sctImage;

    public int getAppId() {
        return appId;
    }

    public void setAppId(int appId) {
        this.appId = appId;
    }

    public String getSctImage() {
        return sctImage;
    }

    public void setSctImage(String sctImage) {
        this.sctImage = sctImage;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ScreenshotEntityPK that = (ScreenshotEntityPK) o;
        return appId == that.appId && Objects.equals(sctImage, that.sctImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(appId, sctImage);
    }
}
