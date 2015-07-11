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
    
    if ([self contactEntered]){
    
        NSString *url = [NSString stringWithFormat:@"skype://%@",phoneNumber];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    else {
        [self askToEnterContactName];
    }
}

- (BOOL)contactEntered
{
    return self.phoneNumberfield.text.length > 3;
}

- (void)askToEnterContactName
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Упс!"
                                                   message:@"Введите, пожалуйста имя контакта"
                                                  delegate:nil
                                         cancelButtonTitle:@"Ok (" otherButtonTitles:@"Не хочу",@"Да, сэр", nil];
    [alert show];
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






















