//
//  NOVReadEndView.h
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NOVReadEndView : UIView
@property(nonatomic,strong) UIButton *renewButton;//续写
@property(nonatomic,strong) UILabel *renewNumber;
@property(nonatomic,strong) UIButton *likeButton;//点赞
@property(nonatomic,strong) UILabel *likeNumber;
@property(nonatomic,strong) UIButton *disLikeButton;//反对
@property(nonatomic,strong) UILabel *disLikeNumber;
@end
