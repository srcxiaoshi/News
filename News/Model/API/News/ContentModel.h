//
//  ContentModel.h
//  News
//
//  Created by 史瑞昌 on 2018/9/30.
//  Copyright © 2018年 史瑞昌. All rights reserved.
//

#import <SRCFoundation/SRCFoundation.h>


@class ActionExtra;
@class ForwardInfo;
@class LogPB;
@class MediaInfo;
@protocol Action;
@protocol FilterWords;
@protocol SRCImageModel;

@interface ContentModel : BaseModel
@property(nonatomic,strong)NSString *abstract;
@property(nonatomic,strong)ActionExtra *action_extra;
@property(nonatomic,copy)NSArray<Action> *action_list;
@property(nonatomic,assign)NSInteger aggr_type;
@property(nonatomic,assign)BOOL allow_download;
@property(nonatomic,assign)NSInteger article_sub_type;
@property(nonatomic,assign)NSInteger article_type;
@property(nonatomic,strong)NSString *article_url;
@property(nonatomic,assign)NSInteger ban_comment;
@property(nonatomic,assign)NSInteger behot_time;
@property(nonatomic,assign)NSInteger bury_count;
@property(nonatomic,assign)NSInteger cell_flag;
@property(nonatomic,assign)NSInteger cell_layout_style;
@property(nonatomic,assign)NSInteger cell_type;
@property(nonatomic,assign)NSInteger comment_count;
@property(nonatomic,strong)NSString *content_decoration;
@property(nonatomic,assign)NSInteger cursor;
@property(nonatomic,assign)NSInteger digg_count;
@property(nonatomic,strong)NSString *display_url;
@property(nonatomic,copy)NSArray<FilterWords> *filter_words;
@property(nonatomic,strong)ForwardInfo *forward_info;
@property(nonatomic,assign)NSInteger gallary_image_count;
@property(nonatomic,assign)NSInteger group_id;
@property(nonatomic,assign)BOOL has_image;
@property(nonatomic,assign)BOOL has_m3u8_video;
@property(nonatomic,assign)NSInteger has_mp4_video;
@property(nonatomic,assign)BOOL has_video;
@property(nonatomic,assign)NSInteger hot;
@property(nonatomic,assign)NSInteger ignore_web_transform;
@property(nonatomic,copy)NSArray<SRCImageModel> *image_list;
@property(nonatomic,strong)NSString *interaction_data;
@property(nonatomic,assign)BOOL is_subject;
@property(nonatomic,assign)NSInteger item_id;
@property(nonatomic,assign)NSInteger item_version;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,assign)NSInteger level;
@property(nonatomic,strong)LogPB *log_pb;
@property(nonatomic,strong)MediaInfo *media_info;
@property(nonatomic,strong)NSString *media_name;
@property(nonatomic,strong)SRCImageModel *middle_image;
@property(nonatomic,assign)NSInteger need_client_impr_recycle;
@property(nonatomic,assign)NSInteger preload_web;
@property(nonatomic,assign)NSInteger publish_time;
@property(nonatomic,assign)NSInteger read_count;
@property(nonatomic,assign)NSInteger repin_count;
@property(nonatomic,strong)NSString *rid;
@property(nonatomic,assign)NSInteger share_count;
@property(nonatomic,strong)NSString *share_url;
@property(nonatomic,assign)BOOL show_dislike;
@property(nonatomic,assign)BOOL show_portrait;
@property(nonatomic,assign)BOOL show_portrait_article;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,assign)NSInteger source_icon_style;
@property(nonatomic,strong)NSString *source_open_url;
@property(nonatomic,strong)NSString *tag;
@property(nonatomic,assign)NSInteger tag_id;
@property(nonatomic,assign)NSInteger tip;
@property(nonatomic,strong)NSString *title;

//自定义
@property(nonatomic,assign,readonly)CGFloat height;
@end




@interface ActionExtra:BaseModel
@property(nonatomic,assign)NSInteger channel_id;
@end



@interface Action:BaseModel
@property(nonatomic,assign)NSInteger action;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)ActionExtra *extra;
@end


@interface FilterWords:BaseModel
@property(nonatomic,strong)NSString * id;
@property(nonatomic,assign)BOOL is_selected;
@property(nonatomic,strong)NSString *name;
@end

@interface ForwardInfo:BaseModel
@property(nonatomic,assign)NSInteger forward_count;
@end

@interface LogPB:BaseModel
@property(nonatomic,strong)NSString *impr_id;
@property(nonatomic,strong)NSString *is_following;
@end

@interface MediaInfo:BaseModel
@property(nonatomic,strong)NSString *avatar_url;
@property(nonatomic,assign)BOOL follow;
@property(nonatomic,assign)BOOL is_star_user;
@property(nonatomic,assign)NSInteger media_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *recommend_reason;
@property(nonatomic,assign)NSInteger recommend_type;
@property(nonatomic,assign)NSInteger user_id;
@property(nonatomic,assign)BOOL user_verified;
@property(nonatomic,strong)NSString *verified_content;
@end

@class ShareType;
@interface ShareInfo:BaseModel
@property(nonatomic,strong)NSString *cover_image;
@property(nonatomic,assign)NSInteger on_suppress;
@property(nonatomic,strong)NSString *share_url;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger token_type;
@property(nonatomic,strong)ShareType *share_type;
@property(nonatomic,strong)SRCImageModel *weixin_cover_image;
@end

@interface ShareType:BaseModel
@property(nonatomic,assign)NSInteger *pyq;
@property(nonatomic,assign)NSInteger *qq;
@property(nonatomic,assign)NSInteger *qzone;
@property(nonatomic,assign)NSInteger *wx;
@end














