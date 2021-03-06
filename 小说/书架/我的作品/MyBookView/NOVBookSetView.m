//
//  NOVSetView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVBookSetView.h"
#import "NOVStartBookModel.h"
#import "NOVSetbackView.h"
#import "NOVGetMyStartModel.h"
#import <UIImageView+WebCache.h>
@implementation NOVBookSetView{
    UIView *view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        
        _novelState = NovelStateUnpublish;
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:view];
        
        _coverImage = [[UIImageView alloc] init];
        [view addSubview:_coverImage];
        _coverImage.userInteractionEnabled = YES;
        
        _changeImageGesture = [[UITapGestureRecognizer alloc] init];
        //给image添加手势，用于点击更换图像
        [_coverImage addGestureRecognizer:_changeImageGesture];
        
        _titleLabel = [[UILabel alloc] init];
        [view addSubview:_titleLabel];
        
        _editButton = [[UIButton alloc] init];
        [view addSubview:_editButton];
        
        _detailButton = [[UIButton alloc] init];
        [view addSubview:_detailButton];
    }
    return self;
}

-(void)layoutSubviews{
    
    [_coverImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(view.frame.size.height*0.08);
        make.height.equalTo(view).multipliedBy(0.28);
        make.width.equalTo(view).multipliedBy(0.45);
        make.centerX.equalTo(view);
    }];
    _coverImage.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];

    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_coverImage.mas_bottom).offset(view.frame.size.height*0.025);
        make.height.equalTo(view).multipliedBy(0.1);
        make.width.equalTo(view).multipliedBy(0.8);
        make.centerX.equalTo(view);
    }];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:20 weight:0.02];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_editButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(view.frame.size.height*-0.15);
        make.height.equalTo(view).multipliedBy(0.08);
        make.width.equalTo(view).multipliedBy(0.7);
        make.centerX.equalTo(view);
    }];
    _editButton.layer.cornerRadius = 20;
    _editButton.layer.masksToBounds = YES;
    _editButton.backgroundColor = [UIColor colorWithRed:0.07 green:0.63 blue:0.58 alpha:1.00];
    _editButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:0.2];
    
    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editButton.mas_bottom).offset(view.frame.size.height*0.03);
        make.height.equalTo(view).multipliedBy(0.05);
        make.width.equalTo(_detailButton.mas_height);
        make.centerX.equalTo(view);
    }];
    [_detailButton setImage:[UIImage imageNamed:@"设置.png"] forState:UIControlStateNormal];
    [_detailButton addTarget:self action:@selector(changeToDetail) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateWithModel:(NOVGetMyStartModel *)model{
    self.titleLabel.text = model.bookName;
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BookImageUrl,model.bookImage]] placeholderImage:[UIImage imageNamed:@""]];
    [self.backView updateWithModel:model];
}

-(void)setBookWithModel:(NOVStartBookModel *)model{
    self.titleLabel.text = model.name;
    self.coverImage.image = model.bookImage;    
    [self.backView setBookWithModel:model];
}

-(NOVSetbackView *)backView{
    if (!_backView) {
        _backView = [[NOVSetbackView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_backView];
        [_backView.close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _backView.hidden = YES;
    }
    return _backView;
}

-(void)changeToDetail{
    self.backView.hidden = NO;
    [UIView transitionFromView:view toView:_backView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
    }];
}

-(void)close{
    [UIView transitionFromView:_backView toView:view duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
    }];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor whiteColor];
    [color set];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:20];
    [path fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
