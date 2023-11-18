package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigInteger;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "CUSTOMER", schema = "food_bank", catalog = "")
public class CustomerEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    private BigInteger cusState;
    @OneToMany(mappedBy = "customerByBrowserId")
    private Collection<BrowseEntity> browsesByCusId;
    @OneToMany(mappedBy = "customerByCusId")
    private Collection<ChatEntity> chatsByCusId;
    @OneToOne
    @JoinColumn(name = "CUS_ID", referencedColumnName = "USER_ID", nullable = false)
    private UsersEntity usersByCusId;
    @OneToMany(mappedBy = "customerByCusId")
    private Collection<CustomerLoveEntity> customerLovesByCusId;
    @OneToMany(mappedBy = "customerByCusId")
    private Collection<FavoriteEntity> favoritesByCusId;
    @OneToMany(mappedBy = "customerByCusId")
    private Collection<IndentEntity> indentsByCusId;

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

    public BigInteger getCusState() {
        return cusState;
    }

    public void setCusState(BigInteger cusState) {
        this.cusState = cusState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerEntity that = (CustomerEntity) o;
        return cusId == that.cusId && Objects.equals(cusNickname, that.cusNickname) && Objects.equals(cusNotes, that.cusNotes) && Objects.equals(cusPaypassword, that.cusPaypassword) && Objects.equals(cusState, that.cusState);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cusId, cusNickname, cusNotes, cusPaypassword, cusState);
    }

    public Collection<BrowseEntity> getBrowsesByCusId() {
        return browsesByCusId;
    }

    public void setBrowsesByCusId(Collection<BrowseEntity> browsesByCusId) {
        this.browsesByCusId = browsesByCusId;
    }

    public Collection<ChatEntity> getChatsByCusId() {
        return chatsByCusId;
    }

    public void setChatsByCusId(Collection<ChatEntity> chatsByCusId) {
        this.chatsByCusId = chatsByCusId;
    }

    public UsersEntity getUsersByCusId() {
        return usersByCusId;
    }

    public void setUsersByCusId(UsersEntity usersByCusId) {
        this.usersByCusId = usersByCusId;
    }

    public Collection<CustomerLoveEntity> getCustomerLovesByCusId() {
        return customerLovesByCusId;
    }

    public void setCustomerLovesByCusId(Collection<CustomerLoveEntity> customerLovesByCusId) {
        this.customerLovesByCusId = customerLovesByCusId;
    }

    public Collection<FavoriteEntity> getFavoritesByCusId() {
        return favoritesByCusId;
    }

    public void setFavoritesByCusId(Collection<FavoriteEntity> favoritesByCusId) {
        this.favoritesByCusId = favoritesByCusId;
    }

    public Collection<IndentEntity> getIndentsByCusId() {
        return indentsByCusId;
    }

    public void setIndentsByCusId(Collection<IndentEntity> indentsByCusId) {
        this.indentsByCusId = indentsByCusId;
    }
}
