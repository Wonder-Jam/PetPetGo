# PetPetGO!
这是我们的大作业客户端了！

![](https://files.lsmcloud.top/PetPetGO.png)

# 在模拟器中测试
因为是元服务，所以安装之后直接在桌面还找不到嘞，但是可以在模拟其中Ctrl+鼠标往中间划   
（这相当于在模拟两根手指往中间划），就可以找到元服务了

# 项目简介
- EntryAbility.ts:程序入口
- pages:程序页面
- EntryformAbility.ts:卡片管理类
- widget/pages:小卡片页面
- resources:各种静态资源

### 吐槽
在华为注册元服务的时候因为名称里面有个感叹号，就说有敏感词，真的很唐，中味十足了属于是（（（

### 宠物状态管理
一直没学会用MVVM，干脆用yjgg说的storageLink就行了
卡片启动的时候已经通过PersistentStorage持久化了三个变量:fullness,cleanliness,mood  
使用的时候通过@StorageLink绑定即可，这样的绑定时双向绑定，数据传播时可以快速同步的，但是数据持久化是有时间延迟，而且！而且！
华为的storage有很严重的bug，任何数据类型存进storage以后都会被强制转换成string(((  
[PersistentStorage 持久化类型错误](https://developer.huawei.com/consumer/cn/forum/topic/0201134433573633001?fid=0101587866109860105)
