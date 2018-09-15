//
//  AppModel.h
//  News
//  NOTE:APP的接口，使用这个来接，后面要根据接口继续扩展
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "HomePageUIConfig.h"
#import "StartTabConfig.h"
#import "TabListConfig.h"

@protocol AppModel

@end

@interface AppModel : BaseModel

//home
@property(nonatomic,strong)HomePageUIConfig *home_page_ui_config;

//tab 用这两个来处理tab
@property(nonatomic,strong)StartTabConfig *tt_start_tab_config;
@property(nonatomic,strong)TabListConfig *tt_tab_list_config;



@end
