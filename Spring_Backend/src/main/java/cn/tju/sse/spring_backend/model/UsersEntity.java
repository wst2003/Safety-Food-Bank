package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "USERS", schema = "food_bank", catalog = "")
public class UsersEntity {
    @Basic
    @Column(name = "USER_PHONE")
    private String userPhone;
    @Basic
    @Column(name = "USER_PASSWORD")
    private String userPassword;
    @Basic
    @Column(name = "USER_ADDRESS")
    private String userAddress;
    @Basic
    @Column(name = "USER_STATE")
    private BigInteger userState;
    @Basic
    @Column(name = "USER_REGTIME")
    private Date userRegtime;
    @Basic
    @Column(name = "USER_TYPE")
    private BigInteger userType;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "USER_ID")
    private int userId;
    @Basic
    @Column(name = "USER_BALANCE")
    private BigDecimal userBalance;
    @OneToMany(mappedBy = "usersByUserId")
    private Collection<AppealEntity> appealsByUserId;
    @OneToMany(mappedBy = "usersByAppUserid")
    private Collection<AppealEntity> appealsByUserId_0;
    @OneToMany(mappedBy = "usersByUserId")
    private Collection<CommodityCommentEntity> commodityCommentsByUserId;
    @OneToOne(mappedBy = "usersByCusId")
    private CustomerEntity customerByUserId;
    @OneToMany(mappedBy = "usersByStoId")
    private Collection<NoticeEntity> noticesByUserId;
    @OneToOne(mappedBy = "usersByStoId")
    private StoreEntity storeByUserId;

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public BigInteger getUserState() {
        return userState;
    }

    public void setUserState(BigInteger userState) {
        this.userState = userState;
    }

    public Date getUserRegtime() {
        return userRegtime;
    }

    public void setUserRegtime(Date userRegtime) {
        this.userRegtime = userRegtime;
    }

    public BigInteger getUserType() {
        return userType;
    }

    public void setUserType(BigInteger userType) {
        this.userType = userType;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getUserBalance() {
        return userBalance;
    }

    public void setUserBalance(BigDecimal userBalance) {
        this.userBalance = userBalance;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UsersEntity that = (UsersEntity) o;
        return userId == that.userId && Objects.equals(userPhone, that.userPhone) && Objects.equals(userPassword, that.userPassword) && Objects.equals(userAddress, that.userAddress) && Objects.equals(userState, that.userState) && Objects.equals(userRegtime, that.userRegtime) && Objects.equals(userType, that.userType) && Objects.equals(userBalance, that.userBalance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userPhone, userPassword, userAddress, userState, userRegtime, userType, userId, userBalance);
    }

    public Collection<AppealEntity> getAppealsByUserId() {
        return appealsByUserId;
    }

    public void setAppealsByUserId(Collection<AppealEntity> appealsByUserId) {
        this.appealsByUserId = appealsByUserId;
    }

    public Collection<AppealEntity> getAppealsByUserId_0() {
        return appealsByUserId_0;
    }

    public void setAppealsByUserId_0(Collection<AppealEntity> appealsByUserId_0) {
        this.appealsByUserId_0 = appealsByUserId_0;
    }

    public Collection<CommodityCommentEntity> getCommodityCommentsByUserId() {
        return commodityCommentsByUserId;
    }

    public void setCommodityCommentsByUserId(Collection<CommodityCommentEntity> commodityCommentsByUserId) {
        this.commodityCommentsByUserId = commodityCommentsByUserId;
    }

    public CustomerEntity getCustomerByUserId() {
        return customerByUserId;
    }

    public void setCustomerByUserId(CustomerEntity customerByUserId) {
        this.customerByUserId = customerByUserId;
    }

    public Collection<NoticeEntity> getNoticesByUserId() {
        return noticesByUserId;
    }

    public void setNoticesByUserId(Collection<NoticeEntity> noticesByUserId) {
        this.noticesByUserId = noticesByUserId;
    }

    public StoreEntity getStoreByUserId() {
        return storeByUserId;
    }

    public void setStoreByUserId(StoreEntity storeByUserId) {
        this.storeByUserId = storeByUserId;
    }
}
