//
//  LaunchOtherAppViewController.m
//  
//
//  Created by Nikolay Shubenkov on 11/07/15.
//
//

#import "LaunchOtherAppViewController.h"

#import "MBProgressHUD.h"

@interface LaunchOtherAppViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberfield;

@end

@implementation LaunchOtherAppViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phoneNumberfield.placeholder = @"Введите номер телефона";
}

- (IBAction)callToSomebodyPressed:(id)sender
{
    NSLog(@"Call button pressed");
    
    NSString *phoneNumber = self.phoneNumberfield.text;
    
    NSString *url = [NSString stringWithFormat:@"skype://%@",phoneNumber];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}



- (IBAction)showCalculatingProcess:(UIButton *)sender
{
    [self showCalculatingSomething];
    
    [self performSelector:@selector(calculationFinished)
               withObject:self
               afterDelay:4];
}

- (void)showCalculatingSomething
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)calculationFinished
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end






















