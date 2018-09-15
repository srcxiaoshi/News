//
//  AppNetworkModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "AppDataModel.h"

@protocol AppNetworkModel

@end

@interface AppNetworkModel : BaseModel

@property(nonatomic,strong)AppDataModel *data;


//
@end
