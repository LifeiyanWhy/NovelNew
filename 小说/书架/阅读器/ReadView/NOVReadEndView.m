//
//  NOVReadEndView.m
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadEndView.h"
@implementation NOVReadEndView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _renewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_renewButton];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_likeButton];

        _nextChapterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextChapterButton];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat viewWidth = self.frame.size.width;
    [_renewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(viewWidth*0.05);
        make.width.equalTo(self).multipliedBy(0.2);
        make.top.and.height.equalTo(self);
    }];
    [self setButton:_renewButton title:@"我要续写"];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_renewButton.mas_right).offset(viewWidth*0.15);
        make.width.equalTo(_renewButton);
        make.top.and.height.equalTo(_renewButton);
    }];
    [self setButton:_likeButton title:@"点赞"];
    
    [_nextChapterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeButton.mas_right).offset(viewWidth*0.15);
        make.width.equalTo(_renewButton);
        make.top.and.height.equalTo(_renewButton);
    }];
    [self setButton:_nextChapterButton title:@"下一章"];
}

-(void)setButton:(UIButton *)button title:(NSString *)title{
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
