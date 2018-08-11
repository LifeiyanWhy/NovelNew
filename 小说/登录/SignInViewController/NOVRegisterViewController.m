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
    if (_registerView.accountTextField.text.length != 11) {
        [self showAlertActionWithTitle:@"手机号为十一位数字"];
        return;
    }
    NOVSignModel *model = [[NOVSignModel alloc] init];
    [model getPhoneVerityWithPhoneNum:_registerView.accountTextField.text success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [_registerView.verifyeButton setTitle:@"60s后重发" forState:UIControlStateNormal];
        time = 60;
        _registerView.verifyeButton.userInteractionEnabled = NO;
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(verityTime:) userInfo:nil repeats:YES];
    } failure:^(NSError * _Nonnull error) {
        [self showAlertActionWithTitle:@"发送失败，请检查手机号"];
        NSLog(@"%@",error);
        NSString *string = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        NSLog(@"注册:%@",string);
    }];
}

-(void)verityTime:(NSTimer *)timer{
    time--;
    [_registerView.verifyeButton setTitle:[NSString stringWithFormat:@"%lds后重新发送",(long)time] forState:UIControlStateNormal];
    if (time == 0) {
        [timer invalidate];
        [_registerView.verifyeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _registerView.verifyeButton.userInteractionEnabled = YES;
    }
}

-(void)nextStep{
    //检测验证码
    
    NOVRegisterNextStepViewController *registerViewController = [[NOVRegisterNextStepViewController alloc] init];
    registerViewController.verityCode = _registerView.verifyTextfield.text;
    registerViewController.account = _registerView.accountTextField.text;
    [self.navigationController pushViewController:registerViewController animated:NO];
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
