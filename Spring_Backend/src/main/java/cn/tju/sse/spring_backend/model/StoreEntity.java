package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigInteger;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "STORE", schema = "food_bank", catalog = "")
public class StoreEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    private BigInteger stoState;
    @OneToMany(mappedBy = "storeByStoreId")
    private Collection<ChatEntity> chatsByStoId;
    @OneToMany(mappedBy = "storeByStoId")
    private Collection<CommodityEntity> commoditiesByStoId;
    @OneToOne
    @JoinColumn(name = "STO_ID", referencedColumnName = "USER_ID", nullable = false)
    private UsersEntity usersByStoId;
    @OneToMany(mappedBy = "storeByStoId")
    private Collection<StoreimageEntity> storeimagesByStoId;

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

    public BigInteger getStoState() {
        return stoState;
    }

    public void setStoState(BigInteger stoState) {
        this.stoState = stoState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StoreEntity that = (StoreEntity) o;
        return stoId == that.stoId && Objects.equals(stoName, that.stoName) && Objects.equals(stoIntroduction, that.stoIntroduction) && Objects.equals(stoLicenseimg, that.stoLicenseimg) && Objects.equals(stoState, that.stoState);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stoId, stoName, stoIntroduction, stoLicenseimg, stoState);
    }

    public Collection<ChatEntity> getChatsByStoId() {
        return chatsByStoId;
    }

    public void setChatsByStoId(Collection<ChatEntity> chatsByStoId) {
        this.chatsByStoId = chatsByStoId;
    }

    public Collection<CommodityEntity> getCommoditiesByStoId() {
        return commoditiesByStoId;
    }

    public void setCommoditiesByStoId(Collection<CommodityEntity> commoditiesByStoId) {
        this.commoditiesByStoId = commoditiesByStoId;
    }

    public UsersEntity getUsersByStoId() {
        return usersByStoId;
    }

    public void setUsersByStoId(UsersEntity usersByStoId) {
        this.usersByStoId = usersByStoId;
    }

    public Collection<StoreimageEntity> getStoreimagesByStoId() {
        return storeimagesByStoId;
    }

    public void setStoreimagesByStoId(Collection<StoreimageEntity> storeimagesByStoId) {
        this.storeimagesByStoId = storeimagesByStoId;
    }
}
