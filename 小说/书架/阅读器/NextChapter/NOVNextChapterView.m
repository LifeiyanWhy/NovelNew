//
//  NOVNextChapterView.m
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNextChapterView.h"

@implementation NOVNextChapterView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.92);
            make.centerX.equalTo(self);
        }];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
