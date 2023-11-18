package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "CHAT", schema = "food_bank", catalog = "")
@IdClass(ChatEntityPK.class)
public class ChatEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "CHAT_TIME")
    private Timestamp chatTime;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "CUS_ID")
    private int cusId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "STORE_ID")
    private int storeId;
    @Basic
    @Column(name = "CHAT_CONTENT")
    private String chatContent;
    @Basic
    @Column(name = "CHAT_SENDER")
    private BigInteger chatSender;
    @Basic
    @Column(name = "CHAT_TYPE")
    private Integer chatType;
    @ManyToOne
    @JoinColumn(name = "CUS_ID", referencedColumnName = "CUS_ID", nullable = false)
    private CustomerEntity customerByCusId;
    @ManyToOne
    @JoinColumn(name = "STORE_ID", referencedColumnName = "STO_ID", nullable = false)
    private StoreEntity storeByStoreId;

    public Timestamp getChatTime() {
        return chatTime;
    }

    public void setChatTime(Timestamp chatTime) {
        this.chatTime = chatTime;
    }

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public String getChatContent() {
        return chatContent;
    }

    public void setChatContent(String chatContent) {
        this.chatContent = chatContent;
    }

    public BigInteger getChatSender() {
        return chatSender;
    }

    public void setChatSender(BigInteger chatSender) {
        this.chatSender = chatSender;
    }

    public Integer getChatType() {
        return chatType;
    }

    public void setChatType(Integer chatType) {
        this.chatType = chatType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ChatEntity that = (ChatEntity) o;
        return cusId == that.cusId && storeId == that.storeId && Objects.equals(chatTime, that.chatTime) && Objects.equals(chatContent, that.chatContent) && Objects.equals(chatSender, that.chatSender) && Objects.equals(chatType, that.chatType);
    }

    @Override
    public int hashCode() {
        return Objects.hash(chatTime, cusId, storeId, chatContent, chatSender, chatType);
    }

    public CustomerEntity getCustomerByCusId() {
        return customerByCusId;
    }

    public void setCustomerByCusId(CustomerEntity customerByCusId) {
        this.customerByCusId = customerByCusId;
    }

    public StoreEntity getStoreByStoreId() {
        return storeByStoreId;
    }

    public void setStoreByStoreId(StoreEntity storeByStoreId) {
        this.storeByStoreId = storeByStoreId;
    }
}
