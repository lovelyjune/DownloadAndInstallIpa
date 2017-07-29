//
//  DownloadDelegateHandler.m
//  DemoDownload
//
//  Created by yingxin ye on 2017/5/4.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import "DownloadDelegateHandler.h"
#import "DownloadManager.h"

@interface DownloadDelegateHandler()
@property(nonatomic,strong) NSOutputStream * stream; //下载流
@property(nonatomic,strong) OneDownloadItem * myItem;

@end

@implementation DownloadDelegateHandler

- (instancetype)initWithItem:(OneDownloadItem*)oneItem
{
    self = [super init];
    if (self)
    {
        self.myItem = oneItem;
    }
    return self;
}

//服务器响应以后调用的代理方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //接受到服务器响应
    //获取文件的全部长度
//    NSLog(@"开始下载----Content-Length===%li,AlreadyDownloadLength===%li",[response.allHeaderFields[@"Content-Length"] integerValue],(long)[[DownloadManager manager] getAlreadyDownloadLength:self.myItem.saveName]);
    
    self.myItem.totalBytesWritten = [response.allHeaderFields[@"Content-Length"] integerValue] + [[DownloadManager manager] getAlreadyDownloadLength:self.myItem.saveName];
    self.myItem.currentBytesWritten = [[DownloadManager manager] getAlreadyDownloadLength:self.myItem.saveName];

    //保存当前的下载信息到沙盒 并刷新界面
    [[DownloadManager manager]updateModel:self.myItem andStatus:DownloadStatusDownloading];

    //打开outputStream
    [self.stream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.stream open];
    
    //调用block设置允许进一步访问
    completionHandler(NSURLSessionResponseAllow);
}
//接收到数据后调用的代理方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //把服务器传回的数据用stream写入沙盒中
    [self.stream write:data.bytes maxLength:data.length];
    self.myItem.currentBytesWritten = [[DownloadManager manager] getAlreadyDownloadLength:self.myItem.saveName];//再获取当前文件已下载的长度

    self.myItem.taskProgress = (self.myItem.currentBytesWritten / self.myItem.totalBytesWritten);

    //保存当前的下载信息到沙盒并刷新界面 回调界面现在的下载进度
    [[DownloadManager manager]updateModel:self.myItem andStatus:DownloadStatusDownloading];

    //    NSLog(@"name:%@--progress:%lli/%lli,线程:%@",self.myItem.gameName,self.myItem.currentBytesWritten,self.myItem.totalBytesWritten,[NSThread currentThread]);
}
//任务完成后调用的代理方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(error)
    {
        //暂停
        return;
    }
    else
    {
        NSLog(@"下载完成-----没有错误");
        //保存当前的下载信息的沙盒 并回调界面完成
        [[DownloadManager manager]updateModel:self.myItem andStatus:DownloadStatusComplete];
        //回调告诉manager完成
        [[DownloadManager manager] callbackDownloadComplete:self.myItem];
    }

    //关闭流
    [self.stream close];
    self.stream = nil;
    //清空task
    [session invalidateAndCancel];
    task = nil;
    session = nil;
}


- (NSOutputStream *)stream
{
    if (!_stream) {
        
        _stream = [[NSOutputStream alloc]initToFileAtPath:[[DownloadManager manager] getFilePath:self.myItem.saveName] append:YES];
    }
    return _stream;
}


- (void)dealloc
{
    NSLog(@"---DownloadDelegateHandler---dealloc");
}

@end
