//
//  TabListConfig.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "TabItemModel.h"


@interface TabListConfig : BaseModel
@property(nonatomic,strong)TabItemModel *middle_tab;
@property(nonatomic,copy) NSArray <NSString *> *normal_tabs;
@end
