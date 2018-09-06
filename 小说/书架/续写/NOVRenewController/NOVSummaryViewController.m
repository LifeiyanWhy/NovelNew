//
//  NOVSummaryViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/9/6.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSummaryViewController.h"
#import "NOVSummaryView.h"
@interface NOVSummaryViewController ()<UITextViewDelegate>
@property(nonatomic,strong) NOVSummaryView *summaryView;
@end

@implementation NOVSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回read.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.title = @"编辑简介";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:self.summaryView];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:_summaryView.placeholder] && textView.textColor == [UIColor grayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text  isEqual:@""]) {
        textView.text = _summaryView.placeholder;
        textView.textColor = [UIColor grayColor];
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    _summaryView.wordNumberLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)textView.text.length];
    if (![_summaryView.textView.text  isEqual: @""]) {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    }
    if (textView.text.length > 100) {
        _summaryView.wordNumberLabel.textColor = [UIColor orangeColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    }else if(textView.text.length == 0){
        _summaryView.wordNumberLabel.textColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    }else{
        _summaryView.wordNumberLabel.textColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }
}

-(NOVSummaryView *)summaryView{
    if (!_summaryView) {
        _summaryView = [[NOVSummaryView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        _summaryView.textView.delegate = self;
    }
    return _summaryView;
}

-(void)back{
    [self.navigationController  popViewControllerAnimated:NO];
}

-(void)save{
    if (CGColorEqualToColor(self.navigationItem.rightBarButtonItem.tintColor.CGColor,[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00].CGColor)) {
        return;
    }
    self.summaryblock(_summaryView.textView.text);
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
