package cn.tju.sse.spring_backend.repository.pub.resetpassword;

import cn.tju.sse.spring_backend.model.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResetPasswordRepository extends JpaRepository<UsersEntity,Integer> {
    boolean existsUsersEntityByUserPhone(String user_phone);
    UsersEntity findByUserPhone(String phone);
}
