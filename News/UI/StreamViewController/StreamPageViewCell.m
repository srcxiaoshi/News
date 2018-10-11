//
//  StreamPageViewCell.m
//  News
//  note : 遇到了一个问题，cellForRowAtIndexPath 会先调用，调用完以后才会调用heightForRowAtIndexPath
//  Created by 史瑞昌 on 2018/9/27.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "StreamPageViewCell.h"
#import <SRCUIKit/SRCUIKit.h>
#import <SRCFoundation/SRCFoundation.h>
#import "StreamBaseTableViewCell.h"
#import "StreamTripleImageTableViewCell.h"
#import "StreamOneImageTableViewCell.h"

#import "News.h"
#import "Content.h"
#import "ContentModel.h"

@interface StreamPageViewCell()<SRCTableViewDelegate>

@property(nonatomic,strong)SRCTableView *tableView;
@property(nonatomic,copy)NSArray *data;


@property(nonatomic,assign)NSInteger last_refresh_sub_entrance_interval;//记录上次请求时间戳

@end


@implementation StreamPageViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.tableView=[[SRCTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.tableView.delegate=self;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark delegate
/**
 * section 数目
 */
- (NSInteger)numberOfSectionsInSRCTableView:(UITableView *)tableView
{
    return 1;
}

/**
 * cell数目
 */
- (NSInteger)SRCTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.data)
    {
        return [self.data count];
    }
    else
        return 0;
}

/**
 * cell样式
 */
- (UITableViewCell *)SRCTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [tableView registerClass:[StreamBaseTableViewCell class] forCellReuseIdentifier:StreamBaseTableViewCellID];
        [tableView registerClass:[StreamTripleImageTableViewCell class] forCellReuseIdentifier:StreamTripleImageTableViewCellID];
    });


    Content *content=[self.data safe_objectAtIndex:indexPath.row];
    ContentModel *model=[content contentmodel];
    //异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [model height];
    });
    SRCBaseTableViewCell *cell=nil;
    //判断是哪一种cell  这里有两种样式
    if(model.has_image&&model.image_list&&[model.image_list count]>0)
    {
        if([model.image_list count]>1)
        {
            StreamTripleImageTableViewCell *newcell=(StreamTripleImageTableViewCell *)[self cellForReuseIdentifier:StreamTripleImageTableViewCellID cellClass:[StreamTripleImageTableViewCell class] tableView:tableView];

            SRCImageModel *imagemodel1=[model.image_list safe_objectAtIndex:0];

            SRCImageModel *imagemodel2=[model.image_list safe_objectAtIndex:1];
            SRCImageModel *imagemodel3=[model.image_list safe_objectAtIndex:2];

            [newcell.image1 src_setImageWithURL:[NSURL URLWithString:imagemodel1.url]];
            [newcell.image2 src_setImageWithURL:[NSURL URLWithString:imagemodel2.url]];
            [newcell.image3 src_setImageWithURL:[NSURL URLWithString:imagemodel3.url]];

            cell=newcell;
        }
        else if([model.image_list count]==1)
        {
            StreamOneImageTableViewCell *newcell=(StreamOneImageTableViewCell *)[self cellForReuseIdentifier:StreamOneImageTableViewCellID cellClass:[StreamOneImageTableViewCell class] tableView:tableView];

            SRCImageModel *imagemodel1=[model.image_list safe_objectAtIndex:0];

            [newcell.imageview src_setImageWithURL:[NSURL URLWithString:imagemodel1.url]];

            cell=newcell;
        }

    }
    else
    {
        cell=(StreamBaseTableViewCell *)[self cellForReuseIdentifier:StreamBaseTableViewCellID cellClass:[StreamBaseTableViewCell class] tableView:tableView];
    }




    //处理标题
    cell.title.text=model.title;

    //处理时间
    NSInteger now=[[NSDate date] timeIntervalSince1970]/1000;
    NSInteger date=model.publish_time/1000;
    NSInteger difference=(now-date)/60;//换算成以分为单位

    //处理来源
    NSString * source=@"";
    if([NSString safe_isEmpty:model.source])
    {
        source=@"互联网";
    }
    else
    {
        source=model.source;
    }


    cell.info.text=[NSString stringWithFormat:@"%@    %ld评论    %ld分钟前",source,(long)model.read_count,difference];
    return cell;

}

