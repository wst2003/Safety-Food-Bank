using DBproject;
using DBproject.Models;
using Microsoft.AspNetCore.SignalR;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;


public class ChatHub : Hub
{
    //进行连接的字典
    private static readonly Dictionary<string, string> userConnections = new Dictionary<string, string>();

    //SignalR连接初始化
    public override async Task OnConnectedAsync()
    {
        var user_Id = GetUserIdFromContext(Context);
        if (!string.IsNullOrEmpty(user_Id))
        {
            userConnections[user_Id] = Context.ConnectionId;
        }
        Console.WriteLine("连接到signalR的user_ID为：" + user_Id + "对应连接ID为：" + Context.ConnectionId);
        //await关键字保证了基类的异步执行
        await base.OnConnectedAsync();
    }

    //取消signalR连接的操作，主要是需要删除字典中的信息
    public override async Task OnDisconnectedAsync(Exception exception)
    {
        var user_Id = GetUserIdFromContext(Context);
        Console.WriteLine("取消连接的user_ID为：" + user_Id);
        if (!string.IsNullOrEmpty(user_Id))
        {
            if (userConnections.ContainsKey(user_Id))
            {
                userConnections.Remove(user_Id);
            }
        }
        Context.Abort(); // 取消连接
        await base.OnDisconnectedAsync(exception);// 调用基类的 OnDisconnectedAsync 方法
    }

    //获取传递到后端的user_ID, 用于建立连接
    private string? GetUserIdFromContext(HubCallerContext context)
    {
        var userId = context.GetHttpContext().Request.Query["user_Id"].ToString();
        // Check if the userId is not empty or null
        if (!string.IsNullOrEmpty(userId))
        {
            return userId;
        }
        return null;
    }

    //访问数据库，获取所有对应cusID和storeID的聊天记录
    public async Task GetChatHistory(string cusID, string storeID)
    {
        // 调用数据库访问函数，获取按时间顺序排序的聊天历史记录
        var chatHistoryForUser = DataBase.oracleCon.GetChatHistory(cusID, storeID);
        Console.WriteLine("已发出"+chatHistoryForUser);
        for(int i=0;i<chatHistoryForUser.Count;i++)
            Console.WriteLine("已发出" + chatHistoryForUser[i].ChatContent);
        await Clients.Caller.SendAsync("ReceiveChatHistory",chatHistoryForUser);
    }

    //发送数据给对应用户
    public async Task SendMessage(string chatTime,string cusID, string storeID, string chatContent, bool chatSender,bool chatType)
    {
        var chat = new Chat
        {
            ChatTime = chatTime,
            CusID = cusID,
            StoreID = storeID,
            ChatContent = chatContent,
            ChatSender = chatSender,
            ChatType = chatType
        };
        DataBase.oracleCon.InsertChatIntoDataBase(chat);
        Console.WriteLine("聊天信息如下");
        Console.WriteLine("ChatTime:"+chat.ChatTime);
        Console.WriteLine("cusID:" + chat.CusID);
        Console.WriteLine("StoreID:" + chat.StoreID);
        Console.WriteLine("ChatContent:" + chat.ChatContent);
        Console.WriteLine("ChatSender:" + chat.ChatSender);
        Console.WriteLine("ChatType:" + chat.ChatType);

        // 使用Clients.Client发送消息给特定用户
        if (chatSender)//如果是发送方是商家，检查是否有对应user_ID正在连接
        {
            if (userConnections.TryGetValue(cusID, out string cusConnectionId))
            {
                Console.WriteLine(cusConnectionId);
                await Clients.Client(cusConnectionId).SendAsync("ReceiveMessage",chat);
            }
        }
        else//如果发送方是顾客，检查是否有对应商家存在并发送
        {
            if (userConnections.TryGetValue(storeID, out string storeConnectionId))
            {
                Console.WriteLine(storeConnectionId);
                await Clients.Client(storeConnectionId).SendAsync("ReceiveMessage", chat);
            }
        }
    }

    //访问数据库，获取对应userID的聊天列表，返回数据为chat类列表，列表为每个聊天的最新聊天信息，降序排列
    public async Task GetChatList(string userID)
    {
        var chatList = DataBase.oracleCon.GetChatList(userID);
        Console.WriteLine("已发出" + chatList);
        for (int i = 0; i < chatList.Count; i++)
            Console.WriteLine("已发出" + chatList[i].ChatContent);
        await Clients.Caller.SendAsync("ReceiveChatList", chatList);
    }
}