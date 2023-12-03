package cn.tju.sse.spring_backend.repository.admin;

import cn.tju.sse.spring_backend.model.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 检索用户列表的接口
 */
public interface UserListRepository extends JpaRepository<UsersEntity, Integer> {
    /**
     * 按照ID降序检索具有详细信息的客户列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、昵称、注册时间和状态的客户对象列表。
     */
    @Query(value = "SELECT CUS_ID, CUS_NICKNAME, USER_REGTIME, USER_STATE " +
            "FROM CUSTOMER JOIN USERS ON CUSTOMER.CUS_ID = USERS.USER_ID " +
            "WHERE CUS_NICKNAME LIKE :userName " +
            "ORDER BY CUS_ID DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getCustomerByIdDesc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按照ID升序检索具有详细信息的客户列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、昵称、注册时间和状态的客户对象列表。
     */
    @Query(value = "SELECT CUS_ID, CUS_NICKNAME, USER_REGTIME, USER_STATE " +
            "FROM CUSTOMER JOIN USERS ON CUSTOMER.CUS_ID = USERS.USER_ID " +
            "WHERE CUS_NICKNAME LIKE :userName " +
            "ORDER BY CUS_ID ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getCustomerByIdAsc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按昵称降序检索具有详细信息的客户列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、昵称、注册时间和状态的客户对象列表。
     */
    @Query(value = "SELECT CUS_ID, CUS_NICKNAME, USER_REGTIME, USER_STATE " +
            "FROM CUSTOMER JOIN USERS ON CUSTOMER.CUS_ID = USERS.USER_ID " +
            "WHERE CUS_NICKNAME LIKE :userName " +
            "ORDER BY CONVERT(CUS_NICKNAME USING GBK) DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getCustomerByNameDesc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按昵称升序检索具有详细信息的客户列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、昵称、注册时间和状态的客户对象列表。
     */
    @Query(value = "SELECT CUS_ID, CUS_NICKNAME, USER_REGTIME, USER_STATE " +
            "FROM CUSTOMER JOIN USERS ON CUSTOMER.CUS_ID = USERS.USER_ID " +
            "WHERE CUS_NICKNAME LIKE :userName " +
            "ORDER BY CONVERT(CUS_NICKNAME USING GBK) ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getCustomerByNameAsc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按照ID降序检索具有详细信息的商家列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、名称、注册时间、状态和图像的商家对象列表。
     */
    @Query(value = "WITH STORE_WITH_IMAGE AS (" +
            "    SELECT STORE.*, ci.STO_IMAGE " +
            "    FROM STORE " +
            "    JOIN(" +
            "        SELECT STO_ID, MIN(STO_IMAGE) AS STO_IMAGE " +
            "        FROM STOREIMAGE " +
            "        GROUP BY STO_ID " +
            "    ) ci ON STORE.STO_ID = ci.STO_ID " +
            ") " +
            "SELECT STORE_WITH_IMAGE.STO_ID, STORE_WITH_IMAGE.STO_NAME, USERS.USER_REGTIME, " +
            "       USERS.USER_STATE, STORE_WITH_IMAGE.STO_IMAGE " +
            "FROM STORE_WITH_IMAGE JOIN USERS ON STORE_WITH_IMAGE.STO_ID = USERS.USER_ID " +
            "WHERE STORE_WITH_IMAGE.STO_NAME LIKE :userName " +
            "ORDER BY STORE_WITH_IMAGE.STO_ID DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getMerchantByIdDesc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按照ID升序检索具有详细信息的商家列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、名称、注册时间、状态和图像的商家对象列表。
     */
    @Query(value = "WITH STORE_WITH_IMAGE AS (" +
            "    SELECT STORE.*, ci.STO_IMAGE " +
            "    FROM STORE " +
            "    JOIN(" +
            "        SELECT STO_ID, MIN(STO_IMAGE) AS STO_IMAGE " +
            "        FROM STOREIMAGE " +
            "        GROUP BY STO_ID " +
            "    ) ci ON STORE.STO_ID = ci.STO_ID " +
            ") " +
            "SELECT STORE_WITH_IMAGE.STO_ID, STORE_WITH_IMAGE.STO_NAME, USERS.USER_REGTIME, " +
            "       USERS.USER_STATE, STORE_WITH_IMAGE.STO_IMAGE " +
            "FROM STORE_WITH_IMAGE JOIN USERS ON STORE_WITH_IMAGE.STO_ID = USERS.USER_ID " +
            "WHERE STORE_WITH_IMAGE.STO_NAME LIKE :userName " +
            "ORDER BY STORE_WITH_IMAGE.STO_ID ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getMerchantByIdAsc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按照昵称降序检索具有详细信息的商家列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、名称、注册时间、状态和图像的商家对象列表。
     */
    @Query(value = "WITH STORE_WITH_IMAGE AS (" +
            "    SELECT STORE.*, ci.STO_IMAGE " +
            "    FROM STORE " +
            "    JOIN(" +
            "        SELECT STO_ID, MIN(STO_IMAGE) AS STO_IMAGE " +
            "        FROM STOREIMAGE " +
            "        GROUP BY STO_ID " +
            "    ) ci ON STORE.STO_ID = ci.STO_ID " +
            ") " +
            "SELECT STORE_WITH_IMAGE.STO_ID, STORE_WITH_IMAGE.STO_NAME, USERS.USER_REGTIME, " +
            "       USERS.USER_STATE, STORE_WITH_IMAGE.STO_IMAGE " +
            "FROM STORE_WITH_IMAGE JOIN USERS ON STORE_WITH_IMAGE.STO_ID = USERS.USER_ID " +
            "WHERE STORE_WITH_IMAGE.STO_NAME LIKE :userName " +
            "ORDER BY CONVERT(STORE_WITH_IMAGE.STO_NAME USING GBK) DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getMerchantByNameDesc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按照昵称升序检索具有详细信息的商家列表。
     *
     * @param userName     要搜索的用户名。
     * @param beginNumber  结果集的起始索引。
     * @param pageSize     返回的最大结果数。
     * @return             包含ID、名称、注册时间、状态和图像的商家对象列表。
     */
    @Query(value = "WITH STORE_WITH_IMAGE AS (" +
            "    SELECT STORE.*, ci.STO_IMAGE " +
            "    FROM STORE " +
            "    JOIN(" +
            "        SELECT STO_ID, MIN(STO_IMAGE) AS STO_IMAGE " +
            "        FROM STOREIMAGE " +
            "        GROUP BY STO_ID " +
            "    ) ci ON STORE.STO_ID = ci.STO_ID " +
            ") " +
            "SELECT STORE_WITH_IMAGE.STO_ID, STORE_WITH_IMAGE.STO_NAME, USERS.USER_REGTIME, " +
            "       USERS.USER_STATE, STORE_WITH_IMAGE.STO_IMAGE " +
            "FROM STORE_WITH_IMAGE JOIN USERS ON STORE_WITH_IMAGE.STO_ID = USERS.USER_ID " +
            "WHERE STORE_WITH_IMAGE.STO_NAME LIKE :userName " +
            "ORDER BY CONVERT(STORE_WITH_IMAGE.STO_NAME USING GBK) ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getMerchantByNameAsc(@Param("userName") String userName, @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);
}
