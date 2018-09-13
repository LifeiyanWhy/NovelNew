//
//  NOVRegisterViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVRegisterViewController.h"
#import "NOVRegisterView.h"
#import "NOVSignModel.h"
#import "NOVRegisterNextStepViewController.h"
@interface NOVRegisterViewController ()<UITextFieldDelegate>
@end

@implementation NOVRegisterViewController{
    NSInteger time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.registerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//键盘位置
    CGRect selfViewFrame = self.view.frame;
    CGFloat inputBottom = self.registerView.nextStepButton.frame.origin.y + self.registerView.nextStepButton.frame.size.height;
    if (inputBottom + 5 > frame.origin.y) {
        CGFloat distance = inputBottom + 5 - frame.origin.y;
        self.registerView.frame = CGRectMake(selfViewFrame.origin.x, selfViewFrame.origin.y - distance, selfViewFrame.size.width, selfViewFrame.size.height);
    }
}
- (void)keyboardHidden:(NSNotification *)notification{
    self.registerView.frame = self.view.frame;
}

-(NOVRegisterView *)registerView{
    if (!_registerView) {
        _registerView = [[NOVRegisterView alloc] initWithFrame:self.view.frame];
        _registerView.accountTextField.delegate = self;
        _registerView.verifyTextfield.delegate = self;
        [self.view addSubview:_registerView];
        [_registerView.verifyeButton addTarget:self action:@selector(obtainVerify) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.nextStepButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.quit addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerView;
}

-(void)obtainVerify{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if (!([pred evaluateWithObject:_registerView.accountTextField.text] && _registerView.accountTextField.text.length == 11)) {
        [self showAlertActionWithTitle:@"手机号格式错误"];
        return;
    }
    NOVSignModel *model = [[NOVSignModel alloc] init];
    //获取验证码
    [model getPhoneVerityWithPhoneNum:_registerView.accountTextField.text success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        [_registerView.verifyeButton setTitle:@"60s后重发" forState:UIControlStateNormal];
        time = 60;
        _registerView.verifyeButton.userInteractionEnabled = NO;
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(verityTime:) userInfo:nil repeats:YES];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self showAlertActionWithTitle:@"该手机号已经注册过"];
//        [self showAlertActionWithTitle:@"手机号不存在"];
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *accountText;
    NSString *verity;
    if ([textField isEqual:_registerView.accountTextField]) {
        accountText = text;
        verity = _registerView.verifyTextfield.text;
    } else {
        accountText = _registerView.accountTextField.text;
        verity = text;
    }
    
    if (verity.length == 6 && [pred evaluateWithObject:accountText] && accountText.length == 11) {
        _registerView.nextStepButton.backgroundColor = SystemColor;
        _registerView.nextStepButton.userInteractionEnabled = YES;
    }else{
        _registerView.nextStepButton.backgroundColor = [UIColor colorWithRed:0.92f green:0.65f blue:0.60f alpha:1.00f];;
        _registerView.nextStepButton.userInteractionEnabled = NO;
    }
    return YES;
}

-(void)verityTime:(NSTimer *)timer{
    time--;
    [_registerView.verifyeButton setTitle:[NSString stringWithFormat:@"%lds后重发",(long)time] forState:UIControlStateNormal];
    if (time == 0) {
        [timer invalidate];
        [_registerView.verifyeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _registerView.verifyeButton.userInteractionEnabled = YES;
    }
}

-(void)nextStep{
    //检测验证码是否正确
    [NOVSignModel validateVerityWithPhoneNumber:_registerView.accountTextField.text validateCode:_registerView.verifyTextfield.text success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"message"]);
        NOVRegisterNextStepViewController *registerViewController = [[NOVRegisterNextStepViewController alloc] init];
        registerViewController.verityCode = _registerView.verifyTextfield.text;
        registerViewController.account = _registerView.accountTextField.text;
        registerViewController.key = responseObject[@"message"];
        [self.navigationController pushViewController:registerViewController animated:NO];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)quit{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
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
