//
//  Tips.h
//  News
//
//  Created by 史瑞昌 on 2018/9/30.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@interface Tips : BaseModel

@property(nonatomic,strong)NSString *type;
@property(nonatomic,assign)NSInteger display_duration;
@property(nonatomic,strong)NSString *display_info;
@property(nonatomic,strong)NSString *display_template;
@property(nonatomic,strong)NSString *open_url;
@property(nonatomic,strong)NSString *web_url;
@property(nonatomic,strong)NSString *download_url;
@property(nonatomic,strong)NSString *app_name;
@property(nonatomic,strong)NSString *package_name;

@end
