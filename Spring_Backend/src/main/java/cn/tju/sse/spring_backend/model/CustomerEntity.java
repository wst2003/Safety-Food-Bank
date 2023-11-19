package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "CUSTOMER", schema = "food_bank", catalog = "")
public class CustomerEntity {
      
    @Id
    @Column(name = "CUS_ID")
    private int cusId;
    @Basic
    @Column(name = "CUS_NICKNAME")
    private String cusNickname;
    @Basic
    @Column(name = "CUS_NOTES")
    private String cusNotes;
    @Basic
    @Column(name = "CUS_PAYPASSWORD")
    private String cusPaypassword;
    @Basic
    @Column(name = "CUS_STATE")
    private int cusState;

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    public String getCusNickname() {
        return cusNickname;
    }

    public void setCusNickname(String cusNickname) {
        this.cusNickname = cusNickname;
    }

    public String getCusNotes() {
        return cusNotes;
    }

    public void setCusNotes(String cusNotes) {
        this.cusNotes = cusNotes;
    }

    public String getCusPaypassword() {
        return cusPaypassword;
    }

    public void setCusPaypassword(String cusPaypassword) {
        this.cusPaypassword = cusPaypassword;
    }

    public int getCusState() {
        return cusState;
    }

    public void setCusState(int cusState) {
        this.cusState = cusState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerEntity that = (CustomerEntity) o;
        return cusId == that.cusId && cusState == that.cusState && Objects.equals(cusNickname, that.cusNickname) && Objects.equals(cusNotes, that.cusNotes) && Objects.equals(cusPaypassword, that.cusPaypassword);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cusId, cusNickname, cusNotes, cusPaypassword, cusState);
    }
}
