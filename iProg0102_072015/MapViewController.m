//
//  MapViewController.m
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "MapViewController.h"

#import "OfficesLoader.h"

@import MapKit;

@interface MapViewController ()

@property (nonatomic,strong) OfficesLoader *dataLoader;

@end

@implementation MapViewController

- (OfficesLoader *)dataLoader
{
    if (!_dataLoader){
        _dataLoader = [OfficesLoader new];
    }
    return _dataLoader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showOffices:(id)sender
{
    
    [self.dataLoader getofficesOfCount:50 complition:^(id data, BOOL success) {
        
        if (success){
            NSLog(@"recieved data: %@",data);
        }
        else {
            NSLog(@"Error: %@",data);
        }
    }];
}

@end
