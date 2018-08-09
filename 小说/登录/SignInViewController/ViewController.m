//
//  ViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "ViewController.h"
#import "NOVSigninView.h"
#import "NOVSignModel.h"
#import "NOVSignUpViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.signView];
  
    [self getVerity];
}

-(void)getVerity{
    NOVSignModel *model = [[NOVSignModel alloc] init];
    [model getVeritysuccess:^(id  _Nullable responseObject) {
        [_signView.verityButton setImage:[UIImage imageWithData:responseObject] forState:UIControlStateNormal];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)login{
    if (_signView.accountTextField.text.length <= 0 || _signView.passwardTextField.text.length <= 0) {
        [self showAlertActionWithTitle:@"账号密码不能为空"];
        return;
    }
    if (_signView.verityTextField.text.length <= 0) {
        [self showAlertActionWithTitle:@"请输入验证码!!!"];
        return;
    }
    NOVSignModel *loginModel = [[NOVSignModel alloc] init];
    [loginModel loginWithAccount:_signView.accountTextField.text  password:_signView.passwardTextField.text verity:_signView.verityTextField.text success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //登录成功
        [[NSNotificationCenter defaultCenter] postNotificationName:@"signinSucceed" object:nil];
        [loginModel obtainFollowList];//获取关注列表
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"登录失败===%@",error);
        if (error.code == -1009) {
            [self showAlertActionWithTitle:@"网络不可用,请重试！"];
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            //status为1代表登录失败，账号或密码错误。
        if ([[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
            [self showAlertActionWithTitle:[NSString stringWithFormat:@"%@!!!",dict[@"message"]]];
        }
    }];
}

//点击注册button后进入注册页面（在登录界面点击注册时执行）
-(void)signUp{
    NOVSignUpViewController *signUpViewController = [[NOVSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpViewController animated:NO];
}

-(NOVSigninView *)signView{
    if (!_signView) {
        _signView = [[NOVSigninView alloc] initWithFrame:self.view.frame];
        _signView.accountTextField.delegate = self;
        _signView.passwardTextField.delegate = self;
        [_signView.signinButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [_signView.signupButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [_signView.verityButton addTarget:self action:@selector(getVerity) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signView;
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *messageAlert = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:messageAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_signView.accountTextField resignFirstResponder];
    [_signView.passwardTextField resignFirstResponder];
    [_signView.verityTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
