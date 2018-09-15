//
//  TopBarConfig.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "TopBarUINormalAndSearch.h"

@protocol TopBarConfig

@end

@interface TopBarConfig : BaseModel

@property(nonatomic,copy)NSString *checksum;

@property(nonatomic,strong)NSNumber *end_time;
@property(nonatomic,strong)NSNumber *start_time;

@property(nonatomic,copy)NSArray <NSString *> *status_bar_color;//["日间色","夜间色"]
@property(nonatomic,assign)BOOL status_use_color;


@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)NSNumber *version;

@property(nonatomic,strong)TopBarUINormalAndSearch *top_bar_ui_normal;
@property(nonatomic,strong)TopBarUINormalAndSearch *top_bar_ui_search;


@end
