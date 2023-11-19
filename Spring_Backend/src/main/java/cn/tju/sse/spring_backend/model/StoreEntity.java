package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "STORE", schema = "food_bank", catalog = "")
public class StoreEntity {
      
    @Id
    @Column(name = "STO_ID")
    private int stoId;
    @Basic
    @Column(name = "STO_NAME")
    private String stoName;
    @Basic
    @Column(name = "STO_INTRODUCTION")
    private String stoIntroduction;
    @Basic
    @Column(name = "STO_LICENSEIMG")
    private String stoLicenseimg;
    @Basic
    @Column(name = "STO_STATE")
    private int stoState;

    public int getStoId() {
        return stoId;
    }

    public void setStoId(int stoId) {
        this.stoId = stoId;
    }

    public String getStoName() {
        return stoName;
    }

    public void setStoName(String stoName) {
        this.stoName = stoName;
    }

    public String getStoIntroduction() {
        return stoIntroduction;
    }

    public void setStoIntroduction(String stoIntroduction) {
        this.stoIntroduction = stoIntroduction;
    }

    public String getStoLicenseimg() {
        return stoLicenseimg;
    }

    public void setStoLicenseimg(String stoLicenseimg) {
        this.stoLicenseimg = stoLicenseimg;
    }

    public int getStoState() {
        return stoState;
    }

    public void setStoState(int stoState) {
        this.stoState = stoState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StoreEntity that = (StoreEntity) o;
        return stoId == that.stoId && stoState == that.stoState && Objects.equals(stoName, that.stoName) && Objects.equals(stoIntroduction, that.stoIntroduction) && Objects.equals(stoLicenseimg, that.stoLicenseimg);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stoId, stoName, stoIntroduction, stoLicenseimg, stoState);
    }
}
