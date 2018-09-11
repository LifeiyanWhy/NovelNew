//
//  ViewController+keyboardChange.m
//  小说
//
//  Created by 李飞艳 on 2018/9/11.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "ViewController+keyboardChange.h"
#import "NOVSigninView.h"

@implementation ViewController (keyboardChange)
- (void)keyboardShow:(NSNotification *)notification{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//键盘位置
    CGRect selfViewFrame = self.view.frame;
    NSLog(@"%f",self.signView.verityButton.frame.origin.y);
    CGFloat inputBottom = self.signView.signinButton.frame.origin.y + self.signView.verityButton.frame.size.height;
    if (inputBottom + 5 > frame.origin.y) {
        CGFloat distance = inputBottom + 5 - frame.origin.y;
        self.signView.frame = CGRectMake(selfViewFrame.origin.x, selfViewFrame.origin.y - distance, selfViewFrame.size.width, selfViewFrame.size.height);
    }
}
- (void)keyboardHidden:(NSNotification *)notification{
    self.signView.frame = self.view.frame;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *account;
    NSString *passward;
    NSString *verity;
    if ([textField isEqual:self.signView.accountTextField]) {
        account = text;
        passward = self.signView.passwardTextField.text;
        verity = self.signView.verityTextField.text;
    }else if ([textField isEqual:self.signView.passwardTextField]){
        account = self.signView.accountTextField.text;
        passward = text;
        verity = self.signView.verityTextField.text;
    }else{
        account = self.signView.accountTextField.text;
        passward = self.signView.passwardTextField.text;
        verity = text;
    }
    
    if (account.length > 0 && passward.length > 0 && verity.length > 0) {
        self.signView.signinButton.backgroundColor = SystemColor;
        self.signView.signinButton.userInteractionEnabled = YES;
    }else{
        self.signView.signinButton.backgroundColor = [UIColor colorWithRed:0.92f green:0.65f blue:0.60f alpha:1.00f];
        self.signView.signinButton.userInteractionEnabled = NO;
    }
    return YES;
}
@end
