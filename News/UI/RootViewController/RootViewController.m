//
//  RootViewController.m
//  News
//
//  Created by 史瑞昌 on 2018/9/9.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "RootViewController.h"
#import <SRCFoundation/SRCFoundation.h>
#import <SRCUIKit/SRCUIKit.h>

#import "AppNetworkModel.h"

#import "StreamViewController.h"
#import "WaterMelonViewController.h"
#import "MineViewController.h"
#import "HuoShanViewController.h"
#import "AddFriendViewController.h"
//这里好像还有一个红包页？？


#define TABBERBAR_GRAY_COLOR    [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0f]
#define MIAN_GRAY_COLOR     [UIColor colorWithRed:1.0 green:0.1 blue:0.1 alpha:1]
#define TAB_BAR_TINT_COLOR      [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f]




#define TAB_VIEW_CONTROLLER_CHANGE      @"tab_view_controller_change"
#define APP_SETTING_CONFIG     @"tt_app_setting_config"
#define IS_LOGIN      @"is_login"


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
        //初始化TabBar
        [[UITabBar appearance] setTranslucent:NO];
        [UITabBar appearance].barTintColor = TAB_BAR_TINT_COLOR;
        
        //normal
        UITabBarItem * item = [UITabBarItem appearance];
        item.titlePositionAdjustment = UIOffsetMake(0, -5);
        NSMutableDictionary * normalAtts = [NSMutableDictionary new];
        [normalAtts safe_setObject:[UIFont systemFontOfSize:10] forKey:NSFontAttributeName];
        [normalAtts safe_setObject:TABBERBAR_GRAY_COLOR forKey:NSForegroundColorAttributeName];
        [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
        
        // selected
        NSMutableDictionary *selectAtts = [NSMutableDictionary new];
        [selectAtts safe_setObject:[UIFont systemFontOfSize:10] forKey:NSFontAttributeName];
        [selectAtts safe_setObject:MIAN_GRAY_COLOR forKey:NSForegroundColorAttributeName];
        [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
        
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
        if(self.configTabArr&&[self.configTabArr count]>=3)
        {
            [self loadCustomController];
        }
        else
        {
            [self loadStartTabConfig];
        }

    }
    
}

//default UIController light
-(void)loadDefaultController
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    BOOL isLogin=[userDefault objectForKey:IS_LOGIN];
    [self addViewController:[StreamViewController class] title:@"首页" imageName:@"home_tabbar_32x32_" selectImageName:@"home_tabbar_press_32x32_"];
    [self addViewController:[WaterMelonViewController class] title:@"西瓜视频" imageName:@"video_tabbar_32x32_" selectImageName:@"video_tabbar_press_32x32_"];
    [self addViewController:[HuoShanViewController class] title:@"小视频" imageName:@"huoshan_tabbar_32x32_" selectImageName:@"huoshan_tabbar_press_32x32_"];
    NSString *mineTitle=nil;
    NSString *mineImageName=nil;
    NSString *selectImageName=nil;
    if(isLogin)
    {
        mineTitle=@"我的";
        mineImageName=@"mine_tabbar_32x32_";
        selectImageName=@"mine_tabbar_press_32x32_";
    }
    else
    {
        mineTitle=@"未登录";
        mineImageName=@"no_login_tabbar_32x32_";
        selectImageName=@"no_login_tabbar_press_32x32_";
    }
    [self addViewController:[MineViewController class] title:mineTitle imageName:mineImageName selectImageName:selectImageName];
}

//Custom UIController light
-(void)loadCustomController
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    BOOL isLogin=[userDefault objectForKey:IS_LOGIN];
    NSString *midName=nil;
    for(TabItemModel *model in self.configTabArr)
    {
        NSString *name=[model tab_name];
        if([NSString safe_isEmpty:name])
        {
            ERROR();
            [self loadDefaultController];
            return;
        }
        else
        {
            if([name isEqualToString:@"tab_stream"])
            {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    [self addViewController:[StreamViewController class] title:@"首页" imageName:@"home_tabbar_32x32_" selectImageName:@"home_tabbar_press_32x32_"];
                });
                
            }
            else if([name isEqualToString:@"tab_video"])
            {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    [self addViewController:[WaterMelonViewController class] title:@"西瓜视频" imageName:@"video_tabbar_32x32_" selectImageName:@"video_tabbar_press_32x32_"];
                });
                
            }
            else if ([name isEqualToString:@"tab_huoshan"])
            {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    [self addViewController:[HuoShanViewController class] title:@"小视频" imageName:@"huoshan_tabbar_32x32_" selectImageName:@"huoshan_tabbar_press_32x32_"];
                });
                
            }
            else
            {
                midName=@"tab_add_friend";
            }
        }
    }

    NSString *mineTitle=nil;
    NSString *mineImageName=nil;
    NSString *selectImageName=nil;
    if(isLogin)
    {
        mineTitle=@"我的";
        mineImageName=@"mine_tabbar_32x32_";
        selectImageName=@"mine_tabbar_press_32x32_";
    }
    else
    {
        mineTitle=@"未登录";
        mineImageName=@"no_login_tabbar_32x32_";
        selectImageName=@"no_login_tabbar_press_32x32_";
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self addViewController:[MineViewController class] title:mineTitle imageName:mineImageName selectImageName:selectImageName];
    });
    
    
    //处理middle
    if(![NSString safe_isEmpty:midName])
    {
        //这里好像是 rn 暂时先不动吧，后面再处理吧
    }
}

//使用Class 来减少代码数量
-(void)addViewController:(Class)class title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    if(class&&![NSString safe_isEmpty:title]&&![NSString safe_isEmpty:imageName]&&![NSString safe_isEmpty:selectImageName])
    {
        UIViewController *vc=[[class alloc] init];
        NavViewController *navVC=[[NavViewController alloc] initWithRootViewController:vc];
        navVC.title=title;
        UIImage *image=[UIImage imageNamed:imageName];
        image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage=[UIImage imageNamed:selectImageName];
        selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectImage];
        [self addChildViewController:navVC];
    }
    else
    {
        ERROR();
    }
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
                    for(TabItemModel *model in [startTabConf tab_config])
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
