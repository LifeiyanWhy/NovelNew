//
//  NOVNetworkAnomalyView.m
//  小说
//
//  Created by 李飞艳 on 2018/7/21.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNetworkAnomalyView.h"

@implementation NOVNetworkAnomalyView{
    UIButton *button;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
    }
    return self;
}

-(void)layoutSubviews{
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(150);
        make.center.equalTo(self);
    }];
    [button setImage:[UIImage imageNamed:@"网络连接失败.png"] forState:UIControlStateNormal];
    [button setTitle:@"网络连接失败，点击重试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    CGFloat labelHeight = button.titleLabel.intrinsicContentSize.height;
    CGFloat imageHeight = button.imageView.intrinsicContentSize.height;
    CGFloat labelWidth = button.titleLabel.intrinsicContentSize.width;
    CGFloat imageWidth = button.imageView.intrinsicContentSize.width;
    [button setImageEdgeInsets:UIEdgeInsetsMake(labelHeight*-1, labelWidth/4,labelHeight, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight/2, -1*imageWidth, -1*imageHeight/2, 0)];
}

-(void)touch{
    if ([self.delegate respondsToSelector:@selector(touchAnomalyImage)]) {
        [self.delegate touchAnomalyImage];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
