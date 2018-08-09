//
//  NOVAccountManageCell.m
//  小说
//
//  Created by 李飞艳 on 2018/8/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVAccountManageCell.h"

@implementation NOVAccountManageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_myImageView];
        
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(_myImageView.mas_height);
    }];
    _myImageView.layer.masksToBounds = YES;
    _myImageView.layer.cornerRadius = 25;
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImageView.mas_right).offset(20);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(self.contentView).multipliedBy(0.8);
        make.centerY.equalTo(self.contentView);
    }];
    _nameLabel.font = [UIFont systemFontOfSize:17 weight:0.01];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor lightGrayColor];
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path stroke];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
