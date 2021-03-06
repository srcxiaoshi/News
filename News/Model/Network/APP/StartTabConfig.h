//
//  StartTabConfig.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "TabItemModel.h"

@protocol TabItemModel;

@interface StartTabConfig : BaseModel

@property(nonatomic,strong)NSNumber *expired_time;

@property(nonatomic,strong)NSArray <TabItemModel> *tab_config;//TabItemModel


@end
