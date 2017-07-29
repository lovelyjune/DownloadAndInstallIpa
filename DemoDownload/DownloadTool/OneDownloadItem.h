//
//  OneDownloadItem.h
//  DemoDownload
//
//  Created by yingxin ye on 2017/5/2.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger
{
    DownloadStatusDownloading,
    DownloadStatusWaiting,
    DownloadStatusPause,
    DownloadStatusComplete,
    DownloadStatusError
} DownloadStatus;


@interface OneDownloadItem : NSObject

/**
 *  保存在沙盒的名称,由gameId和type拼接 ，如：2624.ipa
 */
@property (nonatomic, strong) NSString * saveName;
/**
 *  游戏名称
 */
@property (nonatomic, strong) NSString * gameName;

/**
 *  类型
 */
@property (nonatomic, strong) NSString * type;
/**
 *  游戏id
 */
@property (nonatomic, strong) NSString * gameId;

/**
 *  下载任务url
 */
@property (nonatomic, strong) NSString *urlString;

/**
 *  plist url
 */
@property (nonatomic, strong) NSString *plistUrl;

/**
 *  下载任务进度
 */
@property (nonatomic, assign) int64_t taskProgress;

/**
 *  任务下载速度
 */
@property (nonatomic, strong) NSString *taskSpeed;

/**
 *  任务大小
 */
@property (nonatomic, strong) NSString *taskSize;

/**
 *  任务是否已完成
 */
@property (nonatomic, assign) BOOL isFinish;

/**
 *  任务已下载长度
 */
@property (nonatomic, assign) int64_t currentBytesWritten;

/**
 *  任务总长度
 */
@property (nonatomic, assign) int64_t totalBytesWritten;

/**
 *  任务时间
 */
@property (nonatomic, strong) NSDate *taskDate;


/**
 *  下载状态
 */
@property (nonatomic, assign) DownloadStatus downloadStatus;


-(OneDownloadItem * )initWithUrl:(NSString*)url andPlistUrl:(NSString*)plistUrl andGameName:(NSString*)gameName andGameId:(NSString*)gameId andType:(NSString*)type;


-(void)pauseModelDownload;

-(void)startModelDownload;

@end
