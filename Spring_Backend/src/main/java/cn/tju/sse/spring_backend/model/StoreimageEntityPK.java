package cn.tju.sse.spring_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class StoreimageEntityPK implements Serializable {
    @Column(name = "STO_ID")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int stoId;
    @Column(name = "STO_IMAGE")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String stoImage;

    public int getStoId() {
        return stoId;
    }

    public void setStoId(int stoId) {
        this.stoId = stoId;
    }

    public String getStoImage() {
        return stoImage;
    }

    public void setStoImage(String stoImage) {
        this.stoImage = stoImage;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StoreimageEntityPK that = (StoreimageEntityPK) o;
        return stoId == that.stoId && Objects.equals(stoImage, that.stoImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stoId, stoImage);
    }
}
