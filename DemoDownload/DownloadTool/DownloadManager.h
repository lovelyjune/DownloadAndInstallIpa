//
//  DownloadManager.h
//  DemoDownload
//
//  Created by yingxin ye on 2017/5/2.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneDownloadItem.h"


@interface DownloadManager : NSObject

/**
 * tableview 的数据源
 */
@property(nonatomic,strong) NSMutableArray * allItemArray;

/**
 *  任务下载器（单例模式）
 *
 *  @return self
 */
+ (DownloadManager *)manager;

/**
 *  添加一个下载任务到任务列表中
 *
 *  @param urlString  ipa下载地址url
 *  @param plistUrl   plist文件url
 *  @param gameName   文件名
 *  @param gameId   文件id
 *  @param type   文件类型 (ipa)
 */
- (void)addDownloadTaskWithUrl:(NSString *)urlString andPlistUrl:(NSString*)plistUrl andGameName:(NSString*)gameName andGameId:(NSString*)gameId andType:(NSString*)type;

/**
 * 由于要刷新tableview，所以下载过程通过这个block来刷新tablview
 */
-(void)progressBlock:(void(^)(NSArray*allModelArr))progressBlock;

/**
 * 单个文件下载完毕后的回调
 */
-(void)completeBlock:(void(^)(OneDownloadItem*oneItem))completeBlock;

/**
 * 下载一个任务
 */
-(void)startDownload:(OneDownloadItem*)oneItem;

/**
 * 暂停一个任务
 */
-(void)pauseDownload:(OneDownloadItem*)oneItem;

/**
 * 安装ipa
 */
-(void)installIpaWithDownloadItem:(OneDownloadItem*)oneItem;

/**
 * 删除item
 */
-(void)removeItem:(OneDownloadItem*)oneItem;


//------------------------------------以下不需要主动调用---------------------------

/**
 *
 * 一个任务完成下载后的回调
 */
-(void)callbackDownloadComplete:(OneDownloadItem*)oneItem;


/**文件存放路径*/
-(NSString*)getFilePath:(NSString*)saveName;


/**已经下载的文件长度*/
-(NSInteger)getAlreadyDownloadLength:(NSString*)saveName;


/** 保存归档数组并刷新UI */
-(void)saveArchiverAndUpdateUI;

/** 更新下载项的状态，并保存和更新界面 **/
-(void)updateModel:(OneDownloadItem*)oneModel andStatus:(DownloadStatus)downloadStatus;


@end
