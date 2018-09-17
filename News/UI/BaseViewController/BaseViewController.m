//
//  BaseViewController.m
//  News
//
//  Created by 史瑞昌 on 2018/9/16.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "BaseViewController.h"
#import <SRCUIKit/SRCUIKit.h>
#import <SRCFoundation/SRCFoundation.h>

@interface BaseViewController ()

@property(nonatomic,strong)SRCNavgationBarWithSearchAndCamera *navBar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavBarSytle];
}

-(void)setNavBarSytle
{
    //__weak typeof(self) weakSelf=self;
    self.navBar=[[SRCNavgationBarWithSearchAndCamera alloc] initWithTextFieldBlock:^(UITextField *textField) {
        //开始编辑事件
        //__strong typeof(weakSelf) strongSelf=weakSelf;
        
        
    } imagePressBlock:^{
        NSLog(@"image");
    }];
    [self.navigationController.view addSubview:self.navBar];
    
    //在添加完NavBar以后，会更新text
    [self updateSearchAndSuggest];
}

#pragma network相关

//更新搜索框内容
-(void)updateSearchAndSuggest
{
    if(self.navBar)
    {
        /**请求http://ib.snssdk.com/search/suggest/homepage_suggest/?version_code=6.8.8&tma_jssdk_version=1.0.2.0&app_name=news_article&vid=99224CE7-E7D5-4B10-B3A1-402740301CA5&device_id=47982195078&channel=App%20Store&resolution=1125*2436&aid=13&ab_feature=201616,z1&ab_group=201616&update_version_code=68824&openudid=7c9b9a6b7abcbe4e79054ee4521e172ca5828555&idfv=99224CE7-E7D5-4B10-B3A1-402740301CA5&ac=WIFI&os_version=11.4.1&ssmix=a&device_platform=iphone&device_type=iPhone%20X&ab_client=a1,f2,f7,e1&idfa=B4E58BEB-9B3D-4993-A66F-54D0E949ECF1&flag=1&suggest_params=%7B%22suggest_word%22:%7B%22sug_category%22:%22%E5%85%B3%E6%B3%A8%22,%22from%22:%22home%22%7D%7D&as=a2a54bd9ad5ebb5cd84968&ts=1536736493**/
        __weak typeof(self) weakself=self;
        [SRCNetworkWithAF requestGetMethodWithPath:@"http://ib.snssdk.com/search/suggest/homepage_suggest/?version_code=6.8.8&tma_jssdk_version=1.0.2.0&app_name=news_article&vid=99224CE7-E7D5-4B10-B3A1-402740301CA5&device_id=47982195078&channel=App%20Store&resolution=1125*2436&aid=13&ab_feature=201616,z1&ab_group=201616&update_version_code=68824&openudid=7c9b9a6b7abcbe4e79054ee4521e172ca5828555&idfv=99224CE7-E7D5-4B10-B3A1-402740301CA5&ac=WIFI&os_version=11.4.1&ssmix=a&device_platform=iphone&device_type=iPhone%20X&ab_client=a1,f2,f7,e1&idfa=B4E58BEB-9B3D-4993-A66F-54D0E949ECF1&flag=1&suggest_params=%7B%22suggest_word%22:%7B%22sug_category%22:%22%E5%85%B3%E6%B3%A8%22,%22from%22:%22home%22%7D%7D&as=a2a54bd9ad5ebb5cd84968&ts=1536736493" parameters:nil withProgress:nil success:^(BOOL isSuccess, NSString *response)
        {
        
            __strong typeof(weakself) strongself=weakself;
            [strongself.navBar updateText:@"你猜"];
        } failure:^(NSError *error)
        {
            
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
