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
        
        _renewNumber = [[UILabel alloc] init];
        [self addSubview:_renewNumber];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_likeButton];
        
        _likeNumber = [[UILabel alloc] init];
        [self addSubview:_likeNumber];

        _disLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_disLikeButton];
        
        _disLikeNumber = [[UILabel alloc] init];
        [self addSubview:_disLikeNumber];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat viewWidth = self.frame.size.width;
    [_renewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(viewWidth*0.05);
        make.width.equalTo(self).multipliedBy(0.2);
        make.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.4);
    }];
    [self setButton:_renewButton title:@"我要续写" selectTitle:@"我要续写"];
    [_renewNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_renewButton.mas_bottom);
        make.left.and.right.equalTo(_renewButton);
        make.height.equalTo(self).multipliedBy(0.3);
    }];
    [self setLabelWithLabel:_renewNumber];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_renewButton.mas_right).offset(viewWidth*0.15);
        make.width.equalTo(_renewButton);
        make.top.and.height.equalTo(_renewButton);
    }];
    [self setButton:_likeButton title:@"点赞" selectTitle:@"已点赞"];
    [_likeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_likeButton);
        make.top.and.height.equalTo(_renewNumber);
    }];
    [self setLabelWithLabel:_likeNumber];
    
    [_disLikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeButton.mas_right).offset(viewWidth*0.15);
        make.width.equalTo(_renewButton);
        make.top.and.height.equalTo(_renewButton);
    }];
    [self setButton:_disLikeButton title:@"反对" selectTitle:@"已反对"];
    
    [_disLikeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_renewNumber);
        make.left.and.right.equalTo(_disLikeButton);
    }];
    [self setLabelWithLabel:_disLikeNumber];
}

-(void)setButton:(UIButton *)button title:(NSString *)title selectTitle:(NSString *)selectTitle{
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected | UIControlStateHighlighted];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
}

-(void)setLabelWithLabel:(UILabel *)label{
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
