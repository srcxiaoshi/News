//
//  TabItemModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@interface TabItemModel : BaseModel

@property(nonatomic,copy)NSString <Optional> *tab_name;
@property(nonatomic,strong)NSNumber <Optional> *tab_priority;
@property(nonatomic,copy)NSString <Optional> *url;

@end
