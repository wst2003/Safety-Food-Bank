package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "SCREENSHOT", schema = "food_bank", catalog = "")
@IdClass(ScreenshotEntityPK.class)
public class ScreenshotEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "APP_ID")
    private int appId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "SCT_IMAGE")
    private String sctImage;
    @ManyToOne
    @JoinColumn(name = "APP_ID", referencedColumnName = "APP_ID", nullable = false)
    private AppealEntity appealByAppId;

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

    public AppealEntity getAppealByAppId() {
        return appealByAppId;
    }

    public void setAppealByAppId(AppealEntity appealByAppId) {
        this.appealByAppId = appealByAppId;
    }
}
