//
//  StreamOneImageTableViewCell.m
//  News
//
//  Created by 史瑞昌 on 2018/10/10.
//  Copyright © 2018 史瑞昌. All rights reserved.
//

#import "StreamOneImageTableViewCell.h"
#import <SRCUIKit/SRCUIKit.h>


@implementation StreamOneImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGFloat width=(VIEW_WIDTH-2*BASE_CELL_EDGE-2*BASE_CELL_IMAGE_EDGE)/3.0;
        self.title.frame=CGRectMake(BASE_CELL_EDGE, BASE_CELL_EDGE, VIEW_WIDTH-BASE_CELL_EDGE*2-width-BASE_CELL_EDGE, 0);

        self.imageview=[[SRCImageView alloc] init];
        [self.contentView addSubview:self.imageview];
    }
    return self;
}

//重写layoutSubviews 更新frame
-(void)layoutSubviews
{
    [super layoutSubviews];

    if(self.imageview)
    {
        if([self.imageview isKindOfClass:[SRCImageView class]])
        {

            CGFloat width=(VIEW_WIDTH-2*BASE_CELL_EDGE-2*BASE_CELL_IMAGE_EDGE)/3.0;
            CGFloat height=width*1.0/BASE_CELL_IMAGE_WIDTH*BASE_CELL_IMAGE_HEIGHT;
            self.imageview.frame=CGRectMake(VIEW_WIDTH-BASE_CELL_EDGE-width, BASE_CELL_EDGE, width, height);
        }
        else
        {
            ERROR();
            return;
        }
    }
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
