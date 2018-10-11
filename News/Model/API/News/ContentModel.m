//
//  ContentModel.m
//  News
//
//  Created by 史瑞昌 on 2018/9/30.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "ContentModel.h"
#import <SRCFoundation/SRCFoundation.h>
#import <SRCUIKit/SRCUIKit.h>

@interface ContentModel()

@property(nonatomic,assign)CGFloat canculateHeight;

@end

@implementation ContentModel

//动态计算高度
-(CGFloat)height
{
    if(_canculateHeight==0)
    {
        //有图
        if(self.has_image&&self.image_list&&[self.image_list count]>0)
        {
            CGFloat width=(VIEW_WIDTH-2*BASE_CELL_EDGE-BASE_CELL_TITLE_AND_SOURCE_EDGE*2)/3.0;
            CGFloat height=width*1.0/BASE_CELL_IMAGE_WIDTH*BASE_CELL_IMAGE_HEIGHT;
            
            if([self.image_list count]>1)
            {
                //计算title高度
                CGSize size=[self.title easy_sizeWithFont:[UIFont systemFontOfSize:BASE_CELL_TITLE_FONT_SIZE] forWidth:(VIEW_WIDTH-BASE_CELL_EDGE*2) lineBreakMode:NSLineBreakByWordWrapping];
                _canculateHeight=size.height+2*BASE_CELL_EDGE+BASE_CELL_DELETE_BUTTON_HEIGH+BASE_CELL_TITLE_AND_SOURCE_EDGE;


                _canculateHeight+=height+BASE_CELL_TITLE_AND_SOURCE_EDGE;
            }
            else
            {
                //计算title高度
                CGSize size=[self.title easy_sizeWithFont:[UIFont systemFontOfSize:BASE_CELL_TITLE_FONT_SIZE] forWidth:(VIEW_WIDTH-BASE_CELL_EDGE*2-BASE_CELL_IMAGE_WIDTH-BASE_CELL_EDGE) lineBreakMode:NSLineBreakByWordWrapping];
               if(size.height>=height)
               {
                   _canculateHeight=size.height+BASE_CELL_EDGE*2+BASE_CELL_DELETE_BUTTON_HEIGH+BASE_CELL_TITLE_AND_SOURCE_EDGE;
               }
               else
               {
                   _canculateHeight=height+BASE_CELL_EDGE*2;
               } 
            }
        }
        //无图无视频 title的高度 + 来源=信息的高度 对应SRCBaseTableViewCellID
        else if(![NSString safe_isEmpty:self.title]&&![NSString safe_isEmpty:self.source])
        {
            //计算title高度
            CGSize size=[self.title easy_sizeWithFont:[UIFont systemFontOfSize:BASE_CELL_TITLE_FONT_SIZE] forWidth:(VIEW_WIDTH-BASE_CELL_EDGE*2) lineBreakMode:NSLineBreakByWordWrapping];
            _canculateHeight=size.height+2*BASE_CELL_EDGE+BASE_CELL_DELETE_BUTTON_HEIGH+BASE_CELL_TITLE_AND_SOURCE_EDGE;
        }
        else
        {
            ERROR();
            return 0;
        }
    }

    return _canculateHeight;
}


@end

@implementation ActionExtra

@end

@implementation Action

@end

@implementation FilterWords

@end

@implementation ForwardInfo

@end

@implementation LogPB

@end


@implementation MediaInfo

@end

@implementation ShareInfo

@end



