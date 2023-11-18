package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;

public class ChatEntityPK implements Serializable {
    @Column(name = "CHAT_TIME")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Timestamp chatTime;
    @Column(name = "CUS_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cusId;
    @Column(name = "STORE_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int storeId;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ChatEntityPK that = (ChatEntityPK) o;
        return cusId == that.cusId && storeId == that.storeId && Objects.equals(chatTime, that.chatTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(chatTime, cusId, storeId);
    }
}