//private
-(UITableViewCell *)cellForReuseIdentifier:(NSString *)reuseIdentifier cellClass:(Class) cellClass tableView:(UITableView *)tableView
{
    //这里还没有做健壮性判断

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell)
    {
        cell=[[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

/**
 * cell高度
 */
-(CGFloat)SRCTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Content *content=[self.data safe_objectAtIndex:indexPath.row];
    ContentModel *model=[content contentmodel];
    return model.height;
}


/**
 * cell点击事件
 */
- (void)SRCTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(SRCStreamView:didSelectRowAtIndexPath:)])
    {
        [self.delegate SRCStreamView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

//网络
-(void)loadDataFromNetwork
{
    if(!self.data)
    {
        self.data =[NSArray new];
    }

    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict safe_setObject:@"1" forKey:@"refresh_reason"];
    [dict safe_setObject:@"1" forKey:@"detail"];
    if(self.last_refresh_sub_entrance_interval)
    {
        NSString *str=[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]/1000];
        self.last_refresh_sub_entrance_interval=[[NSDate date] timeIntervalSince1970]/1000;
        [dict safe_setObject:str forKey:@"last_refresh_sub_entrance_interval"];
    }
    [dict safe_setObject:@"pull" forKey:@"tt_from"];
    [dict safe_setObject:@"20" forKey:@"count"];
    [dict safe_setObject:@"15" forKey:@"list_count"];
    [dict safe_setObject:@"4" forKey:@"support_rn"];
    [dict safe_setObject:@"authroize" forKey:@"LBS_status"];
    [dict safe_setObject:@"57B2B805372BEq1" forKey:@"cp"];
    [dict safe_setObject:@"1" forKey:@"loc_mode"];
    [dict safe_setObject:[NSNumber numberWithInteger:self.last_refresh_sub_entrance_interval] forKey:@"min_behot_time"];
    [dict safe_setObject:@"2" forKey:@"session_refresh_idx"];
    [dict safe_setObject:@"1" forKey:@"image"];
    [dict safe_setObject:@"0" forKey:@"strict"];
    [dict safe_setObject:@"1" forKey:@"refer"];
    [dict safe_setObject:@"6286225228934679042" forKey:@"concern_id"];
    //city=
    [dict safe_setObject:@"277" forKey:@"st_time"];


    __weak typeof(self) weakself=self;
    [SRCNetworkWithAF requestGetMethodWithPath:@"https://it.snssdk.com/api/news/feed/v88/?fp=jrTqLSZIcWwOFlGSJlU1FlFSFYGe" parameters:[dict copy] withProgress:nil success:^(BOOL isSuccess, NSString *response) {
        __strong typeof(weakself) strongself=weakself;
        //处理返回的数据
        News * newmodel=[[News alloc] safe_initWithString:response];
        if(newmodel&&newmodel.total_number>0&&newmodel.data&&[newmodel.data count]>0)
        {
            NSMutableArray *arr=nil;
            if(strongself.data)
            {
                arr=[[NSMutableArray alloc] initWithArray:strongself.data];
            }
            for(NSInteger i=newmodel.total_number-1;i>=0;i--)
            {
                if([newmodel.data count]>i)
                {
                    ContentModel *model=[[newmodel.data safe_objectAtIndex:i] contentmodel];
                    //微头条的数据，后面再处理吧
                    if([NSString safe_isEmpty:model.title])
                    {
                        continue;
                    }

                    [arr safe_insertObject:[newmodel.data safe_objectAtIndex:i] atIndex:0];
                }

            }

            strongself.data=[arr copy];
            [strongself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        if(error)
        {
            NSLog(@"%@",error);
        }
    }];
}



@end
