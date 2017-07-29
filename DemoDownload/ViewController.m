//
//  ViewController.m
//  DemoDownload
//
//  Created by yingxin ye on 2017/4/25.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"
#import "OneDownloadItem.h"
#import "DownloadCell.h"

@interface ViewController ()
@property(nonatomic,strong) UITableView * allGameTableView;
@property(atomic,strong) NSArray * allItemModelArr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allItemModelArr = [DownloadManager manager].allItemArray;
    
    for(int i =0 ; i < 10 ; i++)
    {
        NSString * titleStr = [NSString stringWithFormat:@"任务%i",i];
        UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(i*60+10 < 350) downBtn.frame = CGRectMake(i*60+10, 30, 55, 30);
        else downBtn.frame = CGRectMake((i-6)*60+10, 70, 55, 30);
        downBtn.tag = i;
        [downBtn setTitle:titleStr forState:UIControlStateNormal];
        downBtn.backgroundColor = [UIColor redColor];
        [downBtn addTarget:self action:@selector(downloadHanlder:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:downBtn];
    }

    [self.view addSubview:self.allGameTableView];
    
    //下载过程中，数据源刷新，表格刷新
    typeof(self) __weak weakSelf = self;
    [[DownloadManager manager] progressBlock:^(NSArray *allModelArr) {
        weakSelf.allItemModelArr = allModelArr;
        [weakSelf.allGameTableView reloadData];
    }];
    
    //下载完成自动安装，可以不选择自动安装
    [[DownloadManager manager] completeBlock:^(OneDownloadItem *oneItem) {
        [[DownloadManager manager] installIpaWithDownloadItem:oneItem];
    }];
}

//下载这些地址只是测试
//把下面的下载ipa地址和plist地址都改成你们自己的地址
-(void)downloadHanlder:(UIButton*)btn
{
    if (btn.tag == 0)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/zhangyue.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/zhangyue.plist" andGameName:@"zhangyue" andGameId:@"zhangyue" andType:@"ipa"];
    }
    else if(btn.tag == 1)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/zhangyue.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/zhangyue.plist" andGameName:@"zhangyue" andGameId:@"zhangyue" andType:@"ipa"];
    }
    else if(btn.tag == 2)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/M2M.ipa" andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/m2m.plist" andGameName:@"m2m" andGameId:@"m2m" andType:@"ipa"];
    }
    else if(btn.tag == 3)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/9cam.ipa" andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/9cam.plist" andGameName:@"9cam" andGameId:@"9cam" andType:@"ipa"];
    }
    else if(btn.tag == 4)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/tof.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/tof.plist" andGameName:@"tof" andGameId:@"tof" andType:@"ipa"];
    }
    else if(btn.tag == 5)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/dingdang.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/dingdang.plist" andGameName:@"dingdang" andGameId:@"dingdang" andType:@"ipa"];
    }
    else if(btn.tag == 6)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/pinglide.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/pinglide.plist" andGameName:@"pinglide" andGameId:@"pinglide" andType:@"ipa"];
    }
    else if(btn.tag == 7)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/sumiao.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/sumiao.plist" andGameName:@"sumiao" andGameId:@"sumiao" andType:@"ipa"];
    }
    else if(btn.tag == 8)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/tmail.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/tmail.plist" andGameName:@"tmail" andGameId:@"tmail" andType:@"ipa"];
    }
    else if(btn.tag == 9)
    {
        [[DownloadManager manager] addDownloadTaskWithUrl:@"http://ooyizs7oj.bkt.clouddn.com/weixin.ipa"  andPlistUrl:@"https://raw.githubusercontent.com/lovelyjune/testPlist/master/weixin.plist" andGameName:@"weixin" andGameId:@"weixin" andType:@"ipa"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView*)allGameTableView
{
    if(!_allGameTableView)
    {
        _allGameTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
        
        _allGameTableView.dataSource = self;
        _allGameTableView.delegate = self;
    }
    return _allGameTableView;
}


#pragma mark 一共有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allItemModelArr.count;
}

#pragma mark 每个组的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


#pragma mark 每个表格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark 每个表格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier= NSStringFromClass([DownloadCell class]);
    
    DownloadCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DownloadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OneDownloadItem * data = [self.allItemModelArr objectAtIndex:indexPath.row];
    [cell updateCell:data];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        OneDownloadItem * delItem = [self.allItemModelArr objectAtIndex:indexPath.row];
        [[DownloadManager manager] removeItem:delItem];
    }
    
}

#pragma mark 点击表格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
