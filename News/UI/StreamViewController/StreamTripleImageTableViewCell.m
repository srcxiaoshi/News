//
//  StreamTripleImageTableViewCell.m
//  News
//
//  Created by 史瑞昌 on 2018/10/9.
//  Copyright © 2018 史瑞昌. All rights reserved.
//

#import "StreamTripleImageTableViewCell.h"
#import <SRCUIKit/SRCUIKit.h>


@implementation StreamTripleImageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.image1=[[SRCImageView alloc] init];
        [self.contentView addSubview:self.image1];

        self.image2=[[SRCImageView alloc] init];
        [self.contentView addSubview:self.image2];

        self.image3=[[SRCImageView alloc] init];
        [self.contentView addSubview:self.image3];
    }
    return self;
}

//重写layoutSubviews 更新frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.image1&&self.image2&&self.image3)
    {
        if([self.image1 isKindOfClass:[SRCImageView class]]&&[self.image2 isKindOfClass:[SRCImageView class]]&&[self.image3 isKindOfClass:[SRCImageView class]])
        {

            CGFloat width=(VIEW_WIDTH-2*BASE_CELL_EDGE-2*BASE_CELL_IMAGE_EDGE)/3.0;
            CGFloat height=width*1.0/BASE_CELL_IMAGE_WIDTH*BASE_CELL_IMAGE_HEIGHT;
            self.image1.frame=CGRectMake(BASE_CELL_EDGE, self.title.frame.origin.y+self.title.frame.size.height+BASE_CELL_TITLE_AND_SOURCE_EDGE, width, height);
        self.image2.frame=CGRectMake(self.image1.frame.origin.x+self.image1.frame.size.width+BASE_CELL_IMAGE_EDGE, self.image1.frame.origin.y, width, height);

        self.image3.frame=CGRectMake(self.image2.frame.origin.x+self.image2.frame.size.width+BASE_CELL_IMAGE_EDGE, self.image1.frame.origin.y, width, height);

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
