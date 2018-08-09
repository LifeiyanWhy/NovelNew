//
//  NOVSetViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVUserSetViewController.h"
#import "NOVUserSetView.h"
#import "NOVEditUserMessageViewController.h"
#import "NOVSecurityCenterViewController.h"
#import "NOVAccountManageViewController.h"

@interface NOVUserSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NOVUserSetView *userSetView;
@end

@implementation NOVUserSetViewController{
    NSArray *cellModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
                                            @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                              NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = SystemColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    cellModelArray = @[@[@"个人资料"],@[@"账号管理",@"账号与安全"],@[@"夜间模式"],@[@"退出"]];
    [self.view addSubview:self.userSetView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NOVEditUserMessageViewController *editUserMessageViewController = [[NOVEditUserMessageViewController alloc] init];
        editUserMessageViewController.selfTitle = @"个人资料";
        [self.navigationController pushViewController:editUserMessageViewController animated:NO];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        NOVAccountManageViewController *accountManageController = [[NOVAccountManageViewController alloc] init];
        [self.navigationController pushViewController:accountManageController animated:NO];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        NOVSecurityCenterViewController *securityCenterViewController = [[NOVSecurityCenterViewController alloc] init];
        [self.navigationController pushViewController:securityCenterViewController animated:NO];
    }else{
        exit(0);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = cellModelArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0 || indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    if (indexPath.section == 2) {
        cell.accessoryView = _userSetView.lightSwitch;
    }
    
    if (indexPath.section == 3) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(NOVUserSetView *)userSetView{
    if (!_userSetView) {
        _userSetView = [[NOVUserSetView alloc] initWithFrame:self.view.frame];
        _userSetView.tableView.delegate = self;
        _userSetView.tableView.dataSource = self;
        [_userSetView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _userSetView;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
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
