package cn.tju.sse.spring_backend.repository.pub.information;

import cn.tju.sse.spring_backend.model.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserInformationRepository extends JpaRepository<UsersEntity, Integer> {
    public boolean existsUsersEntityByUserId(int userId);
}
