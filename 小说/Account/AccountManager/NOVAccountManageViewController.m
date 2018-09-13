//
//  NOVManageViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVAccountManageViewController.h"
#import "NOVAccountManageView.h"
#import "NOVAccountManageCell.h"
#import "ViewController.h"
#import "NOVUserLoginMessageModel.h"
#import "NOVDataModel.h"
#import "MYViewController.h"
#import "AppDelegate.h"
@interface NOVAccountManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NOVAccountManageView *accountManageView;
@end

@implementation NOVAccountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账号管理";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = SystemColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self.view addSubview:self.accountManageView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self showAlertActionWithTitle:@"确认退出当前账号!"];
    }
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NOVUserLoginMessageModel *model = [NOVDataModel getLastUserMessage];
        model.isLogin = NO;
        [NOVDataModel updateCurrentUserWithLoginMessage:model];
        ViewController *loginController = [[ViewController alloc] init];
        loginController.account = model.account;
        loginController.passward = model.password;
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:NO];
        
        AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        myAppDelegate.window.rootViewController = loginController;
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:sureAction];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"退出当前账号";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    NOVAccountManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.row == 1){
        cell.myImageView.image = [UIImage imageNamed:@"添加账号.png"];
        cell.nameLabel.text = @"添加账号";
    }else{
        cell.myImageView.image = [UIImage imageNamed:@"cellimage.jpg"];
        cell.nameLabel.text = @"李飞艳";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ScreenHeight*0.1;
    }
    return ScreenHeight*0.08;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

-(NOVAccountManageView *)accountManageView{
    if (!_accountManageView) {
        _accountManageView = [[NOVAccountManageView alloc] initWithFrame:self.view.frame];
        _accountManageView.tableView.delegate = self;
        _accountManageView.tableView.dataSource = self;
        [_accountManageView.tableView registerClass:[NOVAccountManageCell class] forCellReuseIdentifier:@"cell"];
    }
    return _accountManageView;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
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
