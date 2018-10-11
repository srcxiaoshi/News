//
//  Content.m
//  News
//
//  Created by 史瑞昌 on 2018/9/30.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "Content.h"
#import "ContentModel.h"
#import <SRCUIKit/SRCUIKit.h>


@implementation Content

//懒加载
-(ContentModel *)contentmodel
{
    if(![NSString safe_isEmpty:self.content])
    {
        return [[ContentModel alloc] safe_initWithString:self.content];
    }
    else
    {
        return nil;
    }
}


@end





