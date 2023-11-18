package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "COMMODITY", schema = "food_bank", catalog = "")
public class CommodityEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "COM_ID")
    private long comId;
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
    private long comLeft;
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
    private BigInteger comStatus;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<AppealEntity> appealsByComId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<BrowseEntity> browsesByComId;
    @ManyToOne
    @JoinColumn(name = "STO_ID", referencedColumnName = "STO_ID", nullable = false)
    private StoreEntity storeByStoId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<CommodityCategoriesEntity> commodityCategoriesByComId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<CommodityCommentEntity> commodityCommentsByComId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<CommodityImageEntity> commodityImagesByComId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<CommodityPriceCurveEntity> commodityPriceCurvesByComId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<FavoriteEntity> favoritesByComId;
    @OneToMany(mappedBy = "commodityByComId")
    private Collection<IndentEntity> indentsByComId;

    public long getComId() {
        return comId;
    }

    public void setComId(long comId) {
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

    public long getComLeft() {
        return comLeft;
    }

    public void setComLeft(long comLeft) {
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

    public BigInteger getComStatus() {
        return comStatus;
    }

    public void setComStatus(BigInteger comStatus) {
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

    public Collection<AppealEntity> getAppealsByComId() {
        return appealsByComId;
    }

    public void setAppealsByComId(Collection<AppealEntity> appealsByComId) {
        this.appealsByComId = appealsByComId;
    }

    public Collection<BrowseEntity> getBrowsesByComId() {
        return browsesByComId;
    }

    public void setBrowsesByComId(Collection<BrowseEntity> browsesByComId) {
        this.browsesByComId = browsesByComId;
    }

    public StoreEntity getStoreByStoId() {
        return storeByStoId;
    }

    public void setStoreByStoId(StoreEntity storeByStoId) {
        this.storeByStoId = storeByStoId;
    }

    public Collection<CommodityCategoriesEntity> getCommodityCategoriesByComId() {
        return commodityCategoriesByComId;
    }

    public void setCommodityCategoriesByComId(Collection<CommodityCategoriesEntity> commodityCategoriesByComId) {
        this.commodityCategoriesByComId = commodityCategoriesByComId;
    }

    public Collection<CommodityCommentEntity> getCommodityCommentsByComId() {
        return commodityCommentsByComId;
    }

    public void setCommodityCommentsByComId(Collection<CommodityCommentEntity> commodityCommentsByComId) {
        this.commodityCommentsByComId = commodityCommentsByComId;
    }

    public Collection<CommodityImageEntity> getCommodityImagesByComId() {
        return commodityImagesByComId;
    }

    public void setCommodityImagesByComId(Collection<CommodityImageEntity> commodityImagesByComId) {
        this.commodityImagesByComId = commodityImagesByComId;
    }

    public Collection<CommodityPriceCurveEntity> getCommodityPriceCurvesByComId() {
        return commodityPriceCurvesByComId;
    }

    public void setCommodityPriceCurvesByComId(Collection<CommodityPriceCurveEntity> commodityPriceCurvesByComId) {
        this.commodityPriceCurvesByComId = commodityPriceCurvesByComId;
    }

    public Collection<FavoriteEntity> getFavoritesByComId() {
        return favoritesByComId;
    }

    public void setFavoritesByComId(Collection<FavoriteEntity> favoritesByComId) {
        this.favoritesByComId = favoritesByComId;
    }

    public Collection<IndentEntity> getIndentsByComId() {
        return indentsByComId;
    }

    public void setIndentsByComId(Collection<IndentEntity> indentsByComId) {
        this.indentsByComId = indentsByComId;
    }
}
