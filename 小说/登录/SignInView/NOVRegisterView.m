//
//  NOVSignupView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVRegisterView.h"
#import "Masonry.h"

@implementation NOVRegisterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _accountTextField = [[UITextField alloc] init];
        [self addSubview:_accountTextField];
        
        _verifyTextfield = [[UITextField alloc] init];
        [self addSubview:_verifyTextfield];
        
        _verifyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_verifyeButton];
        
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextStepButton];
        _nextStepButton.backgroundColor = [UIColor colorWithRed:0.92f green:0.65f blue:0.60f alpha:1.00f];
        _nextStepButton.userInteractionEnabled = NO;
        
        _quit = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_quit];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [_quit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.and.width.mas_equalTo(40);
    }];
    [_quit setImage:[UIImage imageNamed:@"退出.png"] forState:UIControlStateNormal];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.1);
        make.height.equalTo(self).multipliedBy(0.08);
        make.width.equalTo(self).multipliedBy(0.15);
        make.centerX.equalTo(self);
    }];
    [imageView setImage:[UIImage imageNamed:@"笔组合.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.4);
        make.centerX.equalTo(self);
    }];
    label.text = @"安康盛世也有冻死饿殍\n动荡乱世也有荣华富贵";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.36);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.43);
        make.left.equalTo(_verifyTextfield);
    }];
    _accountTextField.placeholder = @"请输入手机号";
    [self setTextField:_accountTextField];
    _accountTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    
    [_verifyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_accountTextField);
        make.height.equalTo(_accountTextField).multipliedBy(0.8);
        make.right.equalTo(self).offset(self.frame.size.width*0.15*-1);
        make.width.equalTo(self).multipliedBy(0.25);
    }];
    [_verifyeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyeButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [_verifyeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _verifyeButton.titleLabel.textAlignment = NSTextAlignmentRight;
    _verifyeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _verifyeButton.backgroundColor = [UIColor clearColor];
    
    [_verifyTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountTextField.mas_bottom).offset(self.frame.size.height*0.02);
        make.height.equalTo(_accountTextField);
        make.width.equalTo(self).multipliedBy(0.67);
        make.centerX.equalTo(self);
    }];
    _verifyTextfield.placeholder = @"请输入验证码";
    [self setTextField:_verifyTextfield];

    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyTextfield.mas_bottom).offset(self.frame.size.height*0.025);
        make.height.equalTo(_accountTextField);
        make.width.equalTo(self).multipliedBy(0.65);
        make.centerX.equalTo(self);
    }];
    [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStepButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
}

- (void)setTextField:(UITextField *)textField{
    textField.backgroundColor = [UIColor clearColor];
    [textField setFont:[UIFont systemFontOfSize:15]];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_accountTextField resignFirstResponder];
    [_verifyTextfield resignFirstResponder];
}

- (void)drawRect:(CGRect)rect{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIColor *color = SystemColor;
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapButt;
    [path moveToPoint:CGPointMake(0, height*0.3)];
    [path addQuadCurveToPoint:CGPointMake(width, height*0.3) controlPoint:CGPointMake(width*0.5, height*0.3+30)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    [path fill];
    
    UIColor *color1 = [UIColor lightGrayColor];
    [color1 set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 0.7;
    path1.lineJoinStyle = kCGLineCapButt;
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.42)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.42)];
    [path1 stroke];
    
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.50)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.50)];
    [path1 stroke];
    
    UIColor *color2 = [UIColor lightGrayColor];
    [color2 set];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    path2.lineWidth = 0.5;
    path2.lineJoinStyle = kCGLineCapButt;
    [path2 moveToPoint:CGPointMake(width*0.65, height*0.37)];
    [path2 addLineToPoint:CGPointMake(width*0.65, height*0.41)];
    [path2 stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
