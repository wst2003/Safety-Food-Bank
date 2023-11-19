package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "CHAT", schema = "food_bank", catalog = "")
@IdClass(ChatEntityPK.class)
public class ChatEntity {
      
    @Id
    @Column(name = "CHAT_TIME")
    private Timestamp chatTime;
      
    @Id
    @Column(name = "CUS_ID")
    private int cusId;
      
    @Id
    @Column(name = "STORE_ID")
    private int storeId;
    @Basic
    @Column(name = "CHAT_CONTENT")
    private String chatContent;
    @Basic
    @Column(name = "CHAT_SENDER")
    private Integer chatSender;
    @Basic
    @Column(name = "CHAT_TYPE")
    private Integer chatType;

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

    public Integer getChatSender() {
        return chatSender;
    }

    public void setChatSender(Integer chatSender) {
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
}
