//
//  RootViewController.m
//  News
//
//  Created by 史瑞昌 on 2018/9/9.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "RootViewController.h"
#import <SRCFoundation/SRCFoundation.h>
#import "AppNetworkModel.h"

#import "StreamViewController.h"
#import "WaterMelonViewController.h"
#import "MineViewController.h"
#import "HuoShanViewController.h"
#import "AddFriendViewController.h"
//这里好像还有一个红包页？？

#define TAB_VIEW_CONTROLLER_CHANGE      @"tab_view_controller_change"
#define APP_SETTING_CONFIG     @"tt_app_setting_config"



@interface RootViewController ()

@property(nonatomic,strong)NSMutableArray *tabList;

//配置数据 该数据决定tab样式
@property(nonatomic,strong)NSMutableArray *configTabArr;

@end

@implementation RootViewController

#pragma overload init
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        //添加一些通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarChange:) name:TAB_VIEW_CONTROLLER_CHANGE object:nil];
    }
    return self;
}

#pragma mark - Getters and Setters
-(NSMutableArray *)tabList
{
    if(!_tabList)
    {
        _tabList=[[NSMutableArray alloc] initWithCapacity:4];
    }
    return _tabList;
}

-(NSMutableArray *)configTabArr
{
    if(!_configTabArr)
    {
        _configTabArr=[[NSMutableArray alloc]initWithCapacity:4];
    }
    return _configTabArr;
}


//UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];

    //测试网络 这个方法没有对应的返回，这里需要再改
    [ServerTimestamp getServerTimestamp:^(BOOL isSuccess, BaseModel *baseModel) {
        if(isSuccess)
        {
            NSLog(@"%@",baseModel.message);
        }
    }];
    
    
    if(![self loadStartTabConfig])
    {
        //这里是第一次加载或者是UI过期情况下
        [self loadDefaultController];
    }
    else
    {
        //这里使用配置的
        NSLog(@"2%@",self.configTabArr);
    }
    
}

//default UIController
-(void)loadDefaultController
{
    StreamViewController *streamViewController = [[StreamViewController alloc] init];
    
    UIImage *mainframeImage   = [UIImage imageNamed:@"tabbar_mainframe"];
    UIImage *mainframeHLImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    
    mainframeViewController.title = @"微信";
    mainframeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"微信" image:mainframeImage selectedImage:mainframeHLImage];
    mainframeViewController.tabBarItem.badgeValue = @"9";
    mainframeViewController.view.backgroundColor = [UIColor colorWithRed:48 / 255.0 green:67 / 255.0 blue:78 / 255.0 alpha:1];
    mainframeViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"]
                                                                                                 style:UIBarButtonItemStylePlain
                                                                                                target:self
                                                                                                action:@selector(didClickAddButton:)];

}



//配置tab_config 使用默认的返回no, no的情况下，使用默认的；
//返回yes的话，使用configTabArr中的数据
-(BOOL)loadStartTabConfig
{
    //利用NSUserDefault 类配置tab
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *stringData=[userDefault objectForKey:APP_SETTING_CONFIG];
    
    if(!stringData)
    {
        __weak typeof(self) weakSelf=self;
        //去获取，并重新写入到userDefault中 TAB_CONFIG
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [SRCNetworkWithAF requestGetMethodWithPath:@"https://is.snssdk.com/service/settings/v2/" parameters:nil withProgress:nil success:^(BOOL isSuccess, NSString *response) {
                if(![NSString safe_isEmpty:response])
                {
                    __autoreleasing JSONModelError *err=nil;
                    AppNetworkModel *model=[[AppNetworkModel alloc] safe_initWithString:response error:&err];
                    if(model)
                    {
                        //这里要讲需要的setting写到userDefault中
                        [userDefault setObject:response forKey:APP_SETTING_CONFIG];
                    }
                    if(err)
                    {
                        //这里是解析错误，需要json解析查找问题，或者重新解析？?
                        NSLog(@"err=%@",err);
                    }
                }

                
            } failure:^(NSError *error) {
                //重新请求
                __strong typeof(weakSelf) strongSelf=weakSelf;
                [strongSelf loadStartTabConfig];
                NSLog(@"setting_error\n");
            }];
        }) ;
        return NO;
    }
    else
    {
        //将data转成对象
        __autoreleasing JSONModelError *err=nil;
        AppNetworkModel *appModel=[[AppNetworkModel alloc] safe_initWithString:stringData error:&err];
        if(err)
        {
            //这里是解析错误，需要json解析查找问题，或者重新解析？?
            NSLog(@"err=%@",err);
            return NO;
        }
        if(appModel&&appModel.data&&appModel.data.app.tt_start_tab_config&&appModel.data.app.tt_tab_list_config)
        {
            TabListConfig *tabList=appModel.data.app.tt_tab_list_config;
            StartTabConfig *startTabConf=appModel.data.app.tt_start_tab_config;
            //这里将数据放到self configTabArr 中
            long time=(long)[[NSDate date] timeIntervalSince1970];
            if(!startTabConf.expired_time)
            {
                return NO;
            }
            
            if(time>=startTabConf.expired_time.longValue)
            {
                if(startTabConf.tab_config&&[startTabConf.tab_config count]>0)
                {
                    //清空 self configTabArr
                    self.configTabArr=[NSMutableArray new];
                    //可以用，没有过期
                    for(TabItemModel *model in startTabConf.tab_config)
                    {
                        [self.configTabArr safe_addObject:model];
                    }
                    if(tabList.middle_tab)
                    {
                        [[self configTabArr] safe_addObject:tabList.middle_tab];
                    }
                    if(tabList.normal_tabs&&[tabList.normal_tabs count]>0)
                    {
                        for(NSString *string in tabList.normal_tabs)
                        {
                            //这里只有名字，应该是用来选icon的
                            TabItemModel *model=[[TabItemModel alloc] init];
                            if(![NSString safe_isEmpty:string])
                            {
                                model.tab_name=string;
                                [self.configTabArr safe_addObject:model];
                            }
                            else
                            {
                                ERROR();
                                return NO;
                            }
                        }
                    }
                    else
                    {
                        return NO;
                    }
                    return YES;
                }
                else
                {
                    return NO;
                }
            }
            else
            {
                //清空userDefault
                [userDefault removeObjectForKey:APP_SETTING_CONFIG];
                return NO;
            }
            
        }
        return NO;
    }
    
}



//重新处理tabBar
-(void)resolveTabBarStyle:(NSArray *)tabBarItems
{
    if(tabBarItems&&[tabBarItems count]>0)
    {
        int i = 0;
        NSMutableArray *tabItemArr=self.configTabArr;
        
    }
}

//处理notification
-(void)tabBarChange:(NSNotification *)obj
{
    
}


//
-(void)dealloc
{
    //移除通知、代理
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.tabBarController.delegate=nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
