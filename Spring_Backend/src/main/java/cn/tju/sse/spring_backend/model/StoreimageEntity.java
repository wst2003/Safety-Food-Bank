package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "STOREIMAGE", schema = "food_bank", catalog = "")
@IdClass(StoreimageEntityPK.class)
public class StoreimageEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "STO_ID")
    private int stoId;
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "STO_IMAGE")
    private String stoImage;
    @ManyToOne
    @JoinColumn(name = "STO_ID", referencedColumnName = "STO_ID", nullable = false)
    private StoreEntity storeByStoId;

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
        StoreimageEntity that = (StoreimageEntity) o;
        return stoId == that.stoId && Objects.equals(stoImage, that.stoImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stoId, stoImage);
    }

    public StoreEntity getStoreByStoId() {
        return storeByStoId;
    }

    public void setStoreByStoId(StoreEntity storeByStoId) {
        this.storeByStoId = storeByStoId;
    }
}
