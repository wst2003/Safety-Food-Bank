package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "SEQUENCES", schema = "food_bank", catalog = "")
public class SequencesEntity {
      
    @Id
    @Column(name = "NAME")
    private String name;
    @Basic
    @Column(name = "CUR_VALUE")
    private int curValue;
    @Basic
    @Column(name = "INCREMENT")
    private int increment;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCurValue() {
        return curValue;
    }

    public void setCurValue(int curValue) {
        this.curValue = curValue;
    }

    public int getIncrement() {
        return increment;
    }

    public void setIncrement(int increment) {
        this.increment = increment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SequencesEntity that = (SequencesEntity) o;
        return curValue == that.curValue && increment == that.increment && Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, curValue, increment);
    }
}
