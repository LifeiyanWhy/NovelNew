//
//  NOVSignUpNextViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/9.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSignUpNextViewController.h"
#import "NOVSignUpNextView.h"
#import "ViewController.h"
#import "NOVSigninView.h"
@interface NOVSignUpNextViewController ()

@end

@implementation NOVSignUpNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signUpNextView];
}

-(NOVSignUpNextView *)signUpNextView{
    if (!_signUpNextView) {
        _signUpNextView = [[NOVSignUpNextView alloc] initWithFrame:self.view.frame];
        [_signUpNextView.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [_signUpNextView.quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpNextView;
}

-(void)signUp{
    if (_signUpNextView.usernameTextField.text.length < 2 || _signUpNextView.usernameTextField.text.length > 20) {
        [self showAlertActionWithTitle:@"用户名为2～20位"];
        return;
    }else if (_signUpNextView.passwardTextField.text.length < 6 || _signUpNextView.passwardTextField.text.length > 30){
        [self showAlertActionWithTitle:@"密码为6～30位"];
        return;
    }else if (_signUpNextView.passwardTextField.text != _signUpNextView.inputPswdAgain.text){
        [self showAlertActionWithTitle:@"输入密码不一致"];
        return;
    }
    //输入成功之后注册
    NOVSignModel *signupModel = [[NOVSignModel alloc] init];
    [signupModel signUpWithAccount:_account username:_signUpNextView.usernameTextField.text passward:_signUpNextView.passwardTextField.text success:^(id  _Nullable responseObject) {
        if ([[NSString stringWithFormat:@"%@", responseObject[@"status"]] isEqualToString:@"0"]) {
            //0 注册成功返回登录界面
            [self showAlertActionWithTitle:@"注册成功，请登录！"];
            
        }
    } failure:^(NSError * _Nonnull error) {
    }];
    ViewController *viewController = [[ViewController alloc] init];
    viewController.signView.accountTextField.text = _account;
    [self.navigationController pushViewController:viewController animated:NO];
}

-(void)quit{
    ViewController *viewController = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:NO];
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
    [_signUpNextView.usernameTextField resignFirstResponder];
    [_signUpNextView.passwardTextField resignFirstResponder];
    [_signUpNextView.inputPswdAgain resignFirstResponder];
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
