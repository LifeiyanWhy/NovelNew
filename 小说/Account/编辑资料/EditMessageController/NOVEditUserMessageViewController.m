//
//  NOVEditUserMessageViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/7/25.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditUserMessageViewController.h"
#import "NOVEditUserMessageView.h"
#import "NOVUserMessageTableViewCell.h"
#import "NOVSignModel.h"
#import "NOVPersonalMessage.h"
#import "NOVEditSignViewController.h"

@interface NOVEditUserMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NOVEditUserMessageView *editMessageView;
@end

@implementation NOVEditUserMessageViewController{
    NSArray *cellModelArray;
    NSArray *defaultMessage;
    NSMutableArray *simpleUserMessageArray;
    NSMutableArray *personalMessageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = SystemColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回white.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.title = _selfTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    _editMessageView = [[NOVEditUserMessageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_editMessageView];
    _editMessageView.tableView.delegate = self;
    _editMessageView.tableView.dataSource = self;
    _editMessageView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_editMessageView.tableView registerClass:[NOVUserMessageTableViewCell class] forCellReuseIdentifier:@"userMessageCell"];
    
    cellModelArray = @[@[@"用户名",@"简介",@"等级",@"经验值"],@[@"性别",@"所在地",@"学校",@"公司"]];
    defaultMessage = @[@"填写",@"填写",@"填写你的学校，发现校友",@"填写你的公司，发现同事"];
    
    //展示编辑前的用户信息;
    simpleUserMessageArray = [NSMutableArray arrayWithArray:@[self.userMessage.simpleUserMessage.username,self.userMessage.userMessage.signText,[NSString stringWithFormat:@"Lv %@",self.userMessage.userMessage.userGrade],self.userMessage.userMessage.experience]];
    if ([_userMessage.userMessage.signText  isEqual: @""]) {
        [simpleUserMessageArray replaceObjectAtIndex:1 withObject:@"一句话介绍自己"];
    }
}

-(NOVUserMessage *)userMessage{
    if (!_userMessage) {
        _userMessage = [NOVDataModel getUserMessage];
    }
    return _userMessage;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"userMessageCell";
    NOVUserMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.leftLabel.text = cellModelArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && simpleUserMessageArray.count) {
        cell.rightLabel.text = [NSString stringWithFormat:@"%@",simpleUserMessageArray[indexPath.row]];
    }
    if (indexPath.section == 1) {
        cell.rightLabel.text = defaultMessage[indexPath.row];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height*0.06;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        NOVEditSignViewController *editSignViewController = [[NOVEditSignViewController alloc] init];
        NOVUserMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        __block NOVEditUserMessageViewController *weakSelf = self;
        editSignViewController.textsignBlock = ^(NSString *textSign) {
            cell.rightLabel.text = textSign;
            //更新修改后的签名
            weakSelf.userMessage.userMessage.signText = textSign;
        };
        [self.navigationController pushViewController:editSignViewController animated:NO];
    }
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)save{
    //修改本地存储的用户信息
    [NOVDataModel updateUserMessage:_userMessage];
    //编辑后的个人资料 _userMessage
    self.userMessageBlock(_userMessage);
    NSLog(@"===%@",_userMessage.userMessage.signText);
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
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
