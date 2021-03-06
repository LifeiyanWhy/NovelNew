//
//  NOVSigninView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/6.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSigninView.h"
#import "Masonry.h"

@implementation NOVSigninView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _accountTextField = [[UITextField alloc] init];
        [self addSubview:_accountTextField];
        
        _passwardTextField = [[UITextField alloc] init];
        [self addSubview:_passwardTextField];
        
        _verityTextField = [[UITextField alloc] init];
        [self addSubview:_verityTextField];
        
        _verityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_verityButton];
        
        _showPassword = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_showPassword];
   
        _signinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_signinButton];
        
        _signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_signupButton];
        _signinButton.backgroundColor = [UIColor colorWithRed:0.92f green:0.65f blue:0.60f alpha:1.00f];
        _signinButton.userInteractionEnabled = NO;
        
        _findPasswradButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_findPasswradButton];
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
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
    
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height*0.36);
        make.height.equalTo(self).multipliedBy(0.06);
        make.width.equalTo(self).multipliedBy(0.67);
        make.centerX.equalTo(self);
    }];
    _accountTextField.placeholder = @"请求输入账号";
    [self setTextField:_accountTextField];

    [_passwardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountTextField.mas_bottom).offset(self.frame.size.height*0.01);
        make.height.equalTo(_accountTextField);
        make.left.and.right.equalTo(_accountTextField);
    }];
    _passwardTextField.placeholder = @"请输入密码";
    _passwardTextField.secureTextEntry = YES;
    [self setTextField:_passwardTextField];
    
    _showPassword.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [_showPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_passwardTextField).multipliedBy(0.7);
        make.centerY.equalTo(_passwardTextField);
        make.right.equalTo(_passwardTextField);
        make.width.equalTo(_passwardTextField.mas_height).multipliedBy(0.7);
    }];
    [_showPassword setImage:[UIImage imageNamed:@"眼睛1.png"] forState:UIControlStateNormal];
    [_showPassword setImage:[UIImage imageNamed:@"眼睛2.png"] forState:UIControlStateSelected];
    [_showPassword addTarget:self action:@selector(showPasswordChange:) forControlEvents:UIControlEventTouchUpInside];
    
    [_verityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwardTextField.mas_bottom).offset(self.frame.size.height*0.01);
        make.height.equalTo(_accountTextField);
        make.left.and.right.equalTo(_accountTextField);
    }];
    _verityTextField.placeholder = @"请输入验证码";
    [self setTextField:_verityTextField];
    
    _verityButton.backgroundColor = [UIColor clearColor];
    [_verityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_verityTextField);
        make.bottom.equalTo(_verityTextField);
        make.right.equalTo(self).offset(self.frame.size.width*0.15*-1);
        make.width.equalTo(self).multipliedBy(0.22);
    }];
    _verityButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _verityButton.layer.borderWidth = 0.5;
    
    [_signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_verityTextField.mas_bottom).offset(self.frame.size.height*0.05);
        make.height.equalTo(_accountTextField).multipliedBy(0.9);
        make.width.equalTo(self).multipliedBy(0.65);
        make.centerX.equalTo(self);
    }];
    [_signinButton setTitle:@"登录" forState:UIControlStateNormal];
    [_signinButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    
    [_signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signinButton.mas_bottom).offset(self.frame.size.height*0.025);
        make.height.equalTo(self).multipliedBy(0.03);
        make.left.equalTo(_signinButton);
        make.width.equalTo(self).multipliedBy(0.1);
    }];
    [_signupButton setTitle:@"注册" forState:UIControlStateNormal];
    [_signupButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_signupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_findPasswradButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_signupButton);
        make.right.equalTo(_signinButton);
        make.width.equalTo(self).multipliedBy(0.2);
    }];
    [_findPasswradButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_findPasswradButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_findPasswradButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)showPasswordChange:(UIButton *)button{
    button.selected = !button.selected;
    if (!button.selected) {
        _passwardTextField.secureTextEntry = YES;
    }else{
        _passwardTextField.secureTextEntry = NO;
    }
}

- (void)setTextField:(UITextField *)textField{
    textField.backgroundColor = [UIColor clearColor];
    [textField setFont:[UIFont systemFontOfSize:15]];
    textField.textColor = [UIColor blackColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_passwardTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
    [_verityTextField resignFirstResponder];
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
    path1.lineWidth = 0.7 ;
    path1.lineJoinStyle = kCGLineCapButt;
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.41)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.41)];
    [path1 stroke];
    
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.49)];
    [path1 addLineToPoint:CGPointMake(width*0.85, height*0.49)];
    [path1 stroke];
    
    [path1 moveToPoint:CGPointMake(width*0.15, height*0.57)];
    [path1 addLineToPoint:CGPointMake(width*0.6, height*0.57)];
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
