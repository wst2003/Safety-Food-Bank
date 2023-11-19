package cn.tju.sse.spring_backend.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "ADMINISTRATOR", schema = "food_bank", catalog = "")
public class AdministratorEntity {

    @Id
    @Column(name = "ADMIN_ID")
    private int adminId;
    @Basic
    @Column(name = "ADMIN_ACCNUMBER")
    private String adminAccnumber;
    @Basic
    @Column(name = "ADMIN_PASSWORD")
    private String adminPassword;
    @Basic
    @Column(name = "ADMIN_STATE")
    private String adminState;

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getAdminAccnumber() {
        return adminAccnumber;
    }

    public void setAdminAccnumber(String adminAccnumber) {
        this.adminAccnumber = adminAccnumber;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    public String getAdminState() {
        return adminState;
    }

    public void setAdminState(String adminState) {
        this.adminState = adminState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AdministratorEntity that = (AdministratorEntity) o;
        return adminId == that.adminId && Objects.equals(adminAccnumber, that.adminAccnumber) && Objects.equals(adminPassword, that.adminPassword) && Objects.equals(adminState, that.adminState);
    }

    @Override
    public int hashCode() {
        return Objects.hash(adminId, adminAccnumber, adminPassword, adminState);
    }
}
