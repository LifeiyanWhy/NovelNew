//
//  NOVSecurityCenterViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSecurityCenterViewController.h"
#import "NOVSecurityCenterView.h"
#import "NOVPersonalMessage.h"
@interface NOVSecurityCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NOVSecurityCenterView *securityCenterView;
@property(nonatomic,strong) NOVUserMessage *userMessage;
@end

@implementation NOVSecurityCenterViewController{
    NSArray *cellLeftModel;
    NSArray *cellModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"安全中心";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = SystemColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    _userMessage = [NOVDataModel getUserMessage];
    cellLeftModel = @[@[@"用户名",@"手机号"],@[@"修改密码"],@[@"安全中心"]];
    NSString *account = [_userMessage.simpleUserMessage.account stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
    cellModelArray = @[_userMessage.simpleUserMessage.username,account];
    [self.view addSubview:self.securityCenterView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = cellLeftModel[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        }
        cell.detailTextLabel.text = cellModelArray[indexPath.row];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(NOVSecurityCenterView *)securityCenterView{
    if (!_securityCenterView) {
        _securityCenterView = [[NOVSecurityCenterView alloc] initWithFrame:self.view.frame];
        _securityCenterView.tableView.delegate = self;
        _securityCenterView.tableView.dataSource = self;
    }
    return _securityCenterView;
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
