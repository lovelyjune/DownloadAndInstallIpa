//
//  OneDownloadItem.m
//  DemoDownload
//
//  Created by yingxin ye on 2017/5/2.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import "OneDownloadItem.h"
#import <UIKit/UIKit.h>
#import "DownloadManager.h"
#import "MJExtension.h"
#import "DownloadDelegateHandler.h"


@interface OneDownloadItem()
{
    NSURLSession * _session;
    NSURLSessionDataTask * _task;
    NSMutableURLRequest * _mutableRequest;
}

@end

@implementation OneDownloadItem

MJCodingImplementation

-(OneDownloadItem * )initWithUrl:(NSString*)url andPlistUrl:(NSString*)plistUrl andGameName:(NSString*)gameName andGameId:(NSString*)gameId andType:(NSString*)type
{
    self.gameName = gameName;
    self.gameId = gameId;
    self.type = type;
    self.urlString = url;
    self.plistUrl = plistUrl;
    self.taskProgress = 0.0f;
    self.isFinish = NO;
    self.currentBytesWritten = 0;
    self.totalBytesWritten = 0;
    self.taskDate = [NSDate date];
    self.taskSpeed = @"0kb/s";
    self.taskSize = @"0M";
    self.saveName = [NSString stringWithFormat:@"%@.%@",self.gameId,self.type];
    
    return self;
}


-(void)initTask
{
    //获取已下载的文件大小
    NSInteger alreadyDownloadLength = [[DownloadManager manager] getAlreadyDownloadLength:self.saveName];
    
    DownloadDelegateHandler * delegateHandler = [[DownloadDelegateHandler alloc]initWithItem:self];
//    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:_delegateHandler delegateQueue:[NSOperationQueue mainQueue]];
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:delegateHandler delegateQueue:nil];
    
    
    //这里是已经下载的小于总文件大小执行继续下载操作
    //创建mutableRequest对象
    _mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    //设置request的请求头 Range:bytes=xxx-xxx
    [_mutableRequest setValue:[NSString stringWithFormat:@"bytes=%ld-",(long)alreadyDownloadLength] forHTTPHeaderField:@"Range"];
    _task = [_session dataTaskWithRequest:_mutableRequest];
}


-(void)startModelDownload
{
    NSError *error = nil;
    //获取已下载的文件大小
    NSInteger alreadyDownloadLength = [[DownloadManager manager] getAlreadyDownloadLength:self.saveName];
    
    //说明已经下载完毕
    if (alreadyDownloadLength && alreadyDownloadLength==self.totalBytesWritten)
    {
        //            !self.completeBlock?:self.completeBlock(XHRFilePath,nil);
        //回调
        NSLog(@"finish");
        [[DownloadManager manager] updateModel:self andStatus:DownloadStatusComplete];
        return;
    }
    //如果已经存在的文件比目标大说明下载文件错误执行删除文件重新下载
    else if (self.totalBytesWritten < alreadyDownloadLength)
    {
        [[NSFileManager defaultManager]removeItemAtPath:[[DownloadManager manager] getFilePath:self.saveName] error:&error];
        if (!error)
        {
            alreadyDownloadLength = 0;
        }
        else
        {
            NSLog(@"创建任务失败请重新开始");
            //删除文件
            return;
        }
    }
    
    [[DownloadManager manager] updateModel:self andStatus:DownloadStatusDownloading];
    if(!_task) [self initTask];
    [_task resume];
}

-(void)pauseModelDownload
{
    [_task cancel];
    [_session invalidateAndCancel];
    _session = nil;
    _task = nil;
    [[DownloadManager manager] updateModel:self andStatus:DownloadStatusPause];
}


- (void)dealloc
{
    NSLog(@"---OneDownloadItem---dealloc");
}


@end
