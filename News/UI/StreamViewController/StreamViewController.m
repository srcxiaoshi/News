//
//  StreamViewController.m
//  News
//
//  Created by 史瑞昌 on 2018/9/13.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import "StreamViewController.h"
#import <SRCUIKit/SRCUIKit.h>

#import <SRCFoundation/SRCFoundation.h>


#import "Category.h"
#import "StreamPageViewCell.h"

@interface StreamViewController ()<SRCMenuViewDelegate,SRCMenuViewDataSource,SRCPageViewDelegate>

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)SRCMenuView *menuview;
@property(nonatomic,strong)SRCPageView *srcview;
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@implementation StreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuview=[[SRCMenuView alloc] initWithFrame:CGRectMake(0,NavHeight, VIEW_WIDTH,SRCMENUVIEW_HEIGHT) leftBtn:NO rightBtn:YES];
    self.selectedIndex=1;
    self.menuview.datasource=self;
    self.menuview.delegate=self;

    [self.view addSubview:self.menuview];
    [self loadDataFromNetWork];
    [self loadSRCPageView];

    //测试一下image
    [self downImage];
}

-(void)downImage
{
    
}

#pragma mark -delegate -menuView datasource
-(void)menuView:(SRCMenuItem *)item index:(NSInteger)index
{
    NSLog(@"点击了menu=%@",item.text);
    if(index<[self.data count])
    {
        [self.srcview scollToItemWithPageIndex:index animated:YES];
        self.selectedIndex=index;
    }
}

- (NSInteger)numbersOfTitlesInMenuView:(SRCMenuView *)menu
{
    if(self.data)
    {
        return [self.data count];
    }
    return 0;
}

- (NSString *)menuView:(SRCMenuView *)menu titleAtIndex:(NSInteger)index
{
    if(self.data&&index<[self.data count])
    {
        CategoryItem *item=[self.data safe_objectAtIndex:index];
        return item.name;
    }
    else
    {
        return @"name";
    }
}


#pragma mark SRCPageView delegate/datasource
- (NSInteger)SRCPageViewNumberOfItems:(UICollectionView *)collectionView
{
    if(self.data)
    {
        return [self.data count];
    }
    else
    {
        return 0;
    }
}

- (SRCPageViewCell *)SRCPageView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [collectionView registerClass:[StreamPageViewCell class] forCellWithReuseIdentifier:SRCPageViewCellStreamID];
    });
    StreamPageViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:SRCPageViewCellStreamID forIndexPath:indexPath];
    if(cell)
    {
        if(self.selectedIndex==indexPath.row)
        {
            [cell loadDataFromNetwork];
        }
        return cell;
    }
    else
    {
        return [collectionView dequeueReusableCellWithReuseIdentifier:SRCPageViewCellDefaultID forIndexPath:indexPath];
    }
}

- (void)SRCPageView:(UICollectionView *)collectionView pageIndex:(NSInteger)pageIndex
{
    //这里滑动后，去给menuview 做切换高亮
    if(pageIndex<[self.data count])
    {
        [self.menuview setSelectedWithPageIndex:pageIndex];
        self.selectedIndex=pageIndex;
    }
}

- (void)SRCPageView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"点击了页面");
}

#pragma mark loadsomethings
-(void)loadSRCPageView
{
    self.srcview=[[SRCPageView alloc] initWithFrame:CGRectMake(0, NavHeight+SRCITEM_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT-NavHeight-SRCITEM_HEIGHT-self.tabBarController.tabBar.frame.size.height)];
    self.srcview.delegate=self;
    [self.view addSubview:self.srcview];
    
}

//stream menu 网络请求
-(void)loadDataFromNetWork
{
    NSMutableArray *categories=[NSMutableArray new];
    [categories safe_addObject:@"__all__"];
    [categories safe_addObject:@"news_hot"];
    [categories safe_addObject:@"news_local"];
    [categories safe_addObject:@"video"];
    [categories safe_addObject:@"question_and_answer"];
    [categories safe_addObject:@"组图"];
    [categories safe_addObject:@"news_entertainment"];
    [categories safe_addObject:@"news_sports"];
    [categories safe_addObject:@"news_tech"];
    [categories safe_addObject:@"news_car"];
    [categories safe_addObject:@"news_finance"];
    [categories safe_addObject:@"news_military"];
    [categories safe_addObject:@"essay_joke"];
    [categories safe_addObject:@"image_ppmm"];
    [categories safe_addObject:@"news_world"];
    [categories safe_addObject:@"image_funny"];
    [categories safe_addObject:@"news_health"];
    [categories safe_addObject:@"news_house"];
   
    NSString* user_modify=@"0";
    
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict safe_setObject:user_modify forKey:@"user_modify"];
    [dict safe_setObject:categories forKey:@"categories"];
    
    __weak typeof(self) weakself=self;
    [SRCNetworkWithAF requestGetMethodWithPath:@"http://ib.snssdk.com/article/category/get_subscribed/v4/" parameters:dict withProgress:nil success:^(BOOL isSuccess, NSString *response) {
        __strong typeof(weakself) strongself=weakself;
        if(response)
        {
            Category *category=[[Category alloc] safe_initWithString:response];
            NSArray *items=category.data.data;
            strongself.data=items;
            [strongself.menuview reloadDataAndUpdate];
            [strongself.srcview refreshViewWithCallBack:^{
                [strongself.menuview setSelectedWithPageIndex:1];//关注？
                [strongself.srcview scollToItemWithPageIndex:1 animated:NO];//关注？
                strongself.selectedIndex=1;
            }];
            
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
    }];

}

#pragma mark -StreamPagViewCellDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
