//
//  SuggestDataModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/17.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@protocol SuggestWordModel;

@interface SuggestDataModel : BaseModel

@property(nonatomic,strong)NSNumber *call_per_refresh;//是否伴随 tableview刷新而刷新
@property(nonatomic,strong)NSString *homepage_search_suggest;

@property(nonatomic,copy)NSArray <SuggestWordModel> *suggest_words;

@end
