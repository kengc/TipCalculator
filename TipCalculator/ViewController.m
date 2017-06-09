//
//  ViewController.m
//  TipCalculator
//
//  Created by Kevin Cleathero on 2017-06-09.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrameNotificationHandler:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardDidChangeFrameNotificationHandler:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSLog(@"Keyboard changed frame!!");
    //     NSLog(@"UserInfo: %@", userInfo);
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    NSLog(@"Height: %f", keyboardHeight);
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //double offset += keyboardHeight + offset;
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = keyboardHeight;
        
        CGFloat originalX = self.scrollView.contentOffset.x;
        CGFloat newY = (keyboardHeight / 2);
        
        CGPoint offset = CGPointMake(originalX, newY);
        
        [self.scrollView setContentOffset:offset animated:YES];
        self.scrollView.contentInset = insets;
        self.scrollView.scrollIndicatorInsets = insets;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    
    //Have the calculateTip method work out what a 15% tip would be
    
    NSInteger billAmt = [self.billAmountTextField.text integerValue];
    
    NSInteger taxAmt = [self.tipPercentageTextField.text integerValue];
    double rate = (taxAmt / 100.00);
    
    double tipAmt = billAmt * rate;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%ld", (long)tipAmt];
}



- (IBAction)adjustTipPercentage:(UISlider *)sender {
    
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%0.f", sender.value];
    
     NSInteger billAmt = [self.billAmountTextField.text integerValue];
    NSInteger taxAmt = [self.tipPercentageTextField.text integerValue];
    double rate = (taxAmt / 100.00);
    
    double tipAmt = billAmt * rate;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%ld", (long)tipAmt];
}


@end
