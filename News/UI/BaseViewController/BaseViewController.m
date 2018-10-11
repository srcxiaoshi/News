//
//  BaseViewController.m
//  News
//
//  Created by 史瑞昌 on 2018/9/16.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "BaseViewController.h"
#import <SRCUIKit/SRCUIKit.h>
#import "HomepageSuggestModel.h"
#import "SuggestWordModel.h"



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
    
    //在添加完NavBar以后，会更新text 默认参数
    [self updateSearchAndSuggestWithString:nil];
}



#pragma network相关
//更新搜索框内容
-(void)updateSearchAndSuggestWithString:(SuggestWordModel *)model
{
    if(!model||[NSString safe_isEmpty:model.sug_category]||[NSString safe_isEmpty:model.from])
    {
        //默认参数
        if(!model)
        {
            model=[SuggestWordModel new];
            model.from=@"home";
            model.sug_category=@"关注";
        }
    }
    if(self.navBar)
    {
        __weak typeof(self) weakself=self;
        NSMutableDictionary *dic=[NSMutableDictionary new];
        [dic safe_setObject:[model toDictionary] forKey:@"suggest_params"];
        [SRCNetworkWithAF requestGetMethodWithPath:@"http://ib.snssdk.com/search/suggest/homepage_suggest" parameters:[dic copy] withProgress:nil success:^(BOOL isSuccess, NSString *response)
        {
            __strong typeof(weakself) strongself=weakself;
            HomepageSuggestModel *model=[[HomepageSuggestModel alloc] safe_initWithString:response];
            if(!model)
            {
                ERROR();
                return;
            }
            [strongself.navBar updateText:model.data.homepage_search_suggest];
        } failure:^(NSError *error)
        {
            
        }];
        
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
