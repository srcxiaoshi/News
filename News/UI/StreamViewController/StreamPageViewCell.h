//
//  StreamPageViewCell.h
//  News
//
//  Created by 史瑞昌 on 2018/9/27.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCUIKit/SRCUIKit.h>


static NSString * const SRCPageViewCellStreamID=@"SRCPageViewCellStreamID";

@protocol StreamPageViewCellDelegate <NSObject>

@required
- (void)SRCStreamView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end





@interface StreamPageViewCell : SRCPageViewCell

@property(nonatomic,weak)id <StreamPageViewCellDelegate> delegate;
-(void)loadDataFromNetwork;

@end
