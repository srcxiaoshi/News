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


#define TAB_VIEW_CONTROLLER_CHANGE      @"tab_view_controller_change"
#define TAB_CONFIG     @"tt_start_tab_config"



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

-(UITabBarController *)tabBarController
{
    if(!_tabBarController)
    {
        _tabBarController=[[UITabBarController alloc] init];
    }
    return _tabBarController;
}


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
        
    }
    else
    {
        //这里使用配置的
        
    }
    
    
    
    
}

//配置tab_config 使用默认的返回no, no的情况下，使用默认的；
//返回yes的话，使用configTabArr中的数据
-(BOOL)loadStartTabConfig
{
    //利用NSUserDefault 类配置tab
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=[userDefault objectForKey:TAB_CONFIG];
    if(!dic)
    {
        //去获取，并重新写入到userDefault中 TAB_CONFIG
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [SRCNetworkWithAF requestGetMethodWithPath:@"http://ib.snssdk.com/service/settings/v2/?version_code=6.8.8&tma_jssdk_version=1.0.2.0&app_name=news_article&vid=99224CE7-E7D5-4B10-B3A1-402740301CA5&device_id=47982195078&channel=App%20Store&resolution=1125*2436&aid=13&ab_feature=201616,z1&ab_group=201616&update_version_code=68824&openudid=7c9b9a6b7abcbe4e79054ee4521e172ca5828555&idfv=99224CE7-E7D5-4B10-B3A1-402740301CA5&ac=WIFI&os_version=11.4.1&ssmix=a&device_platform=iphone&iid=43721270080&ab_client=a1,f2,f7,e1&device_type=iPhone%20X&idfa=B4E58BEB-9B3D-4993-A66F-54D0E949ECF1&device_id=47982195078&iid=43721270080&app=1&aid=13&update_version_code=68824&app_name=news_article&default=1&as=a2658b79d2afcbdcf81040&ts=1536736498" parameters:nil withProgress:nil success:^(BOOL isSuccess, NSString *response) {
                __autoreleasing JSONModelError *err=nil;
                AppNetworkModel *model=[[AppNetworkModel alloc] initWithString:response error:&err];
                if(model)
                {
                    NSLog(@"qq=%@",model.data);
                }
                if(err)
                {
                    NSLog(@"err=%@",err);
                }
            } failure:^(NSError *error) {
                NSLog(@"error");
            }];
        }) ;
        return NO;
    }
    else
    {
        return YES;
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
