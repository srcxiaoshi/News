//
//  TabItemModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@protocol TabItemModel

@end

@interface TabItemModel : BaseModel

@property(nonatomic,copy)NSString *tab_name;
@property(nonatomic,strong)NSNumber *tab_priority;
@property(nonatomic,copy)NSString *url;

@end
