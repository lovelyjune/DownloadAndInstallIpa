//
//  DownloadCell.m
//  DemoDownload
//
//  Created by yingxin ye on 2017/5/3.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import "DownloadCell.h"
#import "DownloadManager.h"

@interface DownloadCell()
{
    OneDownloadItem * _myDownloadItem;
    UILabel * _gameNameLabel;
    UILabel * _progressLabel;
    UIButton * _startDownloadBtn;
    UIButton * _pauseBtn;
    UIButton * _installBtn;
    UIProgressView * _proView;
}
@end


@implementation DownloadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initData];
        [self initView];
    }
    return self;
}


-(void)initData
{
    
}

-(void)initView
{
    _gameNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    _gameNameLabel.font = [UIFont systemFontOfSize:12];
    _gameNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_gameNameLabel];

    _proView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _proView.frame=CGRectMake(100, 20, 200, 50);
    //设置进度条颜色
    _proView.trackTintColor=[UIColor grayColor];
    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
    _proView.progress=0;
    //设置进度条上进度的颜色
    _proView.progressTintColor=[UIColor redColor];
    //设置进度值并动画显示
    [self.contentView addSubview:_proView];
    
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 20, 50, 20)];
    _progressLabel.font = [UIFont systemFontOfSize:12];
    _progressLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_progressLabel];
    
    _startDownloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startDownloadBtn.frame = CGRectMake(320, 10, 50, 30);
    [_startDownloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    _startDownloadBtn.backgroundColor = [UIColor grayColor];
    [_startDownloadBtn addTarget:self action:@selector(startDownload) forControlEvents:UIControlEventTouchUpInside];
    
    _pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pauseBtn.frame = CGRectMake(320, 10, 50, 30);
    [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    _pauseBtn.backgroundColor = [UIColor grayColor];
    [_pauseBtn addTarget:self action:@selector(btnPauseDownload) forControlEvents:UIControlEventTouchUpInside];
    
    _installBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _installBtn.frame = CGRectMake(320, 10, 50, 30);
    [_installBtn setTitle:@"安装" forState:UIControlStateNormal];
    _installBtn.backgroundColor = [UIColor grayColor];
    [_installBtn addTarget:self action:@selector(installHanler) forControlEvents:UIControlEventTouchUpInside];
}



-(void)updateCell:(OneDownloadItem*)oneDownloadItem
{
    _myDownloadItem = oneDownloadItem;
    [_gameNameLabel setText:oneDownloadItem.gameName];
    if(oneDownloadItem.totalBytesWritten > 0)
    {
        [_progressLabel setText:[NSString stringWithFormat:@"%.2f%%",((float)oneDownloadItem.currentBytesWritten/(float)oneDownloadItem.totalBytesWritten)*100]];
        _proView.progress = (float)oneDownloadItem.currentBytesWritten/(float)oneDownloadItem.totalBytesWritten;
//        [_proView setProgress:(float)oneDownloadItem.currentBytesWritten/(float)oneDownloadItem.totalBytesWritten animated:YES];
    }
    [_startDownloadBtn removeFromSuperview];
    [_pauseBtn removeFromSuperview];
    
    if(oneDownloadItem.downloadStatus == DownloadStatusWaiting) //等待中
    {
        //显示暂停按钮
        [self.contentView addSubview:_pauseBtn];
    }
    else if(oneDownloadItem.downloadStatus == DownloadStatusPause)  //暂停中
    {
        //显示下载按钮
        [self.contentView addSubview:_startDownloadBtn];
    }
    else if(oneDownloadItem.downloadStatus == DownloadStatusDownloading)    //下载中
    {
        //显示暂停按钮
        [self.contentView addSubview:_pauseBtn];
    }
    else if (oneDownloadItem.downloadStatus == DownloadStatusComplete)  //下载完成
    {
        //显示下载按钮
        [self.contentView addSubview:_installBtn];
    }
}

-(void)startDownload
{
    [[DownloadManager manager] startDownload:_myDownloadItem];
}

-(void)btnPauseDownload
{
    [[DownloadManager manager] pauseDownload:_myDownloadItem];
}

-(void)installHanler
{
    [[DownloadManager manager] installIpaWithDownloadItem:_myDownloadItem];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
