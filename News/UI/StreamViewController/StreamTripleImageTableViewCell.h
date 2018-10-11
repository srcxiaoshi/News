//
//  StreamTripleImageTableViewCell.h
//  News
//
//  Created by 史瑞昌 on 2018/10/9.
//  Copyright © 2018 史瑞昌. All rights reserved.
//

#import <SRCUIKit/SRCUIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define BASE_CELL_IMAGE_EDGE    5

/**
 *  样式说明，第一行 一个标题， 第二行 三个图 第三行 来源 评论 时间 叉号按钮
 *  这里发现一共有三种样式
 */
static NSString *const StreamTripleImageTableViewCellID=@"StreamTripleImageTableViewCellID";


@interface StreamTripleImageTableViewCell : SRCBaseTableViewCell

@property(nonatomic,strong)SRCImageView *image1;//图1

@property(nonatomic,strong)SRCImageView *image2;//图2

@property(nonatomic,strong)SRCImageView *image3;//图3

@end

NS_ASSUME_NONNULL_END
