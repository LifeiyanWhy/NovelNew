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
#import "NOVRegisterViewController.h"
#import "NOVDataModel.h"
#import "NOVUserLoginMessageModel.h"
#import "ViewController+keyboardChange.h"

@interface ViewController ()<UITextFieldDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.signView];
    
    NOVUserLoginMessageModel *model = [NOVDataModel getLastUserMessage];
    if (model) {
        if (model.isLogin) {//当前用户是登录状态（最近一次登录的用户）
            [NOVSignModel token];
            //开始更新token
            [NOVSignModel updateToken];
            [self loginSucceed];
            return;
        }else{
            //不是登录状态，重新登录
            _signView.accountTextField.text = model.account;
            if (model.password) {
                _signView.passwardTextField.text = model.password;
            }
        }
    }
    [self getVerity];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)getVerity{
    NOVSignModel *model = [[NOVSignModel alloc] init];
    [model getImageVeritysuccess:^(id  _Nullable responseObject) {
        [_signView.verityButton setImage:[UIImage imageWithData:responseObject] forState:UIControlStateNormal];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)login{
    NOVSignModel *loginModel = [[NOVSignModel alloc] init];
    [loginModel loginWithAccount:_signView.accountTextField.text  password:_signView.passwardTextField.text verity:_signView.verityTextField.text success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self loginSucceed];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"登录失败===%@",error);
        if (error.code == -1009 || error.code == 1005 || error.code == 1001) {
            [self showAlertActionWithTitle:@"网络不可用,请重试！"];
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            //status为1代表登录失败，账号或密码错误。
        if ([[NSString stringWithFormat:@"%@",dict[@"status"]] isEqualToString:@"1"]) {
            [self showAlertActionWithTitle:[NSString stringWithFormat:@"%@",dict[@"message"]]];
        }
        [self getVerity];
    }];
}

-(void)loginSucceed{
    //登录成功
    [[NSNotificationCenter defaultCenter] postNotificationName:@"signinSucceed" object:nil];
    [NOVSignModel obtainFollowList];//获取关注列表
    [NOVSignModel obtainCollectionList];
}

//点击注册button后进入注册页面（在登录界面点击注册时执行）
-(void)signUp{
    NOVRegisterViewController *registerViewcontroller = [[NOVRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewcontroller animated:NO];
}

-(NOVSigninView *)signView{
    if (!_signView) {
        _signView = [[NOVSigninView alloc] initWithFrame:self.view.frame];
        _signView.accountTextField.delegate = self;
        _signView.passwardTextField.delegate = self;
        _signView.verityTextField.delegate = self;
        [_signView.signinButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [_signView.signupButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [_signView.verityButton addTarget:self action:@selector(getVerity) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%@",_account);
        NSLog(@"%@",_passward);
        if (_account && _passward) {
            _signView.accountTextField.text = _account;
            _signView.passwardTextField.text = _passward;
        }
    }
    return _signView;
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
