//
//  News.h
//  News
//
//  Created by 史瑞昌 on 2018/9/30.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>
#import "Tips.h"

@protocol Content;
@interface News : BaseModel

@property(nonatomic,copy)NSArray<Content> *data;

@property(nonatomic,assign)NSInteger total_number;
@property(nonatomic,assign)BOOL has_more;
@property(nonatomic,assign)NSInteger login_status;
@property(nonatomic,assign)NSInteger show_et_status;
@property(nonatomic,strong)NSString* post_content_hint;
@property(nonatomic,assign)BOOL has_more_to_refresh;
@property(nonatomic,assign)NSInteger action_to_last_stick;
@property(nonatomic,assign)NSInteger feed_flag;

@property(nonatomic,strong)Tips *tips;
@end
