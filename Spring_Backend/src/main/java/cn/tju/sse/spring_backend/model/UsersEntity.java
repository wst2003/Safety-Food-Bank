package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.sql.Date;
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
    private int userState;
    @Basic
    @Column(name = "USER_REGTIME")
    private Date userRegtime;
    @Basic
    @Column(name = "USER_TYPE")
    private int userType;

    @Id
    @Column(name = "USER_ID")
    private int userId;
    @Basic
    @Column(name = "USER_BALANCE")
    private BigDecimal userBalance;

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

    public int getUserState() {
        return userState;
    }

    public void setUserState(int userState) {
        this.userState = userState;
    }

    public Date getUserRegtime() {
        return userRegtime;
    }

    public void setUserRegtime(Date userRegtime) {
        this.userRegtime = userRegtime;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
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
        return userState == that.userState && userType == that.userType && userId == that.userId && Objects.equals(userPhone, that.userPhone) && Objects.equals(userPassword, that.userPassword) && Objects.equals(userAddress, that.userAddress) && Objects.equals(userRegtime, that.userRegtime) && Objects.equals(userBalance, that.userBalance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userPhone, userPassword, userAddress, userState, userRegtime, userType, userId, userBalance);
    }
}
