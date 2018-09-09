//
//  RootViewController.m
//  News
//
//  Created by 史瑞昌 on 2018/9/9.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "RootViewController.h"
#import <SRCFoundation/SRCFoundation.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //测试网络
    [SRCNetworkWithAF requestGetMethodWithPath:@"is.snssdk.com/network/get_network/?version_code=6.8.8&tma_jssdk_version=1.1.0.10&app_name=news_article&vid=C68FFB74-9684-4105-9E8C-4954D6022577&device_id=47982195078&channel=App%20Store&resolution=1125*2436&aid=13&ab_version=425531,482423,492612,486950,452158,480751,494120,467892,494152,488820,239097,478798,170988,493249,405356,480871,480610,374119,437000,478529,434624,489317,443148,494128,276205,471720,491311,459645,459993,277770,469537,416055,470630,456488,444653,490552,378450,471406,489423,494124,493908,271178,424178,326524,326532,488147,494966,494280,493825,345191,491700,493461,489827,489968,424606,455646,449327,424176,493596,214069,31245,489331,442255,493747,466936,481984,489511,280447,281291,492476,478591,325611,495162,492470,481568,295308,487448,495353,386888,491935,397990,467515,466888,494011,444464,495208,493925,304488,261580,457480,488925,487522,491262,492520&ab_feature=201616,z2&ab_group=z2,201616&update_version_code=68824&openudid=7c9b9a6b7abcbe4e79054ee4521e172ca5828555&idfv=C68FFB74-9684-4105-9E8C-4954D6022577&ac=WIFI&os_version=11.4.1&ssmix=a&device_platform=iphone&iid=43721270080&ab_client=a1,f2,f7,e1&device_type=iPhone%20X&idfa=B4E58BEB-9B3D-4993-A66F-54D0E949ECF1&as=a2c5cdc95d3d3b4d444433&ts=1536482781" parameters:nil withProgress:^(float progress) {
        NSLog(@"%f\n",progress);
    } success:^(BOOL isSuccess, NSString *response) {
        NSLog(@"%u,%@",isSuccess,response);
    } failure:^(NSError *error) {
        NSLog(@"%@\n",error);
    }];
    
    //NSLog(@"sssss");
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
