//
//  NOVSetView.h
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVStartBookModel;
@class NOVSetbackView;
@class NOVGetMyStartModel;

//小说状态
typedef NS_OPTIONS(NSInteger, NovelState) {
    //未发布
    NovelStateUnpublish = 0,
    //已发布
    NovelStatePublished,
};

@interface NOVBookSetView : UIView
@property(nonatomic,strong) UIImageView *coverImage;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *editButton;
@property(nonatomic,strong) UIButton *detailButton;
@property(nonatomic,strong) NOVSetbackView *backView;
@property(nonatomic,assign) NovelState novelState;
@property(nonatomic,strong) UITapGestureRecognizer *changeImageGesture;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)updateWithModel:(NOVGetMyStartModel *)model;
-(void)setBookWithModel:(NOVStartBookModel *)model;
@end
