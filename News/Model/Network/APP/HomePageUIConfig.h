//
//  HomePageUIConfig.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "TabConfig.h"
#import "TopBarConfig.h"


@interface HomePageUIConfig : BaseModel

@property(nonatomic,assign)BOOL is_single_valid;
@property(nonatomic,strong)TabConfig *tab_config;
@property(nonatomic,strong)TopBarConfig *top_bar_config;

@end
