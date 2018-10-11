//
//  CategoryItem.h
//  News
//
//  Created by 史瑞昌 on 2018/9/20.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@interface CategoryItem : BaseModel

/*
 "category":"关注",
 "web_url":"",
 "flags":0,
 "name":"关注",
 "tip_new":0,
 "default_add":1,
 "concern_id":"",
 "type":4,
 "icon_url":"",
 "stick":1
 */

@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *web_url;
@property(nonatomic,assign)NSNumber *flags;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSNumber *tip_new;
@property(nonatomic,assign)NSNumber *default_add;
@property(nonatomic,strong)NSString *concern_id;
@property(nonatomic,assign)NSNumber *type;
@property(nonatomic,strong)NSString *icon_url;
@property(nonatomic,assign)NSNumber *stick;

@end
