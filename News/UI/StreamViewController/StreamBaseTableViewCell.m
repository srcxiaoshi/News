//
//  StreamTableViewCell.m
//  News
//
//  Created by 史瑞昌 on 2018/9/27.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "StreamBaseTableViewCell.h"
#import <SRCUIKit/SRCUIKit.h>

@interface StreamBaseTableViewCell()

@property(nonatomic,strong)UIView *line;

@end

@implementation StreamBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    return self;
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
