//
//  Category.h
//  News
//
//  Created by 史瑞昌 on 2018/9/20.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "CategoryVersion.h"

@interface Category : BaseModel

@property(nonatomic,strong)CategoryVersion *data;

@end
