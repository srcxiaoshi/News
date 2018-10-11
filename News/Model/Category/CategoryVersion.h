//
//  CategoryVersion.h
//  News
//
//  Created by 史瑞昌 on 2018/9/20.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "CategoryItem.h"

@protocol CategoryItem;

@interface CategoryVersion : BaseModel

@property(nonatomic,strong)NSString *version;
@property(nonatomic,strong)NSArray<CategoryItem> *data;

@end
