//
//  BaseViewController.h
//  News
//
//  Created by 史瑞昌 on 2018/9/16.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SuggestWordModel;

@interface BaseViewController : UIViewController

-(void)updateSearchAndSuggestWithString:(SuggestWordModel *)model;

@end
