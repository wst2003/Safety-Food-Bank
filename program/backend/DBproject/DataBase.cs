//数据库类，含有大部分数据库的操作，供接口类调用
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Transactions;
using DBproject.Controllers;
using DBproject.Models;
using static WebApplication3.Controllers.CommodityController;
using static WebApplication3.Controllers.StoreController;
using static WebApplication3.Controllers.IndentController;
using static WebApplication3.Controllers.AppealController;
using WebApplication3.Controllers;
using Microsoft.VisualBasic;
using Newtonsoft.Json.Bson;
using Microsoft.AspNet.SignalR.Messaging;
using Microsoft.AspNet.SignalR.Infrastructure;
using Oracle.ManagedDataAccess.Types;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Globalization;

namespace DBproject
{
    public class DataBase
    {
        private string connectString = @"DATA SOURCE=localhost:1521/orcl;TNS_ADMIN=C:\Users\Administrator\Oracle\network\admin;PERSIST SECURITY INFO=True;USER ID=release;Password=123456";
        public OracleConnection con;
        //静态类声明
        public static DataBase oracleCon;
        //构造函数
        public DataBase()
        {
            con = new OracleConnection(connectString);
            con.Open();
            Console.WriteLine("Oracle 连接成功\n");
        }

        //判断用户是否存在
        public bool IsUserExist(string ID)
        {
            bool exists = false;
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT(*) FROM users WHERE user_ID = :ID";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("ID", OracleDbType.Varchar2).Value = ID;
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                exists = count > 0;
            }
            return exists;
        }
        //判断用户电话号码是否存在
        public bool IsUserPhoneExist(string phonenumber)
        {
            bool exists = false;
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT(*) FROM users WHERE user_phone = :phone";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("phone", OracleDbType.Varchar2).Value = phonenumber;
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                exists = count > 0;
            }
            return exists;
        }
        //判断商家是否存在
        public bool IsStoreExist(string ID)
        {
            bool exists = false;
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT(*) FROM store WHERE sto_ID = :storeID";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("storeID", OracleDbType.Int32).Value = Int32.Parse(ID);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                exists = count > 0;
            }
            return exists;
        }
        //判断顾客是否存在
        public bool IsCusExist(string ID)
        {
            bool exists = false;
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT(*) FROM customer WHERE cus_ID = :cusID";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("cusID", OracleDbType.Int32).Value = Int32.Parse(ID);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                exists = count > 0;
            }
            return exists;
        }

        //用户注册
        public string RegisterUser(string phonenumber, string password, string address, string type)
        {
            if (IsUserPhoneExist(phonenumber))
            {
                return "电话号码已经存在!";
            }

            try
            {
                DateTime now = DateTime.Now;
                using (OracleCommand cmd = con.CreateCommand())
                {
                    // 使用参数化查询
                    cmd.CommandText = "INSERT INTO USERS(USER_PHONE,USER_PASSWORD,USER_ADDRESS,USER_STATE,USER_BALANCE,USER_REGTIME,USER_TYPE,USER_ID)" +
                        " VALUES(:phone, :Password, :address, 0, 0, :regTime, :type, USERIDSEQUENCE.NEXTVAL)";
                    // 添加参数
                    cmd.Parameters.Add("phone", OracleDbType.Varchar2, 20).Value = phonenumber;
                    cmd.Parameters.Add("Password", OracleDbType.Varchar2, 20).Value = password;
                    cmd.Parameters.Add("address", OracleDbType.Varchar2, 100).Value = address;
                    cmd.Parameters.Add("regTime", OracleDbType.Date).Value = now;
                    cmd.Parameters.Add("type", OracleDbType.Byte).Value = Convert.ToByte(type);
                    int rowsInserted = cmd.ExecuteNonQuery();//ExecuteNonQuery() 方法返回一个整数，表示被影响的行数，即执行 SQL 命令后有多少行数据受到影响。
                    if (rowsInserted > 0)
                    {
                        return "success";
                    }
                    else
                    {
                        return "顾客注册失败，请重试。";
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                return "数据库操作异常：" + ex.Message;
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他异常：" + ex.Message);
                return "其他异常：" + ex.Message;
            }

        }
        //注册结束后获取新ID
        public string GetNewUserID(string phonenumber)
        {
            if (!IsUserPhoneExist(phonenumber))
            {
                return "电话号码不存在!";
            }
            string newID = "0000000";
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "SELECT USER_ID FROM USERS WHERE USER_PHONE = :phone";
                    cmd.Parameters.Add("phone", OracleDbType.Varchar2).Value = phonenumber;
                    OracleDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        newID = reader.GetString(0);
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("返回新ID异常" + ex.Message);
                    return "返回新ID异常" + ex.Message;
                }
            }
            return newID;
        }

        //商店注册
        public string RegisterSto(string ID, string name, string introduction, string imageURL)
        {
            string message = "";
            if (!IsUserExist(ID))
            {
                message = "商家ID不存在";
                return message;
            }

            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {

                    // 插入商家信息
                    cmd.CommandText = "INSERT INTO STORE(STO_ID, STO_NAME, STO_INTRODUCTION, STO_LICENSEIMG, STO_STATE) " +
                                      "VALUES(:stoID, :stoName, :stoIntro, :stoImageURL, 1)";
                    cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(ID);
                    cmd.Parameters.Add(new OracleParameter("stoName", OracleDbType.Varchar2, 20)).Value = name;
                    cmd.Parameters.Add(new OracleParameter("stoIntro", OracleDbType.Clob)).Value = introduction;
                    cmd.Parameters.Add(new OracleParameter("stoImageURL", OracleDbType.Varchar2, 50)).Value = imageURL;
                    cmd.ExecuteNonQuery();
                    // 提交事务

                    message = "success";
                }
            }
            catch (Exception ex)
            {
                // 出现异常时回滚事务

                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }

            return message;
        }

        //添加商家的图片
        public string AddStoreImage(string ID, string url)
        {
            string message = "";
            if (!IsStoreExist(ID))
            {
                message = "商家ID不存在";
                return message;
            }
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "INSERT INTO storeImage (sto_ID, sto_image) VALUES (:stoID, :stoImage)";
                    cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(ID);
                    cmd.Parameters.Add(new OracleParameter("stoImage", OracleDbType.Varchar2, 100)).Value = url;
                    cmd.ExecuteNonQuery();
                    message = "success";
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }
            return message;
        }

        //添加商店主营类别
        public string EditStoCategories(string ID, List<string> categories)
        {
            string message = "";
            if (!IsStoreExist(ID))
            {
                return "商家ID不存在";
            }
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    // 先查询数据库中已存在的商家主营类别
                    cmd.CommandText = "SELECT com_category FROM store_categories WHERE store_ID = :storeID";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("storeID", OracleDbType.Int32).Value = Int32.Parse(ID);
                    List<string> existingCategories = new List<string>();
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            existingCategories.Add(reader.GetString(0));
                        }
                    }
                    // 检查传入的列表中的类别是否在数据库中已存在，不存在则新增
                    foreach (string category in categories)
                    {
                        if (!existingCategories.Contains(category))
                        {
                            // 执行新增操作，使用参数化查询
                            cmd.CommandText = "INSERT INTO store_categories (store_ID, com_category) VALUES (:storeID, :category)";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("storeID", OracleDbType.Int32).Value = Int32.Parse(ID);
                            cmd.Parameters.Add("category", OracleDbType.Varchar2).Value = category;
                            cmd.ExecuteNonQuery();
                        }
                    }
                    // 检查数据库中已存在的类别是否在传入的列表中，不在则删除
                    foreach (string existingCategory in existingCategories)
                    {
                        if (!categories.Contains(existingCategory))
                        {
                            // 执行删除操作，使用参数化查询
                            cmd.CommandText = "DELETE FROM store_categories WHERE store_ID = :storeID AND com_category = :existingCategory";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("storeID", OracleDbType.Int32).Value = Int32.Parse(ID);
                            cmd.Parameters.Add("existingCategory", OracleDbType.Varchar2).Value = existingCategory;
                            cmd.ExecuteNonQuery();
                        }
                    }
                    message = "success";
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                message = "其他错误：" + ex.Message;
            }

            return message;
        }

        //顾客注册
        public string RegisterCus(string ID, string nickname, string notes, string paypassword)
        {
            string message = "";
            try
            {
                // 首先检查是否存在相同的顾客ID，避免重复注册
                if (IsCusExist(ID))
                    return "顾客已经存在";
                // 检查是否存在userID
                if (!IsUserExist(ID))
                    return "用户ID不存在";
                // 插入顾客信息到数据库
                using (OracleCommand insertCmd = con.CreateCommand())
                {
                    insertCmd.CommandText = "INSERT INTO customer (cus_ID, cus_nickname, cus_notes, cus_payPassword, cus_state) " +
                                            "VALUES (:cusID, :nickname, :notes, :payPassword, 1)";
                    insertCmd.Parameters.Add("cusID", OracleDbType.Int32).Value = Int32.Parse(ID);
                    insertCmd.Parameters.Add("nickname", OracleDbType.Varchar2).Value = nickname;
                    insertCmd.Parameters.Add("notes", OracleDbType.Clob).Value = notes;
                    insertCmd.Parameters.Add("payPassword", OracleDbType.Varchar2).Value = paypassword;
                    int rowsInserted = insertCmd.ExecuteNonQuery();//ExecuteNonQuery() 方法返回一个整数，表示被影响的行数，即执行 SQL 命令后有多少行数据受到影响。
                    if (rowsInserted > 0)
                    {
                        message = "success";
                    }
                    else
                    {
                        message = "顾客注册失败，请重试。";
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                message = "其他错误：" + ex.Message;
            }
            return message;
        }

        //顾客注册时添加喜好
        public string EditCusLove(string ID, List<string> loves)
        {
            string message = "";
            bool customerExists = IsCusExist(ID);

            if (!customerExists)
            {
                return "该顾客ID不存在";
            }
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    // 先查询数据库中已存在的顾客喜好类别及权重
                    cmd.CommandText = "SELECT com_category, cus_love_weight FROM customer_love WHERE cus_ID = :cusID";
                    cmd.Parameters.Add("cusID", OracleDbType.Int32).Value = Int32.Parse(ID);

                    Dictionary<string, decimal> existingLoves = new Dictionary<string, decimal>();
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string category = reader.GetString(0);
                            decimal weight = reader.GetDecimal(1);
                            existingLoves[category] = weight;
                        }
                    }
                    // 检查传入的列表中的类别是否在数据库中已存在，不存在则新增
                    foreach (string category in loves)
                    {
                        if (!existingLoves.ContainsKey(category))
                        {
                            // 执行新增操作，使用参数化查询
                            cmd.CommandText = "INSERT INTO customer_love (cus_ID, com_category, cus_love_weight) VALUES (:cusID, :category, 1.0)";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("cusID", OracleDbType.Int32).Value = Int32.Parse(ID);
                            cmd.Parameters.Add("category", OracleDbType.Varchar2).Value = category;
                            cmd.ExecuteNonQuery();
                        }
                    }
                    // 检查数据库中已存在的类别是否在传入的列表中，不在则删除
                    foreach (string existingCategory in existingLoves.Keys)
                    {
                        if (!loves.Contains(existingCategory))
                        {
                            // 执行删除操作，使用参数化查询
                            cmd.CommandText = "DELETE FROM customer_love WHERE cus_ID = :cusID AND com_category = :existingCategory";
                            cmd.Parameters.Clear();
                            cmd.Parameters.Add("cusID", OracleDbType.Int32).Value = Int32.Parse(ID);
                            cmd.Parameters.Add("existingCategory", OracleDbType.Varchar2).Value = existingCategory;
                            cmd.ExecuteNonQuery();
                        }
                    }
                    message = "success";
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                message = "其他错误：" + ex.Message;
            }
            return message;
        }

        //返回所有喜好信息
        public List<string> GetAllLoves()
        {
            List<string> loves = new List<string>();
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SELECT com_category FROM commodities_categories";

                    using (OracleDataAdapter adapter = new OracleDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        // 将查询结果添加到 loves 列表中
                        foreach (DataRow row in dt.Rows)
                        {
                            loves.Add(row["com_category"].ToString());
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return loves;
        }
        //ID登录
        public string IDLogin(string ID, string password)
        {
            string flag = "用户不存在";
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "SELECT USER_PASSWORD, USER_TYPE, USER_STATE FROM USERS WHERE USER_ID = :userID";
                    cmd.Parameters.Add(new OracleParameter("userID", OracleDbType.Int32)).Value = Int32.Parse(ID);
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string storedPassword = reader.GetString(0).Trim();
                        string userType = reader.GetString(1);
                        int userState = reader.GetInt32(2);

                        if (storedPassword == password)
                        {
                            if (userType == "0")
                            {
                                cmd.CommandText = "SELECT CUS_STATE FROM CUSTOMER WHERE CUS_ID = :cusID";
                                cmd.Parameters.Clear();
                                cmd.Parameters.Add(new OracleParameter("cusID", OracleDbType.Int32)).Value = Int32.Parse(ID);
                                int cusState = Convert.ToInt32(cmd.ExecuteScalar());

                                if (cusState == 0)
                                {
                                    return "该用户已经被封禁";
                                }
                            }
                            else if (userType == "1")
                            {
                                cmd.CommandText = "SELECT STO_STATE FROM STORE WHERE STO_ID = :stoID";
                                cmd.Parameters.Clear();
                                cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(ID);
                                int stoState = Convert.ToInt32(cmd.ExecuteScalar());

                                if (stoState == 0)
                                {
                                    return "该用户已经被封禁";
                                }
                            }

                            flag = userType;
                            Console.WriteLine("登录成功，用户类别为" + flag);
                            reader.Dispose();
                            reader.Close();
                            SetUserIDState(ID, true);
                            return flag;
                        }
                    }
                    reader.Dispose();
                    reader.Close();
                    cmd.CommandText = "SELECT USER_ID FROM USERS WHERE USER_ID=" + ID;
                    OracleDataReader reader_id = cmd.ExecuteReader();
                    while (reader_id.Read())
                    {
                        if (ID == reader_id.GetString(0))
                            flag = "密码错误";
                    }
                    reader_id.Dispose();
                    reader_id.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    flag = ex.Message;
                }

            }
            return flag;
        }
        //电话号码登录
        public string PhonenumberLogin(string phonenumber, string password)
        {

            string flag = "用户不存在";
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "SELECT USER_PASSWORD, USER_TYPE, USER_STATE FROM USERS WHERE USER_PHONE = :userPhone";
                    cmd.Parameters.Add(new OracleParameter("userPhone", OracleDbType.Varchar2)).Value = phonenumber;
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string storedPassword = reader.GetString(0).Trim();
                        string userType = reader.GetString(1);
                        int userState = reader.GetInt32(2);

                        if (storedPassword == password)
                        {
                            if (userType == "0") // Check if the user is a customer
                            {
                                cmd.CommandText = "SELECT CUS_STATE FROM CUSTOMER WHERE CUS_ID = (SELECT USER_ID FROM USERS WHERE USER_PHONE = :userPhone)";
                                int cusState = Convert.ToInt32(cmd.ExecuteScalar());

                                if (cusState == 0) // Check if customer is banned
                                {
                                    return "该用户已经被封禁";
                                }
                            }
                            else if (userType == "1") // Check if the user is a store
                            {
                                cmd.CommandText = "SELECT STO_STATE FROM STORE WHERE STO_ID = (SELECT USER_ID FROM USERS WHERE USER_PHONE = :userPhone)";
                                int stoState = Convert.ToInt32(cmd.ExecuteScalar());

                                if (stoState == 0) // Check if store is banned
                                {
                                    return "该用户已经被封禁";
                                }
                            }

                            flag = userType;
                            Console.WriteLine("登录成功，用户类别为" + flag);
                            reader.Dispose();
                            SetPhoneState(phonenumber, true);
                            return flag;
                        }
                    }
                    reader.Dispose();
                    reader.Close();


                    cmd.CommandText = "SELECT USER_PHONE FROM USERS WHERE USER_PHONE=" + phonenumber;
                    OracleDataReader reader_id = cmd.ExecuteReader();
                    while (reader_id.Read())
                    {
                        if (phonenumber == reader_id.GetString(0))
                            flag = "密码错误";
                    }

                    reader_id.Dispose();
                    reader_id.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    flag = ex.Message;
                }
            }
            return flag;
        }
        //设置对应userID的登录状态
        public bool SetUserIDState(string ID, bool loginState)
        {
            bool success = false;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "UPDATE USERS SET USER_STATE = :loginState WHERE USER_ID = :userID";
                    cmd.Parameters.Add(new OracleParameter("loginState", OracleDbType.Decimal)).Value = loginState ? 1 : 0;
                    cmd.Parameters.Add(new OracleParameter("userID", OracleDbType.Int32)).Value = Int32.Parse(ID);
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        success = true;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            return success;
        }


        //设置对应电话号码的登录状态
        public bool SetPhoneState(string phonenumber, bool loginState)
        {
            bool success = false;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "UPDATE USERS SET USER_STATE = :loginState WHERE USER_PHONE = :phoneNumber";
                    cmd.Parameters.Add(new OracleParameter("loginState", OracleDbType.Decimal)).Value = loginState ? 1 : 0;
                    cmd.Parameters.Add(new OracleParameter("phoneNumber", OracleDbType.Varchar2)).Value = phonenumber;
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        success = true;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            return success;
        }


        //通过电话号码重置密码
        public string ResetPassword(string phonenumber, string password)
        {
            string message = "";
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "SELECT USER_PASSWORD FROM USERS WHERE USER_PHONE=" + phonenumber;
                    OracleDataReader reader = cmd.ExecuteReader();
                    if (!reader.Read())
                    {
                        message = "用户电话号码不存在！";
                        reader.Dispose();
                        return message;
                    }
                    else
                    {
                        if (reader.GetString(0).Trim() == password)
                        {
                            message = "新密码不能与旧密码相同";
                            reader.Dispose();
                            return message;
                        }
                    }
                    reader.Dispose();
                    reader.Close();
                    cmd.CommandText = "UPDATE USERS SET USER_PASSWORD = '" + password + "' WHERE USER_PHONE=" + phonenumber;
                    cmd.ExecuteNonQuery();
                    Console.WriteLine(cmd.CommandText);
                    message = "success";
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    message = "其他错误：" + ex.Message;
                }
                return message;
            }
        }

        //获取用户信息
        public UserInfo getUserInfo(string user_ID)
        {
            UserInfo userInfo = new UserInfo();
            // 假设 con 是你的数据库连接对象
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    // 根据用户ID查询用户信息
                    cmd.CommandText = "SELECT user_ID, user_phone, user_password, user_address, user_balance, user_regTime, user_type FROM users WHERE user_ID = :userID";
                    cmd.Parameters.Add(new OracleParameter("userID", OracleDbType.Int32)).Value = Int32.Parse(user_ID);

                    // 执行查询，并读取结果
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            userInfo.message = "success";
                            userInfo.user_ID = reader["user_ID"].ToString();
                            userInfo.user_phone = reader["user_phone"].ToString();
                            userInfo.user_password = reader["user_password"].ToString();
                            userInfo.user_address = reader["user_address"].ToString();
                            userInfo.user_balance = reader["user_balance"].ToString();
                            userInfo.user_regTime = reader["user_regTime"].ToString();
                            userInfo.user_type = reader["user_type"].ToString();
                        }
                        else
                        {
                            userInfo.message = "用户不存在";
                        }
                    }
                }
                catch (OracleException ex)
                {
                    userInfo.message = "数据库操作异常：" + ex.Message;
                }
                catch (Exception ex)
                {
                    userInfo.message = "其他错误：" + ex.Message;
                }
            }
            return userInfo;
        }

        //获取顾客信息
        public CusInfo GetCusInfoWithLoves(string cusID)
        {
            CusInfo cusInfo = new CusInfo();
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "SELECT cus_ID, cus_nickname, cus_notes, cus_payPassword, cus_state FROM customer WHERE cus_ID = :cusID";
                    cmd.Parameters.Add(new OracleParameter("cusID", OracleDbType.Int32)).Value = Int32.Parse(cusID);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            cusInfo.cus_ID = reader["cus_ID"].ToString();
                            cusInfo.cus_nickname = reader["cus_nickname"].ToString();
                            cusInfo.cus_notes = reader["cus_notes"].ToString();
                            cusInfo.cus_payPassword = reader["cus_payPassword"].ToString();
                            cusInfo.cus_state = reader.GetBoolean("cus_state") ? "1" : "0"; // 转换为字符串类型
                        }
                        else
                        {
                            cusInfo.message = "顾客不存在";
                            return cusInfo;
                        }
                    }

                    // 查询顾客喜好信息
                    cmd.CommandText = "SELECT com_category FROM customer_love WHERE cus_ID = :cusID";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("cusID", OracleDbType.Int32)).Value = Int32.Parse(cusID);

                    cusInfo.cus_loves = new List<string>();
                    using (OracleDataReader loveReader = cmd.ExecuteReader())
                    {
                        while (loveReader.Read())
                        {
                            cusInfo.cus_loves.Add(loveReader["com_category"].ToString());
                        }
                    }

                    cusInfo.message = "success";
                }
                catch (OracleException ex)
                {
                    cusInfo.message = "数据库操作异常：" + ex.Message;
                }
                catch (Exception ex)
                {
                    cusInfo.message = "其他错误：" + ex.Message;
                }
            }
            return cusInfo;
        }

        //获取商家信息
        public StoInfo GetStoInfoWithCategories(string stoID)
        {
            StoInfo stoInfo = new StoInfo();
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    // 查询商家信息
                    cmd.CommandText = "SELECT sto_ID, sto_name, sto_introduction, sto_licenseImg, sto_state FROM store WHERE sto_ID = :stoID";
                    cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(stoID);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            stoInfo.sto_ID = reader["sto_ID"].ToString();
                            stoInfo.sto_name = reader["sto_name"].ToString();
                            stoInfo.sto_introduction = reader["sto_introduction"].ToString();
                            stoInfo.sto_licenseImg = reader["sto_licenseImg"].ToString();
                            stoInfo.sto_state = reader.GetByte("sto_state").ToString(); // 转换为字符串类型
                        }
                        else
                        {
                            stoInfo.message = "商家不存在";
                            return stoInfo;
                        }
                    }

                    // 查询商家主营类别信息
                    cmd.CommandText = "SELECT com_category FROM store_categories WHERE store_ID = :stoID";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(stoID);

                    stoInfo.categories = new List<string>();
                    using (OracleDataReader categoryReader = cmd.ExecuteReader())
                    {
                        while (categoryReader.Read())
                        {
                            stoInfo.categories.Add(categoryReader["com_category"].ToString());
                        }
                    }

                    stoInfo.message = "success";
                }
                catch (OracleException ex)
                {
                    stoInfo.message = "数据库操作异常：" + ex.Message;
                }
                catch (Exception ex)
                {
                    stoInfo.message = "其他错误：" + ex.Message;
                }
            }
            return stoInfo;
        }

        //获取所有图片的url
        public StoImg GetStoImg(string sto_ID)
        {
            StoImg stoImages = new StoImg();
            stoImages.imageURL = new List<string>();

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "SELECT sto_image FROM storeImage WHERE sto_ID = :stoID";
                    cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(sto_ID);

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string imageUrl = reader.GetString(0);
                            stoImages.imageURL.Add(imageUrl);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            return stoImages;
        }

        //更新用户信息
        public string UpdateUserInfo(string user_ID, string user_phone, string user_password, string user_address)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = "UPDATE USERS SET USER_PHONE = :phone, USER_PASSWORD = :password, USER_ADDRESS = :address " +
                        "WHERE USER_ID = :userID";
                    cmd.Parameters.Add("phone", OracleDbType.Varchar2).Value = user_phone;
                    cmd.Parameters.Add("password", OracleDbType.Varchar2).Value = user_password;
                    cmd.Parameters.Add("address", OracleDbType.Varchar2).Value = user_address;
                    cmd.Parameters.Add("userID", OracleDbType.Int32).Value = Int32.Parse(user_ID);
                    cmd.ExecuteNonQuery();
                    return "success";
                }
                catch (Exception ex)
                {
                    return "更新用户信息时发生错误(原因可能是电话号码已经被其他用户注册)：" + ex.Message;
                }
            }
        }

        //更行顾客信息
        public string UpdateCustomerInfo(string cus_ID, string cus_nickname, string cus_notes, string cus_payPassword)
        {
            string message = "";
            if (!IsCusExist(cus_ID))
            {
                return ("顾客不存在");
            }
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "UPDATE customer SET cus_nickname = :nickname, cus_notes = :notes, cus_payPassword = :payPassword WHERE cus_ID = :cusID";
                    cmd.Parameters.Add("nickname", OracleDbType.Varchar2).Value = cus_nickname;
                    cmd.Parameters.Add("notes", OracleDbType.Varchar2).Value = cus_notes;
                    cmd.Parameters.Add("payPassword", OracleDbType.Varchar2).Value = cus_payPassword;
                    cmd.Parameters.Add("cusID", OracleDbType.Int32).Value = Int32.Parse(cus_ID);
                    cmd.ExecuteNonQuery();
                    message = "success";
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                message = "其他错误：" + ex.Message;
            }
            return message;
        }

        //更改商家信息
        public string UpdateStoInfo(string stoID, string name, string introduction)
        {
            string message = "";
            if (!IsStoreExist(stoID))
            {
                return "商家不存在";
            }
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = "UPDATE store SET sto_name = :name, sto_introduction = :introduction WHERE sto_ID = :stoID";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = name;
                    cmd.Parameters.Add("introduction", OracleDbType.Varchar2).Value = introduction;
                    cmd.Parameters.Add("stoID", OracleDbType.Int32).Value = Int32.Parse(stoID);
                    cmd.ExecuteNonQuery();
                    message = "success";
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
                message = "数据库操作异常：" + ex.Message;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                message = "其他错误：" + ex.Message;
            }
            return message;
        }
        //删除数据库中相关图片信息
        public bool DelStoImg(string stoID, string url)
        {
            bool success = false;

            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    // 删除数据库中的记录
                    cmd.CommandText = "DELETE FROM storeImage WHERE sto_ID = :stoID AND sto_image = :url";
                    cmd.Parameters.Add(new OracleParameter("stoID", OracleDbType.Int32)).Value = Int32.Parse(stoID);
                    cmd.Parameters.Add(new OracleParameter("url", OracleDbType.Varchar2)).Value = url;
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // 在物理存储中删除图片文件
                        string filePath = Path.Combine(".\\wwwroot", url);
                        if (File.Exists(filePath))
                        {
                            File.Delete(filePath);
                        }

                        success = true;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            return success;
        }

        //充钱
        public bool RechargeMoney(string user_ID, string amount)
        {
            try
            {
                decimal rechargeAmount = Convert.ToDecimal(amount);
                using (OracleCommand updateCmd = con.CreateCommand())
                {
                    updateCmd.CommandText = "UPDATE users SET user_balance = user_balance + :rechargeAmount WHERE user_ID = :user_ID";
                    updateCmd.Parameters.Add("rechargeAmount", OracleDbType.Decimal).Value = rechargeAmount;
                    updateCmd.Parameters.Add("user_ID", OracleDbType.Varchar2, 10).Value = user_ID;
                    updateCmd.ExecuteNonQuery();
                }
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("充值失败：" + ex.Message);
                return false;
            }
        }
        //获取数据库中所用对应user_ID和cus_ID的信息
        public List<Chat> GetChatHistory(string cusID, string storeID)
        {
            List<Chat> chatHistoryForUser = new List<Chat>();
            try
            {
                // 准备 SQL 查询语句，并在其中进行排序
                string sqlQuery = "SELECT chat_time, cus_ID, store_ID, chat_content, chat_sender, chat_type" +
                                  " FROM chat " +
                                  "WHERE (cus_ID = :cusID AND store_ID = :storeID)" +
                                  "ORDER BY chat_time ASC"; // 按时间从小到大排序

                using (OracleCommand cmd = new OracleCommand(sqlQuery, con))
                {
                    // 添加参数到查询语句中
                    cmd.Parameters.Add(":cusID", OracleDbType.Int32).Value = cusID;
                    cmd.Parameters.Add(":storeID", OracleDbType.Int32).Value = storeID;

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Chat chat = new Chat
                            {
                                ChatTime = reader.GetDateTime(0).ToString(),
                                CusID = reader.GetInt32(1).ToString(),
                                StoreID = reader.GetInt32(2).ToString(),
                                ChatContent = reader.GetString(3),
                                ChatSender = reader.GetBoolean(4),
                                ChatType = reader.GetBoolean(5)
                            };
                            chatHistoryForUser.Add(chat);
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                // 处理数据库异常
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                // 处理其他异常
                Console.WriteLine("其他错误：" + ex.Message);
            }
            return chatHistoryForUser;
        }

        //将插入对应的聊天信息
        public void InsertChatIntoDataBase(Chat chat)
        {
            try
            {
                string sqlQuery = "INSERT INTO chat (chat_time, cus_ID, store_ID, chat_content, chat_sender, chat_type) " +
                                  "VALUES (:chatTime, :cusID, :storeID, :chatContent, :chatSender, :chatType)";

                using (OracleCommand cmd = new OracleCommand(sqlQuery, con))
                {
                    DateTime chatTime = DateTime.Parse(chat.ChatTime);
                    cmd.Parameters.Add(":chatTime", OracleDbType.TimeStamp).Value = chatTime;
                    cmd.Parameters.Add(":cusID", OracleDbType.Int32).Value = int.Parse(chat.CusID); // Convert to int
                    cmd.Parameters.Add(":storeID", OracleDbType.Int32).Value = int.Parse(chat.StoreID); // Convert to int
                    cmd.Parameters.Add(":chatContent", OracleDbType.Varchar2).Value = chat.ChatContent;
                    cmd.Parameters.Add(":chatSender", OracleDbType.Byte).Value = chat.ChatSender ? 1 : 0;
                    cmd.Parameters.Add(":chatType", OracleDbType.Byte).Value = chat.ChatType ? 1 : 0;
                    cmd.ExecuteNonQuery();
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他错误：" + ex.Message);
            }
        }

        //获取数据库中某用户的聊天列表，每条信息为该用户与其他用户的最新聊天信息
        public List<Chat> GetChatList(string user_ID)
        {
            List<Chat> chatList = new List<Chat>();
            try
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    string sqlQuery = "SELECT chat_time, cus_ID, store_ID, chat_content, chat_sender, chat_type " +
                  "FROM chat " +
                  "WHERE (cus_ID = :user_ID OR store_ID = :user_ID) " +
                  "AND chat_time IN (" +
                  "    SELECT MAX(chat_time) " +
                  "    FROM chat " +
                  "    WHERE cus_ID = :user_ID OR store_ID = :user_ID " +
                  "    GROUP BY CASE WHEN cus_ID = :user_ID THEN store_ID ELSE cus_ID END " +
                  ") " +
                  "ORDER BY chat_time DESC ";

                    cmd.CommandText = sqlQuery;
                    cmd.Parameters.Add(":user_ID", OracleDbType.Int32).Value = int.Parse(user_ID);

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Chat chat = new Chat
                            {
                                ChatTime = reader.GetDateTime(0).ToString("yyyy-MM-dd HH:mm:ss"),
                                CusID = reader.GetInt32(1).ToString(),
                                StoreID = reader.GetInt32(2).ToString(),
                                ChatContent = reader.GetString(3),
                                ChatSender = reader.GetBoolean(4),
                                ChatType = reader.GetBoolean(5)
                            };
                            chatList.Add(chat);
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他错误：" + ex.Message);
            }
            return chatList;
        }



        /********************************
         * lhx组后端函数如下：
         **********************************/


        /*插入某个特定的元组*/
        public int sqlInsertSingleItem(string sql)
        {
            Console.WriteLine("Get into function 'sqlInsertSingleItem'");
            int flag = 1;
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = sql;
                    Console.WriteLine("In function 'sqlInsertSingleItem' gotta excute :" + sql);
                    int rowsUpdated = cmd.ExecuteNonQuery();
                    Console.WriteLine(rowsUpdated + " rows updated");
                    Console.WriteLine("func sqlInsert sucessed!");
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Go wrong in function 'sqlInsertSingleItem'");
                    Console.WriteLine(ex.Message);
                    flag = -1;
                    return flag;
                }
                return flag;
            }
        }


        /*原子化插入一组sql语句*/
        public int sqlInsertAtomicity(List<string> sql)
        {
            Console.WriteLine("Get into function 'sqlInsertAtomicity'");
            int flag = 1;
            OracleTransaction transaction = con.BeginTransaction();
            try
            {
                for (int i = 0; i < sql.Count; i++)
                {
                    var cmd = con.CreateCommand();
                    cmd.CommandText = sql[i];
                    Console.WriteLine("No. " + (i + 1) + " sql： " + cmd.CommandText);
                    cmd.ExecuteNonQuery();
                }
                transaction.Commit();
                Console.WriteLine("we have succesfully executed " + sql.Count + " sql sentences");
                return flag;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Go wrong in function 'sqlInsertAtomicity'");
                Console.WriteLine(ex.Message);
                flag = -1;
                transaction.Rollback();
                return flag;
            }

        }
        public string ImageToBase64(string imagePath)
        {
            byte[] image = File.ReadAllBytes(imagePath);
            var str = "data:image/jpeg;base64," + Convert.ToBase64String(image);
            return str;

        }
        /*
        var base64 = "";
        base64 = base64.Replace("data:image/png;base64,", "").Replace("data:image/jgp;base64,", "").Replace("data:image/jpg;base64,", "").Replace("data:image/jpeg;base64,", "");//将base64头部信息替换
        byte[] bytes = Convert.FromBase64String(base64);
        MemoryStream memStream = new MemoryStream(bytes);
        Image mImage = Image.FromStream(memStream);
        Bitmap bp = new Bitmap(mImage);
        MemoryStream ms = new MemoryStream();
        bp.Save(DateTime.Now.ToString("yyyyMMddHHss") + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);//注意保存路径

        */

        /*根据输入的字符串对商品名称进行模糊匹配，返回搜索到的一组商品详情*/
        public List<CommodityListModel> sqlSearchCommodityByName(searchCommodityModel model)
        {
            // 0-评分排序；1-地理位置排序；2到期日期排序；3-现价排序；4-推荐算法排序
            DateTime date = DateTime.Now;
            Console.WriteLine($"current time =>{date}");
            var list = new List<CommodityListModel>();

            var sqlArray = string.Join(",", model.com_categories.Select(c => $"'{c}'"));

            var sqlCategories_1 = "";
            var sqlCategories_2 = "";
            var sqlSortCF = "";
            if (model.com_categories.Count > 0)
            {
                sqlCategories_1 =
                $"WITH FAVOR_COM_ID AS (" +
                $" SELECT COM_ID AS SUB_ID" +
                $" FROM COMMODITY_CATEGORIES" +
                $" WHERE COM_CATEGORY IN ({sqlArray}) " +
                $" GROUP BY COM_ID" +
                $" )";
                sqlCategories_2 = "AND COMMODITY.COM_ID IN(SELECT SUB_ID FROM FAVOR_COM_ID)";
            }
            if (model.sort_order != 4)
            {
                sqlSortCF = $"COM_NAME LIKE '%{model.search_str}%' AND";
                Console.WriteLine("当前非算法排序");
            }
            var searchSql =
            "   SELECT DISTINCT" +
            "   COMMODITY.COM_ID," +
            "   COM_NAME," +
            "   COM_INTRODUCTION," +
            "   COM_ORIPRICE," +
            "   COM_EXPIRATIONDATE," +
            "   COM_UPLOADDATE," +
            "   COM_LEFT," +
            "   COM_RATING," +
            "   COMMODITY.STO_ID," +
            "   STORE.STO_NAME," +
            "   COM_STATUS," +
            "   LISTAGG(COM_IMAGE, ',') WITHIN GROUP(ORDER BY COM_IMAGE) AS IMGS," +
            "   LISTAGG(COM_CATEGORY, ',') WITHIN GROUP(ORDER BY COM_CATEGORY) AS CATEGORIES," +
            "   LISTAGG(COM_PC_TIME, ',') WITHIN GROUP(ORDER BY COM_PC_TIME) AS PC_TIME," +
            "   LISTAGG(COM_PC_PRICE, ',') WITHIN GROUP(ORDER BY COM_PC_PRICE DESC) AS PC_PRICE," +
            "   LISTAGG( FAVORITE.CUS_ID,',') WITHIN GROUP(ORDER BY  FAVORITE.CUS_ID) AS CUS_IDS" +
            "   FROM COMMODITY" +
            "   JOIN STORE ON COMMODITY.STO_ID = STORE.STO_ID" +
            "   JOIN COMMODITY_CATEGORIES  ON COMMODITY.COM_ID = COMMODITY_CATEGORIES.COM_ID" +
            "   JOIN COMMODITY_IMAGE  ON COMMODITY.COM_ID = COMMODITY_IMAGE.COM_ID" +
            "   LEFT JOIN FAVORITE ON COMMODITY.COM_ID = FAVORITE.COM_ID" +
            "   LEFT JOIN COMMODITY_PRICE_CURVE ON COMMODITY.COM_ID = COMMODITY_PRICE_CURVE.COM_ID" +
            $"  WHERE {sqlSortCF} COM_STATUS != -1 {sqlCategories_2} " +
            "   GROUP BY " +
            "   COMMODITY.COM_ID," +
            "   COM_NAME," +
            "   COM_INTRODUCTION," +
            "   COM_ORIPRICE," +
            "   COM_EXPIRATIONDATE," +
            "   COM_UPLOADDATE," +
            "   COM_LEFT," +
            "   COM_RATING," +
            "   COMMODITY.STO_ID," +
            "   STORE.STO_NAME," +
            "   COM_STATUS";

            searchSql = sqlCategories_1 + searchSql;
            var sortSql = "";
            bool isSorted = false;
            switch (model.sort_order)
            {
                case 0:
                    //sortSql = " ORDER BY COM_RATING DESC";
                    isSorted = false;
                    break;
                case 1:
                    isSorted = false;
                    break;
                case 2:
                    //sortSql = " ORDER BY COM_EXPIRATIONDATE DESC";
                    isSorted = false;
                    break;
                case 3:
                    break;
                case 4:
                    break;
                default:
                    break;
            }
            searchSql += sortSql;
            int i = 0;

            //搜索商品
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();
                    OracleCommand cmd_sub = new OracleCommand("GetCommodityDetails", con);
                    while (reader.Read())
                    {
                        var searchModel = new CommodityListModel();
                        searchModel.com_id = reader.GetInt32(0);
                        searchModel.com_name = reader.GetString(1);
                        searchModel.com_introduction = reader.GetString(2);
                        searchModel.com_oriPrice = reader.GetDouble(3);
                        searchModel.com_expirationDate = reader.GetDateTime(4).ToString("yyyy-MM-dd");
                        searchModel.com_uploadDate = reader.GetDateTime(5).ToString("yyyy-MM-dd");
                        searchModel.com_left = reader.GetInt32(6);
                        searchModel.com_rating = reader.GetDouble(7);
                        searchModel.sto_id = reader.GetDouble(8);
                        searchModel.sto_name = reader.GetString(9);
                        searchModel.com_status = reader.GetInt32(10);
                        Console.WriteLine($"{searchModel.com_id}:");

                        string column1Value = reader["IMGS"] == DBNull.Value ? "-1" : reader["IMGS"].ToString();
                        if (column1Value != "-1")
                        {
                            Console.WriteLine("IMGS:");
                            searchModel.com_firstImage = column1Value.Split(',')[0].Substring(10);
                            Console.WriteLine(searchModel.com_firstImage);
                        }

                        string column2Value = reader["CATEGORIES"] == DBNull.Value ? "-1" : reader["CATEGORIES"].ToString();
                        if (column2Value != "-1")
                        {
                            Console.WriteLine("CATEGORIES:");
                            var temp = column2Value.Split(',').ToList();
                            searchModel.com_categories = temp.Distinct().ToList();
                            foreach (var item in searchModel.com_categories)
                            {
                                Console.WriteLine(item);
                            }
                        }

                        string column3Value = reader["CUS_IDS"] == DBNull.Value ? "-1" : reader["CUS_IDS"].ToString();
                        if (column3Value != "-1")
                        {
                            Console.WriteLine("CUS_IDS:");
                            var temp = column3Value.Split(',').ToList().Distinct().ToList();

                            foreach (var item in temp)
                            {
                                Console.WriteLine(item);
                            }
                            if (temp.Contains($"{model.cus_id}"))
                                searchModel.favor_state = 1;
                            else
                                searchModel.favor_state = 0;
                        }
                        else
                        {
                            searchModel.favor_state = 0;
                        }

                        string column4Value = reader["PC_TIME"] == DBNull.Value ? "-1" : reader["PC_TIME"].ToString();
                        string column5Value = reader["PC_PRICE"] == DBNull.Value ? "-1" : reader["PC_PRICE"].ToString();
                        var com_pcs = new List<PriceCurveModel>();
                        var o_pc_node = new PriceCurveModel();
                        var e_pc_node = new PriceCurveModel();
                        o_pc_node.com_pc_price = searchModel.com_oriPrice;
                        o_pc_node.com_pc_time = searchModel.com_uploadDate;
                        e_pc_node.com_pc_time = DateTime.Parse(searchModel.com_expirationDate).AddDays(1).ToString("yyyy-MM-dd");
                        e_pc_node.com_pc_price = 0;
                        com_pcs.Add(o_pc_node);
                        com_pcs.Add(e_pc_node);
                        if (column4Value != "-1" && column5Value != "-1")
                        {
                            Console.WriteLine("PRICE:");
                            var tempDate = column4Value.Split(',').ToList().Distinct().ToList();
                            var tempPc = column5Value.Split(',').ToList().Distinct().ToList();
                            for (int j = 0; j < tempDate.Count; j++)
                            {
                                var node = new PriceCurveModel();
                                var dateStr = tempDate[j];
                                dateStr = dateStr.Replace("月", "").Trim();
                                dateStr = dateStr.Replace(" ", "");

                                var parts = dateStr.Split('-');

                                if (parts.Length == 3)
                                {
                                    dateStr = $"{int.Parse(parts[0]):00}-{int.Parse(parts[1]):00}-{int.Parse(parts[2]):00}";
                                }

                                DateTime dt;

                                if (DateTime.TryParseExact(dateStr, "dd-MM-yy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
                                {
                                    Console.WriteLine("Date parsed successfully: " + dt);
                                }
                                else
                                {
                                    Console.WriteLine("Failed to parse the date.");
                                }
                                node.com_pc_time = dt.ToString("yyyy-MM-dd");
                                node.com_pc_price = Double.Parse(tempPc[j]);
                                Console.WriteLine(node.com_pc_time);
                                Console.WriteLine(node.com_pc_price);
                                com_pcs.Add((node));
                            }
                            com_pcs.Sort((x, y) => y.com_pc_price.CompareTo(x.com_pc_price));
                            if (com_pcs[0].com_pc_time == com_pcs[1].com_pc_time)
                            {
                                com_pcs.RemoveAt(0);
                            }

                        }
                        searchModel.com_price = sqlGetCommodityCurrPriceNew(com_pcs);
                        list.Add(searchModel);
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In searchCommodityByName function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }
            if (!isSorted && model.sort_order == 3)
            {
                list.Sort((x, y) => x.com_price.CompareTo(y.com_price));
                Console.WriteLine("当前属于价格排序");
            }
            else if (!isSorted && model.sort_order == 4)
            {
                var CFList = sqlGetComID(model.cus_id);
                list.Sort((x, y) => CFList.IndexOf(x.com_id).CompareTo(CFList.IndexOf(y.com_id)));
                Console.WriteLine("当前属于算法排序");
            }
            else if (!isSorted && model.sort_order == 1)
            {
                var idList = sqlGetStorageID(model.cus_id);
                list.Sort((x, y) => idList.IndexOf((int)x.sto_id).CompareTo(idList.IndexOf((int)y.sto_id)));
                Console.WriteLine("当前属于地理位置排序");
            }
            else if (!isSorted && model.sort_order == 0)
            {
                list.Sort((x, y) => y.com_rating.CompareTo(x.com_rating));
                Console.WriteLine("当前属于评分排序");
            }
            else if (!isSorted && model.sort_order == 2)
            {
                list.Sort((x, y) => DateTime.Parse(y.com_expirationDate).CompareTo(DateTime.Parse(x.com_expirationDate)));
                Console.WriteLine("当前属于价格排序");
            }

            date = DateTime.Now;
            Console.WriteLine($"current time =>{date}");
            return list;
        }



        /*搜索特定ID客户的喜欢商品*/
        public List<CommodityListModel> sqlSearchFavorCommodity(int cus_id)
        {
            DateTime date = DateTime.Now;
            Console.WriteLine($"current time =>{date}");
            var list = new List<CommodityListModel>();
            var searchSql =
                $"SELECT " +
                $" FAVORITE.COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,COMMODITY.STO_ID,STORE.STO_NAME,COM_STATUS" +
                $" FROM COMMODITY,STORE,FAVORITE" +
                $" WHERE FAVORITE.CUS_ID ={cus_id} AND FAVORITE.COM_ID= COMMODITY.COM_ID AND COMMODITY.STO_ID=STORE.STO_ID" +
                $" ORDER BY COM_RATING DESC";
            Console.WriteLine("In sqlSearchFavorCommodity function going to execute: " + searchSql + "\n");
            //搜索商品
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var searchModel = new CommodityListModel();
                        searchModel.com_id = reader.GetInt32(0);
                        searchModel.com_name = reader.GetString(1);
                        searchModel.com_introduction = reader.GetString(2);
                        searchModel.com_oriPrice = reader.GetDouble(3);
                        searchModel.com_expirationDate = reader.GetDateTime(4).ToString("yyyy-MM-dd");
                        searchModel.com_uploadDate = reader.GetDateTime(5).ToString("yyyy-MM-dd");
                        searchModel.com_left = reader.GetInt32(6);
                        searchModel.com_rating = reader.GetDouble(7);
                        searchModel.sto_id = reader.GetDouble(8);
                        searchModel.sto_name = reader.GetString(9);
                        searchModel.favor_state = 1;
                        searchModel.com_status = reader.GetInt32(10);
                        //搜索某个商品的商品类别
                        using (var cmdFitCategory = con.CreateCommand())
                        {
                            var fitCategorySql = $"SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = {searchModel.com_id}";
                            cmdFitCategory.CommandText = fitCategorySql;
                            Console.WriteLine("In sqlSearchFavorCommodity function going to execute: " + fitCategorySql);
                            OracleDataReader readerFitCategory = cmdFitCategory.ExecuteReader();

                            while (readerFitCategory.Read())
                            {
                                searchModel.com_categories.Add(readerFitCategory.GetString(0));
                            }
                            readerFitCategory.Dispose();
                            readerFitCategory.Close();
                            Console.WriteLine("finish fitCategorySql");
                        }

                        //搜索固定商品的头图
                        using (var cmdFitFirImage = con.CreateCommand())
                        {
                            var fitFirImageSql = $"SELECT * FROM COMMODITY_IMAGE WHERE COM_ID={searchModel.com_id} ORDER BY COM_ID DESC ";
                            Console.WriteLine("In sqlSearchFavorCommodity function going to execute: " + fitFirImageSql);
                            cmdFitFirImage.CommandText = fitFirImageSql;
                            OracleDataReader readerFitFirImage = cmdFitFirImage.ExecuteReader();
                            if (readerFitFirImage.HasRows)
                            {
                                readerFitFirImage.Read();
                                searchModel.com_firstImage = readerFitFirImage.GetString(1).Substring(10);
                                readerFitFirImage.Dispose();
                                readerFitFirImage.Close();
                                Console.WriteLine("finish FitFirImageSql");
                            }
                            else { Console.WriteLine($"The commodity with id={searchModel.com_id} has no image"); }
                        }
                        searchModel.com_price = sqlGetCommodityCurrPrice(searchModel.com_id);
                        list.Add(searchModel);
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In sqlSearchFavorCommodity function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }
            return list;
        }

        /*搜索特定ID客户的浏览记录*/
        public List<HistoryModel> sqlSearchBrowseHistory(GetBrowsingHistoryModel model)
        {
            DateTime date = DateTime.Now;
            Console.WriteLine($"current time =>{date}");
            var list = new List<HistoryModel>();
            var searchSql =
                $"  SELECT " +
                $"  COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,STO_ID,STO_NAME,COM_STATUS," +
                "   IMGS," +
                "   CATEGORIES," +
                "   PC_TIME," +
                "   PC_PRICE," +
                "   CUS_IDS," +
                "   BRO_TIME_END FROM (" +
                $"  SELECT " +
                $"  BROWSE.COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,COMMODITY.STO_ID,STORE.STO_NAME,COM_STATUS," +
                "   LISTAGG(COM_IMAGE, ',') WITHIN GROUP(ORDER BY COM_IMAGE) AS IMGS," +
                "   LISTAGG(COM_CATEGORY, ',') WITHIN GROUP(ORDER BY COM_CATEGORY) AS CATEGORIES," +
                "   LISTAGG(COM_PC_TIME, ',') WITHIN GROUP(ORDER BY COM_PC_TIME) AS PC_TIME," +
                "   LISTAGG(COM_PC_PRICE, ',') WITHIN GROUP(ORDER BY COM_PC_PRICE DESC) AS PC_PRICE," +
                "   LISTAGG(FAVORITE.CUS_ID,',') WITHIN GROUP(ORDER BY  FAVORITE.CUS_ID) AS CUS_IDS," +
                "   ROW_NUMBER() OVER(ORDER BY BRO_TIME_END DESC) as row_num," +
                "   BROWSE.BRO_TIME_END" +
                $"  FROM BROWSE " +
                "   LEFT JOIN COMMODITY ON BROWSE.COM_ID = COMMODITY.COM_ID" +
                "   LEFT JOIN STORE ON COMMODITY.STO_ID = STORE.STO_ID" +
                "   LEFT JOIN COMMODITY_CATEGORIES  ON COMMODITY.COM_ID = COMMODITY_CATEGORIES.COM_ID" +
                "   LEFT JOIN COMMODITY_IMAGE  ON COMMODITY.COM_ID = COMMODITY_IMAGE.COM_ID" +
                "   LEFT JOIN FAVORITE ON COMMODITY.COM_ID = FAVORITE.COM_ID" +
                "   LEFT JOIN COMMODITY_PRICE_CURVE ON COMMODITY.COM_ID = COMMODITY_PRICE_CURVE.COM_ID" +
                $"  WHERE BROWSE.BROWSER_ID ={model.cus_id} AND BROWSE.COM_ID= COMMODITY.COM_ID AND COMMODITY.STO_ID=STORE.STO_ID AND COMMODITY.COM_NAME LIKE '%{model.search_str}%' " +
                "   GROUP BY " +
                "   BROWSE.COM_ID," +
                "   COM_NAME," +
                "   COM_INTRODUCTION," +
                "   COM_ORIPRICE," +
                "   COM_EXPIRATIONDATE," +
                "   COM_UPLOADDATE," +
                "   COM_LEFT," +
                "   COM_RATING," +
                "   COMMODITY.STO_ID," +
                "   STORE.STO_NAME," +
                "   COM_STATUS," +
                "   BROWSE.BRO_TIME_END" +
                $"  ORDER BY BRO_TIME_END DESC )"+
                $"  WHERE  row_num>={model.begin_pos} and row_num  < {model.end_pos} ";
            Console.WriteLine("In sqlSearchBrowseHistory function going to execute: " + searchSql + "\n");
            //搜索商品
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Console.WriteLine("\nsqlSearchBrowseHistory\n " );
                        var searchModel = new HistoryModel();
                        searchModel.com_id = reader.GetInt32(0);
                        searchModel.com_name = reader.GetString(1);
                        searchModel.com_introduction = reader.GetString(2);
                        searchModel.com_oriPrice = reader.GetDouble(3);
                        searchModel.com_expirationDate = reader.GetDateTime(4).ToString("yyyy-MM-dd");   
                        searchModel.com_uploadDate = reader.GetDateTime(5).ToString("yyyy-MM-dd");        
                        searchModel.com_left = reader.GetInt32(6);
                        searchModel.com_rating = reader.GetDouble(7);
                        searchModel.sto_id = reader.GetDouble(8);
                        searchModel.sto_name = reader.GetString(9);
                        searchModel.com_status = reader.GetInt32(10);
                        searchModel.bro_time_end = reader.GetDateTime(16).ToString("yyyy-MM-dd HH:mm:ss");

                        string column1Value = reader["IMGS"] == DBNull.Value ? "-1" : reader["IMGS"].ToString();
                        if (column1Value != "-1")
                        {
                            Console.WriteLine("IMGS:");
                            searchModel.com_firstImage = column1Value.Split(',')[0].Substring(10);
                            Console.WriteLine(searchModel.com_firstImage);
                        }

                        string column2Value = reader["CATEGORIES"] == DBNull.Value ? "-1" : reader["CATEGORIES"].ToString();
                        if (column2Value != "-1")
                        {
                            Console.WriteLine("CATEGORIES:");
                            var temp = column2Value.Split(',').ToList();
                            searchModel.com_categories = temp.Distinct().ToList();
                            foreach (var item in searchModel.com_categories)
                            {
                                Console.WriteLine(item);
                            }
                        }

                        string column3Value = reader["CUS_IDS"] == DBNull.Value ? "-1" : reader["CUS_IDS"].ToString();
                        if (column3Value != "-1")
                        {
                            Console.WriteLine("CUS_IDS:");
                            var temp = column3Value.Split(',').ToList().Distinct().ToList();

                            foreach (var item in temp)
                            {
                                Console.WriteLine(item);
                            }
                            if (temp.Contains($"{model.cus_id}"))
                                searchModel.favor_state = 1;
                            else
                                searchModel.favor_state = 0;
                        }
                        else
                        {
                            searchModel.favor_state = 0;
                        }

                        string column4Value = reader["PC_TIME"] == DBNull.Value ? "-1" : reader["PC_TIME"].ToString();
                        string column5Value = reader["PC_PRICE"] == DBNull.Value ? "-1" : reader["PC_PRICE"].ToString();
                        var com_pcs = new List<PriceCurveModel>();
                        var o_pc_node = new PriceCurveModel();
                        var e_pc_node = new PriceCurveModel();
                        o_pc_node.com_pc_price = searchModel.com_oriPrice;
                        o_pc_node.com_pc_time = searchModel.com_uploadDate;
                        e_pc_node.com_pc_time = DateTime.Parse(searchModel.com_expirationDate).AddDays(1).ToString("yyyy-MM-dd");
                        e_pc_node.com_pc_price = 0;
                        com_pcs.Add(o_pc_node);
                        com_pcs.Add(e_pc_node);
                        if (column4Value != "-1" && column5Value != "-1")
                        {
                            Console.WriteLine("PRICE:");
                            var tempDate = column4Value.Split(',').ToList().Distinct().ToList();
                            var tempPc = column5Value.Split(',').ToList().Distinct().ToList();
                            for (int j = 0; j < tempDate.Count; j++)
                            {
                                var node = new PriceCurveModel();
                                var dateStr = tempDate[j];
                                dateStr = dateStr.Replace("月", "").Trim();
                                dateStr = dateStr.Replace(" ", "");

                                var parts = dateStr.Split('-');

                                if (parts.Length == 3)
                                {
                                    dateStr = $"{int.Parse(parts[0]):00}-{int.Parse(parts[1]):00}-{int.Parse(parts[2]):00}";
                                }

                                DateTime dt;

                                if (DateTime.TryParseExact(dateStr, "dd-MM-yy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
                                {
                                    Console.WriteLine("Date parsed successfully: " + dt);
                                }
                                else
                                {
                                    Console.WriteLine("Failed to parse the date.");
                                }
                                node.com_pc_time = dt.ToString("yyyy-MM-dd");
                                node.com_pc_price = Double.Parse(tempPc[j]);
                                Console.WriteLine(node.com_pc_time);
                                Console.WriteLine(node.com_pc_price);
                                com_pcs.Add((node));
                            }
                            com_pcs.Sort((x, y) => y.com_pc_price.CompareTo(x.com_pc_price));
                            if (com_pcs[0].com_pc_time == com_pcs[1].com_pc_time)
                            {
                                com_pcs.RemoveAt(0);
                            }
                        }
                        searchModel.com_price = sqlGetCommodityCurrPriceNew(com_pcs);
                        list.Add(searchModel);
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In sqlSearchBrowseHistory function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }
            return list;
        }

        public int sqlSearchBrowseHistoryNumber(int cus_id)
        {
            var sql = $"SELECT BROWSER_ID ,COUNT(*) FROM BROWSE WHERE BROWSER_ID = {cus_id} GROUP BY BROWSER_ID";
            int num = 0;
            using(var cmd=con.CreateCommand())
            {
                cmd.CommandText = sql;
                var reader=cmd.ExecuteReader();
                while (reader.Read())
                {
                    num = reader.GetInt32(1);
                }
                reader.Dispose();
                reader.Close();
            }
            return num;

        }

        /*按照商品的ID搜索商品*/
        public CommodityDetailModel sqlSearchCommodityByID(int com_id, int cus_id)
        {
            Console.WriteLine("Get into function searchCommodityByID \n");
            DateTime date = DateTime.Now;
            var searchSql =
                $"SELECT " +
                $" COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,COMMODITY.STO_ID,STORE.STO_NAME,COM_STATUS" +
                $" FROM COMMODITY, STORE" +
                $" WHERE COM_ID ={com_id} AND COMMODITY.STO_ID=STORE.STO_ID";
            Console.WriteLine("In searchCommodityByName function going to execute: " + searchSql + "\n");
            var searchModel = new CommodityDetailModel();
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {

                        searchModel.com_id = reader.GetInt32(0);
                        searchModel.com_name = reader.GetString(1);
                        searchModel.com_introduction = reader.GetString(2);
                        searchModel.com_oriPrice = reader.GetDouble(3);
                        searchModel.com_expirationDate = reader.GetDateTime(4).ToString("yyyy-MM-dd");
                        searchModel.com_uploadDate = reader.GetDateTime(5).ToString("yyyy-MM-dd");
                        searchModel.com_left = reader.GetInt32(6);
                        searchModel.com_rating = reader.GetDouble(7);
                        searchModel.sto_id = reader.GetDouble(8);
                        searchModel.sto_name = reader.GetString(9);
                        searchModel.com_status = reader.GetInt32(10);
                        using (var cmdFitCategory = con.CreateCommand())
                        {
                            var fitCategorySql = $"SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = {searchModel.com_id}";
                            cmdFitCategory.CommandText = fitCategorySql;
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitCategorySql);
                            OracleDataReader readerFitCategory = cmdFitCategory.ExecuteReader();

                            while (readerFitCategory.Read())
                            {
                                searchModel.com_categories.Add(readerFitCategory.GetString(0));

                            }
                            readerFitCategory.Dispose();
                            readerFitCategory.Close();
                            Console.WriteLine("finish fitCategorySql");
                        }
                        using (var cmdFitImage = con.CreateCommand())
                        {
                            var fitImageSql = $"SELECT * FROM COMMODITY_IMAGE WHERE COM_ID={searchModel.com_id} ORDER BY COM_ID DESC ";
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitImageSql);
                            cmdFitImage.CommandText = fitImageSql;
                            OracleDataReader readerFitImage = cmdFitImage.ExecuteReader();
                            while (readerFitImage.Read())
                            {
                                searchModel.com_images.Add(readerFitImage.GetString(1).Substring(10));
                            }
                            readerFitImage.Dispose();
                            readerFitImage.Close();
                            Console.WriteLine("finish FitImageSql");
                        }
                        using (var cmdFitPrice = con.CreateCommand())
                        {

                            var fitPriceSql = $"SELECT COM_PC_TIME,COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID ={searchModel.com_id} ORDER BY COM_PC_TIME ASC";
                            cmdFitPrice.CommandText = fitPriceSql;
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitPriceSql);
                            OracleDataReader readerFitPrice = cmdFitPrice.ExecuteReader();
                            //double subPrice = -1;
                            //bool findCurrPrice = false;
                            var uploadPriceNode = new PriceCurveModel();
                            uploadPriceNode.com_pc_price = searchModel.com_oriPrice;
                            uploadPriceNode.com_pc_time = searchModel.com_uploadDate;

                            var exPriceNode = new PriceCurveModel();
                            exPriceNode.com_pc_price = 0;
                            exPriceNode.com_pc_time = DateTime.Parse(searchModel.com_expirationDate).AddDays(1).ToString("yyyy-MM-dd");
                            searchModel.com_prices.Add(uploadPriceNode);
                            searchModel.com_prices.Add(exPriceNode);
                            while (readerFitPrice.Read())
                            {
                                var singlePriceNode = new PriceCurveModel();
                                //double temp = (int)(readerFitPrice.GetDouble(1) * searchModel.com_oriPrice * 100);
                                singlePriceNode.com_pc_price = readerFitPrice.GetDouble(1);

                                singlePriceNode.com_pc_time = readerFitPrice.GetDateTime(0).ToString("yyyy-MM-dd");
                                searchModel.com_prices.Add(singlePriceNode);
                            }
                            searchModel.com_prices.Sort((x, y) => y.com_pc_price.CompareTo(x.com_pc_price));
                            //价格一定一个比一个低
                            //节点不能重复
                            if (searchModel.com_prices[0].com_pc_time == searchModel.com_prices[1].com_pc_time)
                            {
                                searchModel.com_prices.RemoveAt(0);
                            }
                            searchModel.com_price = sqlGetCommodityCurrPrice(searchModel.com_id);
                            readerFitPrice.Dispose();
                            readerFitPrice.Close();
                            Console.WriteLine("finish fitPriceSql\n");
                        }
                        using (var cmdFitFavor = con.CreateCommand())
                        {
                            var sqlQuery = $"SELECT * FROM FAVORITE WHERE COM_ID ={searchModel.com_id} AND CUS_ID ={cus_id}";
                            cmdFitFavor.CommandText = sqlQuery;
                            var my_reader = cmdFitFavor.ExecuteReader();
                            Console.WriteLine(sqlQuery);
                            if (my_reader.HasRows)
                            {
                                searchModel.favor_state = 1;
                            }
                            else
                            {
                                searchModel.favor_state = 0;
                            }
                            my_reader.Dispose();
                            my_reader.Close();
                        }
                        using (var cmdFitCmt = con.CreateCommand())
                        {
                            var fitCmtSql = $"SELECT * FROM COMMODITY_COMMENT WHERE COM_ID = {searchModel.com_id}";
                            cmdFitCmt.CommandText = fitCmtSql;
                            Console.WriteLine("In searchCommodityByID function going to execute: " + fitCmtSql);
                            OracleDataReader readerFitCmt = cmdFitCmt.ExecuteReader();

                            while (readerFitCmt.Read())
                            {

                                var comment = new SendCommentModel();
                                comment.cmt_time = readerFitCmt.GetDateTime(3).ToString("yyyy-MM-dd HH:mm:ss");
                                comment.cmt_id = readerFitCmt.GetInt32(0);
                                comment.cmt_father = readerFitCmt.GetInt32(1);
                                comment.cmt_content = readerFitCmt.GetString(2);
                                comment.com_id = readerFitCmt.GetInt32(4);
                                comment.user_id = readerFitCmt.GetInt32(5);
                                using (var cmdFitUserType = con.CreateCommand())
                                {
                                    var sqlFitUserType = $"SELECT USER_TYPE FROM USERS WHERE USER_ID = {comment.user_id}";
                                    cmdFitUserType.CommandText = sqlFitUserType;
                                    var readerFitUserType = cmdFitUserType.ExecuteReader();
                                    var sqlFitUser = "";
                                    Console.WriteLine("In searchCommodityByID function going to execute: " + sqlFitUserType);
                                    while (readerFitUserType.Read())
                                    {
                                        if (readerFitUserType.GetInt32(0) == 0)
                                        {
                                            sqlFitUser = $"SELECT CUS_NICKNAME FROM CUSTOMER WHERE CUS_ID = {comment.user_id}";
                                            comment.user_type = 0;
                                            using (var cmdFitBuyTimes = con.CreateCommand())
                                            {
                                                var sqlFitBuyTimes =
                                                    $"SELECT COUNT (*) " +
                                                    $"FROM INDENT " +
                                                    $"WHERE COM_ID = {comment.com_id} AND CUS_ID = {comment.user_id} " +
                                                    $"GROUP BY CUS_ID ";
                                                cmdFitBuyTimes.CommandText = sqlFitBuyTimes;
                                                Console.WriteLine("In searchCommodityByID function going to execute: " + sqlFitBuyTimes);
                                                var readerFitBuyTimes = cmdFitBuyTimes.ExecuteReader();

                                                while (readerFitBuyTimes.Read())
                                                {
                                                    comment.buying_times = readerFitBuyTimes.GetInt32(0);
                                                    break;
                                                }
                                            }
                                        }
                                        else if (readerFitUserType.GetInt32(0) == 1)
                                        {
                                            sqlFitUser = $"SELECT STO_NAME FROM STORE WHERE STO_ID = {comment.user_id}";
                                            comment.user_type = 1;
                                            comment.buying_times = 0;
                                        }
                                        else
                                        {
                                            Console.WriteLine("Something Wrong In cmdFitUserType");
                                        }
                                        using (var cmdFitUser = con.CreateCommand())
                                        {
                                            cmdFitUser.CommandText = sqlFitUser;
                                            Console.WriteLine("In searchCommodityByID function going to execute: " + sqlFitUser);
                                            var readerUser = cmdFitUser.ExecuteReader();
                                            while (readerUser.Read())
                                            {
                                                comment.cmt_name = readerUser.GetString(0);
                                            }
                                        }
                                        break;
                                    }
                                    readerFitUserType.Dispose();
                                    readerFitUserType.Close();
                                }

                                Console.WriteLine(comment.cmt_content);
                                if (comment != null)
                                    searchModel.comments.Add(comment);
                            }
                            readerFitCmt.Dispose();
                            readerFitCmt.Close();
                            Console.WriteLine("finish fitCategorySql");
                        }
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In searchCommodityByName function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }
            return searchModel;
        }

        public List<string> sqlSearchCategories()
        {
            var list = new List<string>();
            using (var cmd = con.CreateCommand())
            {
                var sql = $"SELECT * FROM COMMODITIES_CATEGORIES";
                cmd.CommandText = sql;
                Console.WriteLine("In searchCommodityByID function going to execute: " + sql);
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    list.Add(reader.GetString(0));
                reader.Dispose();
                reader.Close();
                Console.WriteLine("finish fitCategorySql");
            }
            return list;
        }
        public CommodityListModel sqlSearchShoppingCart(int com_id, int cus_id)
        {
            Console.WriteLine("Get into function searchCommodityByID \n");
            DateTime date = DateTime.Now;
            var searchSql =
                $"SELECT " +
                $" COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,COMMODITY.STO_ID,STORE.STO_NAME,COM_STATUS" +
                $" FROM COMMODITY, STORE" +
                $" WHERE COM_ID ={com_id} AND COMMODITY.STO_ID=STORE.STO_ID";
            Console.WriteLine("In searchCommodityByName function going to execute: " + searchSql + "\n");
            var searchModel = new CommodityListModel();
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Console.Write($"{reader.ToString()}");
                        searchModel.com_id = reader.GetInt32(0);
                        searchModel.com_name = reader.GetString(1);
                        searchModel.com_introduction = reader.GetString(2);
                        searchModel.com_oriPrice = reader.GetDouble(3);
                        searchModel.com_expirationDate = reader.GetDateTime(4).ToString("yyyy-MM-dd");
                        searchModel.com_uploadDate = reader.GetDateTime(5).ToString("yyyy-MM-dd");
                        searchModel.com_left = reader.GetInt32(6);
                        searchModel.com_rating = reader.GetDouble(7);
                        searchModel.sto_id = reader.GetDouble(8);
                        searchModel.sto_name = reader.GetString(9);
                        searchModel.com_status = reader.GetInt32(10);
                        using (var cmdFitCategory = con.CreateCommand())
                        {
                            var fitCategorySql = $"SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = {searchModel.com_id}";
                            cmdFitCategory.CommandText = fitCategorySql;
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitCategorySql);
                            OracleDataReader readerFitCategory = cmdFitCategory.ExecuteReader();

                            while (readerFitCategory.Read())
                            {
                                searchModel.com_categories.Add(readerFitCategory.GetString(0));

                            }
                            readerFitCategory.Dispose();
                            readerFitCategory.Close();
                            Console.WriteLine("finish fitCategorySql");
                        }
                        using (var cmdFitImage = con.CreateCommand())
                        {
                            var fitImageSql = $"SELECT * FROM COMMODITY_IMAGE WHERE COM_ID={searchModel.com_id} ORDER BY COM_ID DESC ";
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitImageSql);
                            cmdFitImage.CommandText = fitImageSql;
                            OracleDataReader readerFitImage = cmdFitImage.ExecuteReader();
                            while (readerFitImage.Read())
                            {
                                searchModel.com_firstImage = readerFitImage.GetString(1).Substring(10);
                                break;
                            }
                            readerFitImage.Dispose();
                            readerFitImage.Close();
                            Console.WriteLine("finish FitImageSql");
                        }

                        searchModel.com_price = sqlGetCommodityCurrPrice(searchModel.com_id);

                        using (var cmdFitFavor = con.CreateCommand())
                        {
                            var sqlQuery = $"SELECT * FROM FAVORITE WHERE COM_ID = {searchModel.com_id} AND CUS_ID ={cus_id}";
                            cmdFitFavor.CommandText = sqlQuery;
                            var my_reader = cmdFitFavor.ExecuteReader();
                            if (my_reader.HasRows)
                            {
                                searchModel.favor_state = 1;
                            }
                            else
                            {
                                searchModel.favor_state = 0;
                            }
                            my_reader.Dispose();
                            my_reader.Close();
                        }

                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In searchCommodityByName function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }
            return searchModel;
        }

        //按照商家名称搜索特定的商家，返回这些商家的基本信息和每个商家旗下三款商品的基本信息，用于商家搜索页面
        public List<StoreListModel> sqlSearchStoreByName(searchStoreModel model)
        {
            DateTime date = DateTime.Now;
            Console.WriteLine($"current time =>{date}");
            var list = new List<StoreListModel>();
            var sqlArray = string.Join(",", model.com_categories.Select(c => $"'{c}'"));
            Console.WriteLine(sqlArray);
            var sqlCategories_1 = "";
            var sqlCategories_2 = "";
            if (model.com_categories.Count > 0)
            {
                sqlCategories_1 =
                $" , FAVOR_STO_ID AS (" +
                $" SELECT STORE_CATEGORIES.STORE_ID AS SUB_ID" +
                $" FROM STORE_CATEGORIES" +
                $" WHERE COM_CATEGORY IN ({sqlArray}) " +
                $" GROUP BY STORE_CATEGORIES.STORE_ID" +
                $") ";
                sqlCategories_2 = "AND STORE.STO_ID IN (SELECT SUB_ID FROM FAVOR_STO_ID)";
            }
            string searchSql = @$"
                WITH STORE_INDENT_NUM AS (
                    SELECT STORE.STO_ID, COUNT(IND_ID) AS IND_NUM
                    FROM STORE, COMMODITY, INDENT
                    WHERE commodity.sto_id = store.sto_id AND commodity.com_id = indent.com_id
                    GROUP BY STORE.STO_ID
                ){sqlCategories_1}
                SELECT
                    STORE.STO_ID,
                    STO_NAME,
                    STO_INTRODUCTION,
                    USER_ADDRESS,
                    USER_REGTIME,
                    IND_NUM,
                    LISTAGG(STO_IMAGE, ',') WITHIN GROUP (ORDER BY STO_IMAGE) AS IMGS,
                    LISTAGG(COM_CATEGORY, ',') WITHIN GROUP (ORDER BY COM_CATEGORY) AS CATEGORIES
                FROM
                    STORE
                JOIN USERS ON STORE.STO_ID = USERS.USER_ID
                JOIN STOREIMAGE ON STOREIMAGE.STO_ID = STORE.STO_ID
                LEFT JOIN STORE_CATEGORIES ON STORE.STO_ID = STORE_CATEGORIES.STORE_ID
                LEFT JOIN STORE_INDENT_NUM ON STORE.STO_ID = STORE_INDENT_NUM.sto_id
                WHERE
                    STO_NAME LIKE '%{model.search_str}%'
                    AND STORE.STO_ID = USERS.USER_ID
                    {sqlCategories_2}
                GROUP BY
                    STORE.STO_ID,
                    STO_NAME,
                    STO_INTRODUCTION,
                    USER_ADDRESS,
                    USER_REGTIME,
                    IND_NUM
                ";

            //searchSql = sqlCategories_1 + searchSql;
            var sortSql = "";
            bool isSorted = false;
            switch (model.sort_order)
            {
                case 0:
                    isSorted = false;
                    break;
                case 1:
                    isSorted = false;//地理位置远近排序未实现
                    break;
                case 2:
                    sortSql = "ORDER BY USER_REGTIME DESC ";
                    break;
                default:
                    break;
            }
            searchSql += sortSql;
            Console.WriteLine("In 'searchStoreByName' function going to execute: " + searchSql + "\n");
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        var searchModel = new StoreListModel();
                        searchModel.sto_id = reader.GetInt32(0);
                        searchModel.sto_name = reader.GetString(1);
                        searchModel.sto_introduction = reader.GetString(2);
                        searchModel.user_address = reader.GetString(3);
                        searchModel.indentNum = reader["IND_NUM"] == DBNull.Value ? 0 : int.Parse(reader["IND_NUM"].ToString());
                        Console.WriteLine($"indentNum:{searchModel.indentNum}");
                        string column1Value = reader["IMGS"] == DBNull.Value ? "-1" : reader["IMGS"].ToString();
                        if (column1Value != "-1")
                        {
                            Console.WriteLine("IMGS:");
                            searchModel.sto_firstImage = column1Value.Split(',')[0];
                            Console.WriteLine(searchModel.sto_firstImage);
                        }

                        string column2Value = reader["CATEGORIES"] == DBNull.Value ? "-1" : reader["CATEGORIES"].ToString();
                        if (column2Value != "-1")
                        {
                            Console.WriteLine("CATEGORIES:");
                            var temp = column2Value.Split(',').ToList();
                            searchModel.com_categories = temp.Distinct().ToList();
                            foreach (var item in searchModel.com_categories)
                            {
                                Console.WriteLine(item);
                            }
                        }
                        list.Add(searchModel);
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In searchStoreByName function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }

            if (!isSorted && model.sort_order == 1)
            {
                Console.Write($"model.cus_id:{model.cus_id}");
                var idList = sqlGetStorageID(model.cus_id);
                list.Sort((x, y) => idList.IndexOf(x.sto_id).CompareTo(idList.IndexOf(y.sto_id)));
            }
            else if (!isSorted && model.sort_order == 0)
            {

                list.Sort((x, y) => y.indentNum.CompareTo(x.indentNum));
            }
            Console.WriteLine("finish searchStoreByName function");
            return list;
        }

        //按照商家ID搜索特定的商家，返回这个商家的基本信息和每个商家旗下三款商品的基本信息，用于商家详情页面
        public StoreDetailModel sqlSearchStoreByID(int sto_id, int cus_id)
        {

            Console.WriteLine("Get tnto searchStoreByID function ");
            DateTime date = DateTime.Now;
            Console.WriteLine($"current time =>{date}");
            var list = new List<StoreListModel>();
            var searchSql =
                $" SELECT " +
                $" STO_ID,STO_NAME,STO_INTRODUCTION,STO_LICENSEIMG,USER_ADDRESS" +
                $" FROM USERS,STORE" +
                $" WHERE STORE.STO_ID={sto_id} AND STORE.STO_ID=USERS.USER_ID";
            Console.WriteLine("In searchStoreByName function going to execute: " + searchSql + "\n");
            var searchModel = new StoreDetailModel();
            using (var cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandText = searchSql;
                    OracleDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {

                        searchModel.sto_id = reader.GetInt32(0);
                        searchModel.sto_name = reader.GetString(1);
                        searchModel.sto_introduction = reader.GetString(2);
                        searchModel.sto_licenseImg = reader.GetString(3);
                        searchModel.sto_licenseImg = reader.GetString(3);
                        searchModel.user_address = reader.GetString(4);

                        using (var cmdFitCategory = con.CreateCommand())
                        {
                            var FitCategorySql = $"SELECT COM_CATEGORY FROM STORE_CATEGORIES WHERE STORE_ID = {searchModel.sto_id}";
                            cmdFitCategory.CommandText = FitCategorySql;
                            Console.WriteLine("In searchCommodityByName function going to execute: " + FitCategorySql);
                            OracleDataReader readerFitCategory = cmdFitCategory.ExecuteReader();

                            while (readerFitCategory.Read())
                            {
                                searchModel.com_categories.Add(readerFitCategory.GetString(0));
                            }
                            readerFitCategory.Dispose();
                            readerFitCategory.Close();
                            Console.WriteLine("finish FitCategorySql");
                        }
                        using (var cmdFitImage = con.CreateCommand())
                        {
                            var fitImageSql = $"SELECT * FROM STOREIMAGE WHERE STO_ID={searchModel.sto_id} ";
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitImageSql);
                            cmdFitImage.CommandText = fitImageSql;
                            OracleDataReader readerFitImage = cmdFitImage.ExecuteReader();
                            while (readerFitImage.Read())
                            {
                                searchModel.sto_imageList.Add(readerFitImage.GetString(1));

                            }

                            readerFitImage.Dispose();
                            readerFitImage.Close();
                            Console.WriteLine("finish FitFirImageSql");
                        }
                        using (var cmdFitNotice = con.CreateCommand())
                        {
                            var fitNoticeSql = $"SELECT * FROM  NOTICE WHERE STO_ID={searchModel.sto_id} ORDER BY NTC_TIME DESC ";
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitNoticeSql);
                            cmdFitNotice.CommandText = fitNoticeSql;
                            OracleDataReader readerFitNotice = cmdFitNotice.ExecuteReader();
                            while (readerFitNotice.Read())
                            {
                                var tempNotice = new NoticeModel();
                                tempNotice.ntc_content = readerFitNotice.GetString(2);
                                tempNotice.ntc_time = readerFitNotice.GetDateTime(1).ToString("yyyy-MM-dd");
                                searchModel.sto_notice.Add(tempNotice);
                            }
                            readerFitNotice.Dispose();
                            readerFitNotice.Close();
                            Console.WriteLine("finish FitFirNoticeSql");
                        }
                        using (var cmdFitCom = con.CreateCommand())
                        {
                            var fitComSql = $"SELECT " +
                                $"COM_ID,COM_NAME,COM_EXPIRATIONDATE ,COM_STATUS " +
                                $"FROM COMMODITY WHERE STO_ID ={searchModel.sto_id} AND COM_STATUS !=-1 ORDER BY COM_RATING";
                            cmdFitCom.CommandText = fitComSql;
                            Console.WriteLine("In searchCommodityByName function going to execute: " + fitComSql);
                            OracleDataReader readerFitCom = cmdFitCom.ExecuteReader();
                            while (readerFitCom.Read())
                            {
                                var subCom = new SubCommodityListModel();
                                subCom.com_id = readerFitCom.GetInt32(0);
                                subCom.com_name = readerFitCom.GetString(1);
                                subCom.com_expirationDate = readerFitCom.GetDateTime(2).ToString("yyyy-MM-dd");
                                subCom.com_status = readerFitCom.GetInt32(3);
                                int my_com_id = readerFitCom.GetInt32(0); ;
                                subCom.com_price = sqlGetCommodityCurrPrice(subCom.com_id);

                                using (var cmdFitFirImage = con.CreateCommand())
                                {
                                    var fitFirImageSql = $"SELECT * FROM COMMODITY_IMAGE WHERE COM_ID={my_com_id} ";
                                    Console.WriteLine("In searchCommodityByName function going to execute: " + fitFirImageSql);
                                    cmdFitFirImage.CommandText = fitFirImageSql;
                                    OracleDataReader readerFitFirImage = cmdFitFirImage.ExecuteReader();
                                    if (readerFitFirImage.HasRows)
                                    {
                                        readerFitFirImage.Read();
                                        subCom.com_firstImage = readerFitFirImage.GetString(1).Substring(10);
                                        readerFitFirImage.Dispose();
                                        Console.WriteLine("finish FitFirImageSql");
                                    }
                                    else { Console.WriteLine($"The commodity with id={my_com_id} has no image"); }
                                }
                                using (var cmdFitFavor = con.CreateCommand())
                                {
                                    var sqlQuery = $"SELECT * FROM FAVORITE WHERE COM_ID = {subCom.com_id} AND CUS_ID ={cus_id}";
                                    cmdFitFavor.CommandText = sqlQuery;//sqlList[0]为插入语句，sqlList[1]为删除语句
                                    var my_reader = cmdFitFavor.ExecuteReader();
                                    if (my_reader.HasRows)
                                    {
                                        subCom.favor_state = 1;
                                    }
                                    else
                                    {
                                        subCom.favor_state = 0;
                                    }
                                }
                                searchModel.com_list.Add(subCom);
                            }
                            readerFitCom.Dispose();
                            readerFitCom.Close();
                        }
                    }
                    reader.Dispose();
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("In searchStoreByID function erorr \n");
                    Console.WriteLine(ex.Message);
                }
            }
            Console.WriteLine("finish searchStoreByID function");
            return searchModel;
        }

        public int sqlSetFavorState(List<string> sqlList)
        {
            int sqlFlag = 1;//如果为0则执行插入语句，如果为1则执行执行删除语句
            using (var cmd = con.CreateCommand())
            {
                cmd.CommandText = sqlList[2];//sqlList[0]为插入语句，sqlList[1]为删除语句
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if (count != 0)
                {
                    Console.WriteLine("The tuple exists,we gotta delete the turple");
                    sqlFlag = 1;
                }
                else if (count == 0)
                {
                    Console.WriteLine("The tuple does not exist,we gotta insert the turple");
                    sqlFlag = 0;
                }
                using (var cmdDel = con.CreateCommand())
                {
                    cmdDel.CommandText = sqlList[sqlFlag];
                    Console.WriteLine("In function 'sqlSetFavorState' we gotta execute " + sqlList[sqlFlag]);
                    cmdDel.ExecuteNonQuery();

                }
            }
            Console.WriteLine("Finish function 'sqlSetFavorState'");
            return sqlFlag;
        }


        public double sqlGetCommodityCurrPrice(int com_id)
        {
            DateTime date = DateTime.Now;
            var searchSql =
                $" SELECT " +
                $" COM_ID,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE " +
                $" FROM COMMODITY" +
                $" WHERE COM_ID ={com_id}";
            double com_price = 0;
            using (var cmd = con.CreateCommand())
            {
                cmd.CommandText = searchSql;
                OracleDataReader reader = cmd.ExecuteReader();
                double com_oriPrice = -1;
                string com_expirationDate = " ";
                string com_uploadDate = "";
                while (reader.Read())
                {
                    com_oriPrice = reader.GetDouble(1);
                    com_expirationDate = reader.GetDateTime(2).ToString("yyyy-MM-dd");
                    com_uploadDate = reader.GetDateTime(3).ToString("yyyy-MM-dd");
                }
                reader.Dispose();
                reader.Close();
                using (var cmdFitPrice = con.CreateCommand())
                {
                    var com_prices = new List<PriceCurveModel>();
                    var fitPriceSql = $"SELECT COM_PC_TIME,COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID ={com_id} ORDER BY COM_PC_TIME ASC";
                    var uploadPriceNode = new PriceCurveModel();
                    var exPriceNode = new PriceCurveModel();

                    cmdFitPrice.CommandText = fitPriceSql;

                    OracleDataReader readerFitPrice = cmdFitPrice.ExecuteReader();
                    uploadPriceNode.com_pc_price = com_oriPrice;
                    uploadPriceNode.com_pc_time = com_uploadDate;
                    exPriceNode.com_pc_price = 0;
                    exPriceNode.com_pc_time = DateTime.Parse(com_expirationDate).AddDays(1).ToString("yyyy-MM-dd");
                    while (readerFitPrice.Read())
                    {
                        var singlePriceNode = new PriceCurveModel();
                        singlePriceNode.com_pc_price = readerFitPrice.GetDouble(1);
                        singlePriceNode.com_pc_time = readerFitPrice.GetDateTime(0).ToString("yyyy-MM-dd");
                        com_prices.Add(singlePriceNode);
                    }
                    com_prices.Add(uploadPriceNode);
                    com_prices.Add(exPriceNode);
                    com_prices.Sort((x, y) => y.com_pc_price.CompareTo(x.com_pc_price));

                    if (com_prices[0].com_pc_time == com_prices[1].com_pc_time)
                    {
                        com_prices.RemoveAt(0);
                    }

                    foreach (var priceNode in com_prices)
                    {

                        if (DateTime.Parse(priceNode.com_pc_time) <= date)
                            com_price = priceNode.com_pc_price;
                    }
                    readerFitPrice.Dispose();
                    readerFitPrice.Close();
                    if (com_price == -1)
                        Console.WriteLine("发生错误，可能存在上传日期大于当前日期的情况");

                }
            }


            return com_price;
        }

        public double sqlGetCommodityCurrPriceNew(List<PriceCurveModel> com_prices)
        {
            DateTime date = DateTime.Now;
            double com_price = 0;
            foreach (var priceNode in com_prices)
            {

                if (DateTime.Parse(priceNode.com_pc_time) <= date)
                    com_price = priceNode.com_pc_price;
            }

            return com_price;
        }
        public List<PriceCurveModel> sqlGetCommodityCurrPriceCurve(int com_id)
        {
            DateTime date = DateTime.Now;
            var searchSql =
                $" SELECT " +
                $" COM_ID,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE " +
                $" FROM COMMODITY" +
                $" WHERE COM_ID ={com_id}";
            double com_price = 0;
            var com_prices = new List<PriceCurveModel>();
            using (var cmd = con.CreateCommand())
            {
                cmd.CommandText = searchSql;
                OracleDataReader reader = cmd.ExecuteReader();
                double com_oriPrice = -1;
                string com_expirationDate = " ";
                string com_uploadDate = "";
                while (reader.Read())
                {
                    com_oriPrice = reader.GetDouble(1);
                    com_expirationDate = reader.GetDateTime(2).ToString("yyyy-MM-dd");
                    com_uploadDate = reader.GetDateTime(3).ToString("yyyy-MM-dd");
                }
                using (var cmdFitPrice = con.CreateCommand())
                {

                    var fitPriceSql = $"SELECT COM_PC_TIME,COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID ={com_id} ORDER BY COM_PC_TIME ASC";
                    var uploadPriceNode = new PriceCurveModel();
                    var exPriceNode = new PriceCurveModel();

                    cmdFitPrice.CommandText = fitPriceSql;
                    Console.WriteLine("In searchCommodityByName function going to execute: " + fitPriceSql);
                    OracleDataReader readerFitPrice = cmdFitPrice.ExecuteReader();
                    uploadPriceNode.com_pc_price = com_oriPrice;
                    uploadPriceNode.com_pc_time = com_uploadDate;
                    exPriceNode.com_pc_price = 0;
                    exPriceNode.com_pc_time = DateTime.Parse(com_expirationDate).AddDays(1).ToString("yyyy-MM-dd");
                    while (readerFitPrice.Read())
                    {
                        var singlePriceNode = new PriceCurveModel();
                        singlePriceNode.com_pc_price = readerFitPrice.GetDouble(1);
                        singlePriceNode.com_pc_time = readerFitPrice.GetDateTime(0).ToString("yyyy-MM-dd");
                        com_prices.Add(singlePriceNode);
                    }
                    com_prices.Add(uploadPriceNode);
                    com_prices.Add(exPriceNode);
                    com_prices.Sort((x, y) => y.com_pc_price.CompareTo(x.com_pc_price));

                    if (com_prices[0].com_pc_time == com_prices[1].com_pc_time)
                    {
                        com_prices.RemoveAt(0);
                    }


                    readerFitPrice.Dispose();
                    readerFitPrice.Close();
                    reader.Dispose();
                    reader.Close();
                    if (com_price == -1)
                        Console.WriteLine("发生错误，可能存在上传日期大于当前日期的情况");

                }
            }
            
            return com_prices;
        }

        public void sqlSetIndent(SetIndentModel model)
        {
            foreach (var ind in model.indent_arr)
            {
                Guid newGuid = Guid.NewGuid();
                Console.WriteLine("The new guid :" + newGuid.ToString());
                if (ind.ind_notes.Length == 0)
                {
                    ind.ind_notes = " ";
                }
                foreach (var com_ind in ind.com_arr)
                {
                    var sql = $"Insert into INDENT (IND_ID,IND_QUANTITY,IND_MONEY,IND_CREATIONTIME,IND_VERIFICATIONCODE,IND_NOTES,IND_STATE,IND_RATING,CUS_ID,COM_ID,IND_RTIME,IND_RNOTES,IND_RMONEY) " +
                        $"values (IND_ID_SEQ.NEXTVAL,{com_ind.ind_quantity},{com_ind.ind_money},TO_DATE('{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}', 'YYYY-MM-DD HH24:MI:SS'),'{newGuid.ToString()}','{ind.ind_notes}',0,-1,{model.cus_id},{com_ind.com_id},TO_DATE('0001-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),0,-1)";
                    try
                    {
                        Console.WriteLine("Get into  sqlSetIndent function");
                        int result = DataBase.oracleCon.sqlInsertSingleItem(sql);
                        sqlComDecs(com_ind.com_id, com_ind.ind_quantity);
                        sqlSetBalance(model.cus_id, sqlGetBlance(model.cus_id) - com_ind.ind_money);
                        sqlSetBalance(ind.sto_id, sqlGetBlance(ind.sto_id) + com_ind.ind_money);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex);

                    }

                }

            }

        }

        public RefundModel sqlRefund(GetRefundModel model)
        {
            var refundResult = new RefundModel();
            double ind_moeny = 0;
            int ind_quantity = 0;
            int com_id = 0;
            int cus_id = -1;
            int sto_id = -1;
            using (var cmd = con.CreateCommand())
            {
                var sql = $"SELECT IND_MONEY,IND_QUANTITY,INDENT.COM_ID,CUS_ID,STO_ID FROM INDENT,COMMODITY WHERE IND_ID ={model.ind_ID}";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlRefund function going to execute: " + sql);
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ind_moeny = reader.GetDouble(0);
                    ind_quantity = reader.GetInt32(1);
                    com_id = reader.GetInt32(2);
                    cus_id = reader.GetInt32(3);
                    sto_id = reader.GetInt32(4);
                }
                reader.Dispose();
                reader.Close();
            }
            double ind_rmoney = sqlGetCommodityCurrPrice(com_id) * ind_quantity;

            using (var cmd = con.CreateCommand())
            {
                var sql = $"UPDATE INDENT " +
                    $"SET IND_RTIME = TO_DATE('{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}','YYYY-MM-DD HH24:MI:SS')," +
                    $"IND_RNOTES='{model.ind_rnotes}'," +
                    $"IND_RMONEY={ind_rmoney}," +
                    $"IND_STATE=2" +
                    $"WHERE IND_ID = {model.ind_ID}";
                Console.WriteLine("In sqlRefund function going to execute: " + sql);
                cmd.CommandText = sql;
                cmd.ExecuteNonQuery();
                sqlSetBalance(cus_id, sqlGetBlance(cus_id) + ind_rmoney);
                sqlSetBalance(sto_id, sqlGetBlance(sto_id) - ind_rmoney);
                sqlComAsc(com_id, ind_quantity);
            }
            refundResult.price_return = ind_rmoney;
            refundResult.balance = sqlGetBlance(cus_id);
            return refundResult;
        }
        public double sqlGetBlance(int cus_id)
        {
            double balance = -1;
            using (var cmd = con.CreateCommand())
            {
                var sql = $"SELECT USER_BALANCE FROM USERS WHERE USER_ID ={cus_id}";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlGetBlance function going to execute: " + sql);
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    balance = reader.GetDouble(0);

                }
                reader.Dispose();
                reader.Close();
                Console.WriteLine("finish" + sql);
            }
            return balance;
        }
        public double sqlGetComLeft(int com_id)
        {
            double left = 0;
            using (var cmd = con.CreateCommand())
            {
                var sql = $"SELECT COM_LEFT FROM COMMODITY WHERE COM_ID ={com_id}";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlGetComLeft function going to execute: " + sql);
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                    left = reader.GetDouble(0);
                reader.Dispose();
                reader.Close();
                Console.WriteLine("finish" + sql);
            }
            return left;
        }
        public List<EleModel> sqlGetIndet(GetIndentModel model)
        {
            var indList = new List<IndentModel>();
            var eleList = new List<EleModel>();
            int state = model.ind_state;
            if (model.ind_state == 3)
                state = 0;
            using (var cmd = con.CreateCommand())
            {

                string sql = $@"
                SELECT 
                    IND_ID,
                    IND_QUANTITY,
                    IND_MONEY,
                    IND_CREATIONTIME,
                    IND_VERIFICATIONCODE,
                    IND_NOTES,
                    IND_STATE,
                    IND_RATING,
                    CUS_ID,
                    INDENT.COM_ID,
                    IND_RTIME,
                    IND_RNOTES,
                    IND_RMONEY,
                    COM_NAME,
                    COM_EXPIRATIONDATE，
                    STO_NAME,
                    STORE.STO_ID
                FROM INDENT,COMMODITY,STORE
                WHERE CUS_ID = {model.cus_id} AND INDENT.COM_ID=COMMODITY.COM_ID AND IND_STATE={state} AND COM_NAME LIKE '%{model.search_str}%' AND COMMODITY.STO_ID = STORE.STO_ID";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlGetComLeft function going to execute: " + sql);
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine("In sqlGetComLeft !!!!!!!!!");
                    var ind = new IndentModel();
                    ind.ind_ID = reader.GetInt32(reader.GetOrdinal("IND_ID"));
                    ind.ind_quantity = reader.GetString(reader.GetOrdinal("IND_QUANTITY"));
                    ind.ind_money = reader.GetDouble(reader.GetOrdinal("IND_MONEY"));
                    ind.ind_rating = reader.GetInt32(reader.GetOrdinal("IND_RATING"));
                    ind.com_ID = reader.GetInt32(reader.GetOrdinal("COM_ID"));
                    ind.ind_rtime = reader.GetDateTime(10).ToString("yyyy-MM-dd HH:mm:ss");
                    ind.ind_rnotes = reader.IsDBNull(reader.GetOrdinal("IND_RNOTES")) ? null : reader.GetString(reader.GetOrdinal("IND_RNOTES"));
                    ind.ind_rmoney = reader.GetDouble(reader.GetOrdinal("IND_RMONEY"));
                    //ind.com_firstImg = reader.IsDBNull(reader.GetOrdinal("COM_FIRSTIMG")) ? null : reader.GetString(reader.GetOrdinal("COM_FIRSTIMG"));
                    ind.com_name = reader.GetString(reader.GetOrdinal("COM_NAME"));
                    ind.ind_creationTime = reader.GetDateTime(3).ToString("yyyy-MM-dd HH:mm:ss");
                    ind.ind_verificationCode = reader.GetString(reader.GetOrdinal("IND_VERIFICATIONCODE"));
                    ind.sto_id = reader.GetInt32(reader.GetOrdinal("STO_ID"));
                    ind.sto_name = reader.GetString(reader.GetOrdinal("STO_NAME"));
                    ind.ind_notes = reader.GetString(reader.GetOrdinal("IND_NOTES"));
                    DateTime exDate = reader.GetDateTime(reader.GetOrdinal("COM_EXPIRATIONDATE"));
                    exDate = exDate.AddDays(1);
                    using (var cmdFitImage = con.CreateCommand())
                    {
                        var fitImageSql = $"SELECT * FROM COMMODITY_IMAGE WHERE COM_ID={ind.com_ID} ORDER BY COM_ID DESC ";
                        Console.WriteLine("In searchCommodityByName function going to execute: " + fitImageSql);
                        cmdFitImage.CommandText = fitImageSql;
                        OracleDataReader readerFitImage = cmdFitImage.ExecuteReader();
                        while (readerFitImage.Read())
                        {
                            ind.com_firstImg = readerFitImage.GetString(1).Substring(10);
                            break;
                        }
                        readerFitImage.Dispose();
                        readerFitImage.Close();
                        Console.WriteLine("finish FitImageSql");
                    }
                    if (model.ind_state == 3)
                    {
                        if (exDate < DateTime.Now)
                        {
                            indList.Add(ind);
                        }
                    }
                    else if (model.ind_state == 0)
                    {
                        if (exDate > DateTime.Now)
                        {
                            indList.Add(ind);
                        }

                    }
                    else
                        indList.Add(ind);

                }
                reader.Dispose();
                reader.Close();
            }
            var subList = indList.GroupBy(p => p.ind_verificationCode).ToList();
            foreach (var sub in subList)
            {
                var item = new EleModel();
                foreach (IndentModel i in sub)
                {
                    item.indent_arr.Add(i);
                    item.ind_notes = i.ind_notes;
                    item.ind_creationTime = i.ind_creationTime;
                    item.ind_verificationCode = i.ind_verificationCode;
                    item.sto_id = i.sto_id;
                    item.sto_name = i.sto_name;
                }
                eleList.Add(item);
            }


            switch (model.sort_order)
            {
                case 0:
                    eleList.Sort((x, y) => y.ind_creationTime.CompareTo(x.ind_creationTime));//创建时间排序
                    break;
                case 1:
                    var myList = sqlGetStorageID(model.cus_id);
                    eleList.Sort((x, y) => myList.IndexOf(y.sto_id).CompareTo(myList.IndexOf(x.sto_id)));//创建时间排序
                    //地理位置远近，尚且没有实现
                    break;
            }
            return eleList;
        }
        public void sqlSetBalance(int cus_id, double newBalance)
        {

            using (var cmd = con.CreateCommand())
            {
                var sql = $"UPDATE USERS SET USER_BALANCE = {newBalance} WHERE USER_ID = {cus_id}";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlSetBlance function going to execute: " + sql);
                Console.WriteLine($"The order balance={sqlGetBlance(cus_id)}");
                cmd.ExecuteNonQuery();
                Console.WriteLine($"The new balance={sqlGetBlance(cus_id)}");
                Console.WriteLine("finish" + sql);
            }
        }

        public void sqlComDecs(int com_id, int num)
        {
            using (var cmd = con.CreateCommand())
            {
                var sql = $"UPDATE COMMODITY SET COM_LEFT = COM_LEFT-{num} WHERE COM_ID = {com_id}";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlComDec  function going to execute: " + sql);
                Console.WriteLine($"The order com_left={sqlGetComLeft(com_id)}");
                cmd.ExecuteNonQuery();
                Console.WriteLine($"The new com_left={sqlGetComLeft(com_id)}");
                Console.WriteLine("finish" + sql);
            }

        }
        public void sqlIndentEvaluation(EvaluationModel model)
        {
            int com_id = -1;
            int cus_id = -1;
            using (var cmd = con.CreateCommand())
            {
                string sql_1 = $"UPDATE INDENT_VIEW SET IND_RATING = {model.ind_rating} WHERE IND_ID = {model.ind_id}";
                cmd.CommandText = sql_1;
                Console.WriteLine("In sqlIndentEvaluation  function going to execute: " + sql_1);
                cmd.ExecuteNonQuery();
                Console.WriteLine("finish" + sql_1);
                var sql_2 = $"SELECT COM_ID,CUS_ID FROM INDENT WHERE IND_ID ={model.ind_id}";
                cmd.CommandText = sql_2;
                Console.WriteLine("In sqlIndentEvaluation  function going to execute: " + sql_2);
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    com_id = reader.GetInt32(0);
                    cus_id = reader.GetInt32(1);

                }
                reader.Dispose();
                reader.Close();
            }
            DateTime currentTime = DateTime.Now;
            string str = SanitizeCommentWithSensitiveWordsFromFile(model.cmt_content);
            var sql = $"Insert into COMMODITY_COMMENT(CMT_ID, CMT_FATHER, CMT_CONTENT, CMT_TIME, COM_ID, USER_ID) " +
                $"values(COMMENT_ID_SEQ.NEXTVAL, 0, '{str}',TO_DATE('{currentTime.ToString("yyyy-MM-dd HH:mm:ss")}','yyyy-MM-dd HH24:mi:ss'),{com_id}, {cus_id})";
            try
            {
                Console.WriteLine("Get into  PostComment function :" + sql);
                var model_1 = new CommentModel();
                model_1.cmt_father = 0;
                model_1.cmt_content = model.cmt_content;
                model_1.user_id = cus_id;
                model_1.com_id = com_id;

                DataBase.oracleCon.sqlGetSingleCmt(model_1);

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);

            }
        }

        public void sqlComAsc(int com_id, int num)
        {
            using (var cmd = con.CreateCommand())
            {
                var sql = $"UPDATE COMMODITY SET COM_LEFT = COM_LEFT + {num} WHERE COM_ID = {com_id}";
                cmd.CommandText = sql;
                Console.WriteLine("In sqlComDec  function going to execute: " + sql);
                Console.WriteLine($"The order com_left={sqlGetComLeft(com_id)}");
                cmd.ExecuteNonQuery();
                Console.WriteLine($"The new com_left={sqlGetComLeft(com_id)}");
                Console.WriteLine("finish" + sql);
            }

        }

        public SendCommentModel sqlGetSingleCmt(CommentModel model)
        {

            int cmt_id = -1;
            int nextVal = -1;
            using (OracleCommand command = con.CreateCommand())
            {
                // 获取序列的下一个值
                command.CommandText = "SELECT COMMENT_ID_SEQ.NEXTVAL FROM DUAL";
                nextVal = int.Parse(command.ExecuteScalar().ToString());
            }
            using (OracleCommand command = con.CreateCommand())
            {
                var sql = $"Insert into COMMODITY_COMMENT(CMT_ID, CMT_FATHER, CMT_CONTENT, CMT_TIME, COM_ID, USER_ID) " +
             $"values({nextVal}, :cmtFather, :cmtContent, TO_DATE(:dateTime, 'yyyy-MM-dd HH24:mi:ss'), :comId, :userId) " +
             $"RETURNING CMT_ID INTO :LastInsertedId";

                command.CommandText = sql;

                // 添加参数
                string cmt = SanitizeCommentWithSensitiveWordsFromFile(model.cmt_content);
                command.Parameters.Add("cmtFather", OracleDbType.Int32, model.cmt_father, ParameterDirection.Input);
                command.Parameters.Add("cmtContent", OracleDbType.Varchar2, cmt, ParameterDirection.Input);
                command.Parameters.Add("dateTime", OracleDbType.Varchar2, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), ParameterDirection.Input);
                command.Parameters.Add("comId", OracleDbType.Int32, model.com_id, ParameterDirection.Input);
                command.Parameters.Add("userId", OracleDbType.Int32, model.user_id, ParameterDirection.Input);

                OracleParameter idParameter = new OracleParameter("LastInsertedId", OracleDbType.Int32, ParameterDirection.Output);
                command.Parameters.Add(idParameter);

                command.ExecuteNonQuery();

                // 获取并返回插入的ID
                cmt_id = int.Parse(idParameter.Value.ToString());

            }
            var comment = new SendCommentModel();
            using (var cmdFitCmt = con.CreateCommand())
            {
                var fitCmtSql = $"SELECT * FROM COMMODITY_COMMENT WHERE CMT_ID = {cmt_id}";
                cmdFitCmt.CommandText = fitCmtSql;
                Console.WriteLine("In sqlGetSingleCmt function going to execute: " + fitCmtSql);
                OracleDataReader readerFitCmt = cmdFitCmt.ExecuteReader();

                while (readerFitCmt.Read())
                {
                    comment.cmt_time = readerFitCmt.GetDateTime(3).ToString("yyyy-MM-dd HH:mm:ss");
                    comment.cmt_id = readerFitCmt.GetInt32(0);
                    comment.cmt_father = readerFitCmt.GetInt32(1);
                    comment.cmt_content = readerFitCmt.GetString(2);
                    comment.com_id = readerFitCmt.GetInt32(4);
                    comment.user_id = readerFitCmt.GetInt32(5);
                    using (var cmdFitUserType = con.CreateCommand())
                    {
                        var sqlFitUserType = $"SELECT USER_TYPE FROM USERS WHERE USER_ID = {comment.user_id}";
                        cmdFitUserType.CommandText = sqlFitUserType;
                        var readerFitUserType = cmdFitUserType.ExecuteReader();
                        var sqlFitUser = "";
                        Console.WriteLine("In searchCommodityByID function going to execute: " + sqlFitUserType);
                        while (readerFitUserType.Read())
                        {
                            if (readerFitUserType.GetInt32(0) == 0)
                            {
                                sqlFitUser = $"SELECT CUS_NICKNAME FROM CUSTOMER WHERE CUS_ID = {comment.user_id}";
                                comment.user_type = 0;
                                using (var cmdFitBuyTimes = con.CreateCommand())
                                {
                                    var sqlFitBuyTimes =
                                        $"SELECT COUNT (*) " +
                                        $"FROM INDENT " +
                                        $"WHERE COM_ID = {comment.com_id} AND CUS_ID = {comment.user_id} " +
                                        $"GROUP BY CUS_ID ";
                                    cmdFitBuyTimes.CommandText = sqlFitBuyTimes;
                                    Console.WriteLine("In searchCommodityByID function going to execute: " + sqlFitBuyTimes);
                                    var readerFitBuyTimes = cmdFitBuyTimes.ExecuteReader();

                                    while (readerFitBuyTimes.Read())
                                    {
                                        comment.buying_times = readerFitBuyTimes.GetInt32(0);
                                        break;
                                    }
                                }
                            }
                            else if (readerFitUserType.GetInt32(0) == 1)
                            {
                                sqlFitUser = $"SELECT STO_NAME FROM STORE WHERE STO_ID = {comment.user_id}";
                                comment.user_type = 1;
                                comment.buying_times = 0;
                            }
                            else
                            {
                                Console.WriteLine("Something Wrong In cmdFitUserType");
                            }
                            using (var cmdFitUser = con.CreateCommand())
                            {
                                cmdFitUser.CommandText = sqlFitUser;
                                Console.WriteLine("In searchCommodityByID function going to execute: " + sqlFitUser);
                                var readerUser = cmdFitUser.ExecuteReader();
                                while (readerUser.Read())
                                {
                                    comment.cmt_name = readerUser.GetString(0);
                                }

                                readerUser.Dispose();
                                readerUser.Close();
                            }
                            break;
                        }
                    }
                    Console.WriteLine(comment.cmt_content);
                }
                readerFitCmt.Dispose();
                readerFitCmt.Close();
            }
            return comment;
        }


        public static string SanitizeCommentWithSensitiveWordsFromFile(string comment)
        {
            string filePath = @"敏感词.txt"; // 敏感词文件的路径
            var sensitiveWords = File.ReadAllLines(filePath).ToList();
            foreach (var word in sensitiveWords)
            {
                if (comment.Contains(word))
                {
                    comment = comment.Replace(word, new string('*', word.Length));
                }
            }

            return comment;
        }

        //用于往后端写入数据
        public void sqlStorageID(int cus_id, List<int> list)
        {
            string folderPath = ".\\locationSort";
            string filePath = Path.Combine(folderPath, $"{cus_id.ToString()}.txt");
            var strList = new List<string>();
            foreach (var item in list)
            {
                strList.Add(item.ToString());
            }
            Directory.CreateDirectory(folderPath);
            File.WriteAllLines(filePath, strList);
        }
        // 用于读取数据

        public List<int> sqlGetStorageID(int cus_id)
        {
            var list = new List<int>();
            string folderPath = ".\\locationSort";
            string filePath = Path.Combine(folderPath, $"{cus_id.ToString()}.txt");
            Console.WriteLine("The filePath:" + filePath);
            if (Directory.Exists(folderPath))
            {

                var readList = File.ReadAllLines(filePath);
                foreach (var item in readList)
                {


                    int number;
                    bool success = Int32.TryParse(item, out number);

                    if (success)
                    {
                        Console.WriteLine($"Converted successfully to {number}");
                        list.Add(number);
                    }
                    else
                    {
                        Console.WriteLine("Conversion failed");
                    }
                }
            }
            else
            { Console.WriteLine("没有文件夹？？"); }
            return list;
        }
        public List<int> sqlGetComID(int cus_id)
        {
            var list = new List<int>();
            string filePath = $".\\wwwroot\\ItemCF\\{cus_id}.txt";
            var list_string = File.ReadAllLines(filePath).ToList();
            foreach (var item in list_string)
            {
                if (int.TryParse(item, out int result))
                    list.Add(result);
                else { Console.WriteLine($"{cus_id}.txt 中存在无法转换的数据，数据为{item}"); }
            }
            return list;
        }

        public List<StoAddressListModel> sqlGetStorageAddress()
        {
            var str = "SELECT STO_ID,USER_ADDRESS FROM STORE,USERS WHERE USER_ID=STO_ID ";
            var list = new List<StoAddressListModel>();
            using (var cmd = con.CreateCommand())
            {
                cmd.CommandText = str;
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    var searchModel = new StoAddressListModel();
                    searchModel.sto_id = reader.GetInt32(0);
                    searchModel.sto_address = reader.GetString(1);
                    list.Add(searchModel);

                }
                reader.Dispose();
                reader.Close();
            }
            return list;
        }


        public void sqlCreateAppeal(GetAppealModel model)
        {

            Console.WriteLine("Get into function sqlCreateAppeal");
            int appealID = -1;
            var time = DateTime.Now;
            using (var cmd = con.CreateCommand())
            {
                cmd.CommandText = "SELECT APPEAL_ID_SEQ.NEXTVAL FROM DUAL";
                appealID = int.Parse(cmd.ExecuteScalar().ToString());

            }
            using (var cmd = con.CreateCommand())
            {
                var sql = $"Insert into APPEAL(APP_ID,APP_MATTERS,APP_CONTENT,USER_ID,COM_ID,CMT_ID,APP_USERID,APP_TIME) " +
                $"values({appealID},:appMatters,:appContent,:userID,:comID,:cmtID,:appUserID,:appTime) ";
                cmd.CommandText = sql;
                cmd.Parameters.Add("appMatters", OracleDbType.Int32, model.app_matters, ParameterDirection.Input);
                cmd.Parameters.Add("appContent", OracleDbType.Varchar2, model.app_content, ParameterDirection.Input);
                cmd.Parameters.Add("userID", OracleDbType.Int32, model.user_ID == -1 ? DBNull.Value : model.user_ID, ParameterDirection.Input);
                cmd.Parameters.Add("comID", OracleDbType.Int32, model.com_ID == -1 ? DBNull.Value : model.com_ID, ParameterDirection.Input);
                cmd.Parameters.Add("cmtID", OracleDbType.Int32, model.cmt_ID == -1 ? DBNull.Value : model.cmt_ID, ParameterDirection.Input);
                cmd.Parameters.Add("appUserID", OracleDbType.Int32, model.app_userID == -1 ? DBNull.Value : model.app_userID, ParameterDirection.Input);
                cmd.Parameters.Add("appTime", OracleDbType.Date, time, ParameterDirection.Input);
                Console.WriteLine("In Function sqlCreateAppeal gotta execute: " + sql);
                cmd.ExecuteNonQuery();
            }

            foreach (var item in model.sct_images)
            {
                using (var cmd = con.CreateCommand())
                {
                    cmd.CommandText = "SELECT APPEAL_IMG_SEQ.NEXTVAL FROM DUAL";
                    var seqNextVal = int.Parse(cmd.ExecuteScalar().ToString());
                    var filePath = Path.Combine(".\\wwwroot\\appeal_image", $"appeal_img_{seqNextVal}.jpg");
                    sqlSaveBase64Image(filePath, item);
                    cmd.CommandText = $"INSERT INTO SCREENSHOT(APP_ID,SCT_IMAGE) VALUES ({appealID},'appeal_image\\appeal_img_{seqNextVal}.jpg')";
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void sqlSaveBase64Image(string filePath, string base64)
        {
            /*
             * 先将64进行预处理，base64转byte类型，使用内存流读取byte内容，然后用bitmap来将这个保存到本地
             */
            try
            {
                var tempBase64 = base64.Replace("data:image/png;base64,", "").Replace("data:image/jgp;base64,", "").Replace("data:image/jpg;base64,", "").Replace("data:image/jpeg;base64,", "");//将base64头部信息替换
                byte[] by = Convert.FromBase64String(tempBase64);//
                using (var menStream = new MemoryStream(by))
                {
                    var mImage = new Bitmap(menStream);
                    mImage.Save(filePath);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }
}
