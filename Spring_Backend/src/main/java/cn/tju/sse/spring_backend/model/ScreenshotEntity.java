package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "SCREENSHOT", schema = "food_bank", catalog = "")
@IdClass(ScreenshotEntityPK.class)
public class ScreenshotEntity {
      
    @Id
    @Column(name = "APP_ID")
    private int appId;
      
    @Id
    @Column(name = "SCT_IMAGE")
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
        ScreenshotEntity that = (ScreenshotEntity) o;
        return appId == that.appId && Objects.equals(sctImage, that.sctImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(appId, sctImage);
    }
}
