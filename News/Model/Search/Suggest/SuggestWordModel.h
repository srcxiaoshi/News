//
//  SuggestWordModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/17.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>

@interface SuggestWordModel : BaseModel

@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSString *word;

//request
@property(nonatomic,strong)NSString * sug_category;
@property(nonatomic,strong)NSString * from;
@end
