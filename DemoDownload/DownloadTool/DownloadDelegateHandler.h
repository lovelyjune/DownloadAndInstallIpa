//
//  DownloadDelegateHandler.h
//  DemoDownload
//
//  Created by yingxin ye on 2017/5/4.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneDownloadItem.h"

@interface DownloadDelegateHandler : NSObject<NSURLSessionDataDelegate>

- (instancetype)initWithItem:(OneDownloadItem*)oneItem;


@end
