//
//  NOVSignUpViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/9.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSignUpViewController.h"
#import "NOVSignupView.h"
#import "NOVSignUpNextViewController.h"
@interface NOVSignUpViewController ()<UITextFieldDelegate>

@end

@implementation NOVSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.signUpView];
}

-(NOVSignupView *)signUpView{
    if (!_signUpView) {
        _signUpView = [[NOVSignupView alloc] initWithFrame:self.view.frame];
        _signUpView.accountTextField.delegate = self;
        _signUpView.verifyTextfield.delegate = self;
        [self.view addSubview:_signUpView];
        [_signUpView.verifyeButton addTarget:self action:@selector(obtainVerify) forControlEvents:UIControlEventTouchUpInside];
        [_signUpView.nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        [_signUpView.quit addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpView;
}

-(void)obtainVerify{
    if (_signUpView.accountTextField.text.length != 11) {
        [self showAlertActionWithTitle:@"手机号为十一位数字"];
        return;
    }
}

-(void)next{
    //检测验证码是否正确
    NOVSignUpNextViewController *signUpNextViewController = [[NOVSignUpNextViewController alloc] init];
    [self.navigationController pushViewController:signUpNextViewController animated:NO];
}

-(void)quit{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *messageAlert = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:messageAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_signUpView.accountTextField resignFirstResponder];
    [_signUpView.verifyTextfield resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
