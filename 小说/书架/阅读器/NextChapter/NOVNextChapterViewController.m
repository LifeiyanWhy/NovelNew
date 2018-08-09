//
//  NOVNextChapterViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNextChapterViewController.h"
#import "NOVNextChapterView.h"
@interface NOVNextChapterViewController ()
@property(nonatomic,strong) NOVNextChapterView *nextChapterView;
@end

@implementation NOVNextChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookBackground.png"]];
    [self.view addSubview:self.nextChapterView];
    
}

-(NOVNextChapterView *)nextChapterView{
    if (!_nextChapterView) {
        _nextChapterView = [[NOVNextChapterView alloc] initWithFrame:self.view.frame];        
    }
    return _nextChapterView;
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
