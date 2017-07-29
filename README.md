ios应用内下载并安装另一个应用
=============

ios黑科技之实现91助手的效果(app内下载并安装另一个app)
-------------
今天分享一个非常牛逼，非常装逼的黑科技--ios应用内下载并安装另一个应用，中间不需要经过appstore。    
其实这个技术，就是我们实现91助手或者同步推的效果，他们也可以在他们的应用里面下载并安装其他的app。    

以下是教程链接
http://www.jianshu.com/p/c47699dee334

****
**源码介绍：
实现和91助手、同步推的效果  
已经封装好下载管理器，可以用下载管理器去管理 每个ipa包的下载  
下载可以暂停，可以继续  
支持断点续传（就算退出app，下次进入app依然保持上次的断点续传）  
支持后台下载（按home键出去桌面之后依然保持下载）  
支持设置最大并行下载数（默认是3个同时下载） 
可以控制ipa下载后是否要安装  
自己可以选择ipa安装包是否删除**  
****



**使用说明：**
**1.快速添加一个下载ipa任务**
````
[[DownloadManager manager] addDownloadTaskWithUrl:@"http://xxxx.com/xxxx.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/xxxxx/xxxxx.plist" andGameName:@"xxxxx" andGameId:@"xxxxx" andType:@"ipa"];
````
**2.下载过程中,进度的监听,我是直接返回任务数组的数据源，可以通过数组里面的OneDownloadItem 获取每个任务**
````
[[DownloadManager manager] progressBlock:^(NSArray *allModelArr){}];
````
**3.下载完成后的监听,返回是单个任务的完成回调**
````
    [[DownloadManager manager] completeBlock:^(OneDownloadItem *oneItem) {}];
````

ps:我里面的虚拟服务器端口默认设置成10001，你可以按需自定义，直接用我的源码可以下载ipa，不过你们安装不到，因为你们appid没有得到app的签名（使用权），所以记得跟着我下面第一步的教程走一下，就可以安装了

****


*欢迎
star*


