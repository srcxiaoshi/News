//
//  Content.h
//  News
//
//  Created by 史瑞昌 on 2018/9/30.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@class ContentModel;
@interface Content : BaseModel

@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong,readonly)ContentModel *contentmodel;

@end
