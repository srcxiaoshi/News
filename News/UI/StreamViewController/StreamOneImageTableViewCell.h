//
//  StreamOneImageTableViewCell.h
//  News
//
//  Created by 史瑞昌 on 2018/10/10.
//  Copyright © 2018 史瑞昌. All rights reserved.
//




#import <SRCUIKit/SRCUIKit.h>



NS_ASSUME_NONNULL_BEGIN

#define BASE_CELL_IMAGE_EDGE    5

/**
 *
 样式说明，左边 上面 一个标题
 +下面： 来源 评论 时间 叉号按钮
 右边 👉 一张图
 *  这里发现一共有三种样式
 */
static NSString *const StreamOneImageTableViewCellID=@"StreamOneImageTableViewCellID";


@interface StreamOneImageTableViewCell : SRCBaseTableViewCell

@property(nonatomic,strong)SRCImageView *imageview;

@end

NS_ASSUME_NONNULL_END
