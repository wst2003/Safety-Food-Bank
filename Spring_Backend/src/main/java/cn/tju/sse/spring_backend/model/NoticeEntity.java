package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigInteger;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "NOTICE", schema = "food_bank", catalog = "")
public class NoticeEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "NTC_ID")
    private int ntcId;
    @Basic
    @Column(name = "NTC_TIME")
    private Date ntcTime;
    @Basic
    @Column(name = "NTC_CONTENT")
    private String ntcContent;
    @Basic
    @Column(name = "NTC_STATE")
    private BigInteger ntcState;
    @Basic
    @Column(name = "STO_ID")
    private int stoId;
    @ManyToOne
    @JoinColumn(name = "STO_ID", referencedColumnName = "USER_ID", nullable = false)
    private UsersEntity usersByStoId;

    public int getNtcId() {
        return ntcId;
    }

    public void setNtcId(int ntcId) {
        this.ntcId = ntcId;
    }

    public Date getNtcTime() {
        return ntcTime;
    }

    public void setNtcTime(Date ntcTime) {
        this.ntcTime = ntcTime;
    }

    public String getNtcContent() {
        return ntcContent;
    }

    public void setNtcContent(String ntcContent) {
        this.ntcContent = ntcContent;
    }

    public BigInteger getNtcState() {
        return ntcState;
    }

    public void setNtcState(BigInteger ntcState) {
        this.ntcState = ntcState;
    }

    public int getStoId() {
        return stoId;
    }

    public void setStoId(int stoId) {
        this.stoId = stoId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NoticeEntity that = (NoticeEntity) o;
        return ntcId == that.ntcId && stoId == that.stoId && Objects.equals(ntcTime, that.ntcTime) && Objects.equals(ntcContent, that.ntcContent) && Objects.equals(ntcState, that.ntcState);
    }

    @Override
    public int hashCode() {
        return Objects.hash(ntcId, ntcTime, ntcContent, ntcState, stoId);
    }

    public UsersEntity getUsersByStoId() {
        return usersByStoId;
    }

    public void setUsersByStoId(UsersEntity usersByStoId) {
        this.usersByStoId = usersByStoId;
    }
}
