//
//  MyIQViewController.m
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "MyIQViewController.h"

@import StoreKit;

@interface MyIQViewController () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *iqValueField;

@property (nonatomic, strong) SKProduct *product;
@property (nonatomic, strong) SKProductsRequest *productRequest;
@property (nonatomic, strong) SKPayment *payment;

@end

@implementation MyIQViewController

#pragma mark - View Life Cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup -

- (void)setup
{
    self.iqValueField.enabled = NO;
    [self updateIQFromUI];
}

- (void)updateIQFromUI
{
    NSString *iqValue = self.iqValueField.text;
    
    [self setBadgesValue:iqValue.integerValue];
}

#pragma mark - UI Events

- (IBAction)setIQPressed:(id)sender
{
    [self updateIQFromUI];
}

- (IBAction)unlockIQPressed:(UIButton *)sender
{
    [self unlockIQSetter];
}

- (void)setBadgesValue:(NSInteger)value
{
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = value;
}

#pragma mark - Purchases

- (void)unlockIQSetter
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if ([SKPaymentQueue canMakePayments]){
        SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:@"com.ias.inAppPurchaseExample.Purchase"]];
        request.delegate = self;
        self.productRequest = request;
        [request start];
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    
    self.product = [products firstObject];
    
    if (self.product){
        SKPayment *payment = [SKPayment paymentWithProduct:self.product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        self.payment = payment;
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
            case SKPaymentTransactionStateRestored:
                [self unlockFeature];
                [[SKPaymentQueue defaultQueue]
                 finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue]
                 finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

- (void)unlockFeature
{
    self.iqValueField.enabled = YES;
}

@end


















