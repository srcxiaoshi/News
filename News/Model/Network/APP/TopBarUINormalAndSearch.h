//
//  TopBarUINormal.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@interface TopBarUINormalAndSearch : BaseModel

@property(nonatomic,assign)BOOL status_bar_light;

@property(nonatomic,copy)NSArray <NSString *><Optional>* text_color;//normal 用4个，search 用后两个

//这两个是search 用
@property(nonatomic,strong)NSNumber <Optional> *text_left_offset;
@property(nonatomic,strong)NSNumber <Optional> *touch_area_left_offset;


@end
