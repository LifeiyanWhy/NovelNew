//
//  NOVSignUpViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVRegisterNextStepViewController.h"
#import "NOVRegisterNextStepView.h"
#import "ViewController.h"
#import "NOVSigninView.h"
#import "NOVSignModel.h"

@interface NOVRegisterNextStepViewController ()<UITextFieldDelegate>
@end

@implementation NOVRegisterNextStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.registerNextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//键盘位置
    CGRect selfViewFrame = self.view.frame;
    CGFloat inputBottom = self.registerNextView.registerButton.frame.origin.y + self.registerNextView.registerButton.frame.size.height;
    if (inputBottom + 5 > frame.origin.y) {
        CGFloat distance = inputBottom + 5 - frame.origin.y;
        self.registerNextView.frame = CGRectMake(selfViewFrame.origin.x, selfViewFrame.origin.y - distance, selfViewFrame.size.width, selfViewFrame.size.height);
    }
}
- (void)keyboardHidden:(NSNotification *)notification{
    self.registerNextView.frame = self.view.frame;
}

-(NOVRegisterNextStepView *)registerNextView{
    if (!_registerNextView) {
        _registerNextView = [[NOVRegisterNextStepView alloc] initWithFrame:self.view.frame];
        _registerNextView.usernameTextField.delegate = self;
        _registerNextView.passwardTextField.delegate = self;
        _registerNextView.inputPswdAgain.delegate = self;
        [_registerNextView.registerButton addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
        [_registerNextView.quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerNextView;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *username;
    NSString *passward;
    NSString *passwardAgain;
    if ([textField isEqual:self.registerNextView.usernameTextField]) {
        username = text;
        passward = self.registerNextView.passwardTextField.text;
        passwardAgain = self.registerNextView.inputPswdAgain.text;
    }else if ([textField isEqual:self.registerNextView.passwardTextField]){
        username = self.registerNextView.usernameTextField.text;
        passward = text;
        passwardAgain = self.registerNextView.inputPswdAgain.text;
    }else{
        username = self.registerNextView.usernameTextField.text;
        passward = self.registerNextView.passwardTextField.text;
        passwardAgain = text;
    }
    
    if (username.length > 0 && username.length <= 20 && passward.length >= 6 && passward.length <= 20 && passwardAgain.length >= 6 && passwardAgain.length <= 20) {
        self.registerNextView.registerButton.backgroundColor = SystemColor;
        self.registerNextView.registerButton.userInteractionEnabled = YES;
    }else{
        self.registerNextView.registerButton.backgroundColor = [UIColor colorWithRed:0.92f green:0.65f blue:0.60f alpha:1.00f];
        self.registerNextView.registerButton.userInteractionEnabled = NO;
    }
    return YES;
}

-(void)doRegister{
    //输入成功之后注册
    [NOVSignModel signUpWithAccount:_account username:_registerNextView.usernameTextField.text passward:_registerNextView.passwardTextField.text key:self.key success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self showAlertActionWithTitle:@"恭喜您,注册成功!" leftMessage:@"重新登录" rightMessage:@"直接进入"];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)quit{
    ViewController *viewController = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (void)showAlertActionWithTitle:(NSString *)title leftMessage:(NSString *)leftMessage rightMessage:(NSString *)rightMessage{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertLeft = [UIAlertAction actionWithTitle:leftMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //重新登录(跳转回登录界面)
        ViewController *viewController = [[ViewController alloc] init];
        viewController.account = _account;
        viewController.passward = _registerNextView.passwardTextField.text;
        [self.navigationController pushViewController:viewController animated:NO];
    }];
    [alertControl addAction:alertLeft];
    UIAlertAction *alertRight = [UIAlertAction actionWithTitle:rightMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         //直接登录
        [[NSNotificationCenter defaultCenter] postNotificationName:@"signinSucceed" object:nil];
    }];
    [alertControl addAction:alertRight];
    [self presentViewController:alertControl animated:YES completion:nil];
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
