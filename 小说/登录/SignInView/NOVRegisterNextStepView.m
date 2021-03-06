//
//  NOVRegisterNextStepView.m
//  小说
//
//  Created by 李飞艳 on 2018/8/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVRegisterNextStepView.h"

@implementation NOVRegisterNextStepView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_quitButton];
        
        _usernameTextField = [[UITextField alloc] init];
        [self addSubview:_usernameTextField];
        
        _passwardTextField = [[UITextField alloc] init];
        [self addSubview:_passwardTextField];
        
        _inputPswdAgain = [[UITextField alloc] init];
        [self addSubview:_inputPswdAgain];
        
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_registerButton];
        _registerButton.backgroundColor = [UIColor colorWithRed:0.92f green:0.65f blue:0.60f alpha:1.00f];
        _registerButton.userInteractionEnabled = NO;
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    [_quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.and.width.mas_equalTo(40);
    }];
    [_quitButton setImage:[UIImage imageNamed:@"退出.png"] forState:UIControlStateNormal];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.1);
        make.height.equalTo(self).multipliedBy(0.08);
        make.width.equalTo(self).multipliedBy(0.15);
        make.centerX.equalTo(self);
    }];
    [_imageView setImage:[UIImage imageNamed:@"笔组合.png"]];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.4);
        make.centerX.equalTo(self);
    }];
    _label.text = @"安康盛世也有冻死饿殍\n动荡乱世也有荣华富贵";
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    
    [_usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.36);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.7);
        make.centerX.equalTo(self);
    }];
    _usernameTextField.placeholder = @"请输入用户名(1～20个字符)";
    [self setTextField:_usernameTextField];
    
    [_passwardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usernameTextField.mas_bottom).offset(self.frame.size.height*0.02);
        make.height.equalTo(_usernameTextField);
        make.left.and.right.equalTo(_usernameTextField);
    }];
    _passwardTextField.placeholder = @"请输入密码(6～20个字符)";
    _passwardTextField.secureTextEntry = YES;
    [self setTextField:_passwardTextField];
    
    _inputPswdAgain.backgroundColor = [UIColor clearColor];
    [_inputPswdAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwardTextField.mas_bottom).offset(self.frame.size.height*0.02);
        make.height.equalTo(_usernameTextField);
        make.left.and.right.equalTo(_usernameTextField);
    }];
    _inputPswdAgain.placeholder = @"请再次输入密码";
    _inputPswdAgain.secureTextEntry = YES;
    [self setTextField:_inputPswdAgain];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inputPswdAgain.mas_bottom).offset(self.frame.size.height*0.05);
        make.height.equalTo(_usernameTextField).multipliedBy(0.9);
        make.width.equalTo(self).multipliedBy(0.65);
        make.centerX.equalTo(self);
    }];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
}

- (void)setTextField:(UITextField *)textField{
    textField.backgroundColor = [UIColor clearColor];
    [textField setFont:[UIFont systemFontOfSize:13]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_usernameTextField resignFirstResponder];
    [_passwardTextField resignFirstResponder];
    [_inputPswdAgain resignFirstResponder];
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
    
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.58)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.58)];
    [path1 stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
