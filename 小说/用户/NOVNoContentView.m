//
//  NOVNoContentView.m
//  小说
//
//  Created by 李飞艳 on 2018/9/15.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNoContentView.h"

@implementation NOVNoContentView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.3);
        make.height.equalTo(self).multipliedBy(0.3);
        make.width.equalTo(self).multipliedBy(0.3);
        make.centerX.equalTo(self);
    }];
    _imageView.image = [UIImage imageNamed:@"simple_ic_drafts_none.png"];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.08);
        make.left.and.right.equalTo(_imageView);
    }];
    _label.text = @"暂无数据";
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
