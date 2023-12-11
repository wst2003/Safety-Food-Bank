package cn.tju.sse.spring_backend.repository.pub.register;

import cn.tju.sse.spring_backend.model.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRegisterRepository extends JpaRepository<UsersEntity,Integer> {
    public boolean existsUsersEntityByUserPhone(String user_phone);

    public UsersEntity findUsersEntitiesByUserPhone(String user_phone);

}
