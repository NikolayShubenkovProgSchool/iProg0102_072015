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

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic,strong) OfficesLoader *dataLoader;

@property (nonatomic, strong) NSArray *offices;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

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
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

- (IBAction)showOffices:(id)sender
{
    [self.dataLoader getofficesOfCount:50 complition:^(id data, BOOL success) {
        
        if (success){
            NSLog(@"recieved data: %@",data);
            self.offices = data;
            [self showOfficesOnMapView:self.offices];
        }
        else {
            NSLog(@"Error: %@",data);
        }
    }];
}

#pragma mark - Map

- (void)showOfficesOnMapView:(NSArray *)offices
{
    [self.mapView addAnnotations:offices];
    [self.mapView showAnnotations:offices animated:YES];
}



@end
