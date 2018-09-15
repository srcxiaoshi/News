//
//  AppDataModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/12.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "AppModel.h"

@protocol AppDataModel

@end

@interface AppDataModel : BaseModel

@property(nonatomic,strong) AppModel *app;

//"default":{
//    "apn_notify":1,
//    "article_expire_seconds":600,
//    "clear_app_notify":0,
//    "comment_mode":0,
//    "flow_mode":0,
//    "font_size":0,
//    "fullscreen_mode":0,
//    "image_mode":0,
//    "list_mode":0,
//    "night_mode":0,
//    "refresh_mode":0,
//    "repost_digg":0,
//    "repost_favor":0,
//    "save_position":0,
//    "swipe_mode":0,
//    "switch_domain":0
//}

@end
