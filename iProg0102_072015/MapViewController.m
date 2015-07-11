//
//  MapViewController.m
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "MapViewController.h"

@import CoreLocation;

#import "OfficesLoader.h"

#import "PostOffice.h"


@import MapKit;

@interface MapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong) OfficesLoader *dataLoader;

@property (nonatomic, strong) NSArray *offices;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *manager;

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
    
    self.manager = [[CLLocationManager alloc]init];
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.delegate = self;;
    
    [self.manager requestAlwaysAuthorization];    
    [self.manager startUpdatingLocation];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
}
- (IBAction)showUser:(id)sender
{
    self.mapView.showsUserLocation = YES;
    [self.mapView setCenterCoordinate:[self coordinateToSearch] animated:YES];
}

- (CLLocationCoordinate2D)coordinateToSearch
{
    if (self.mapView.userLocation){
        return self.mapView.userLocation.coordinate;
    }
    else {
        return self.mapView.centerCoordinate;
    }
}

- (IBAction)showOffices:(id)sender
{
    [self.dataLoader getofficesOfCount:50
                            inLatitude:[self coordinateToSearch].latitude
                             longitude:[self coordinateToSearch].longitude
          complition:^(id data, BOOL success) {
        
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
    [self.mapView showAnnotations:self.mapView.annotations
                         animated:YES];
}

#pragma mark - MkMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[PostOffice class]]){
        return nil;
    }
    
    static NSString *identifier = @"PostOfficeIdentifier";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView){
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation
                                                     reuseIdentifier:identifier];
    }
    else {
        annotationView.annotation = annotation;
    }
    annotationView.image = [UIImage imageNamed:@"office"];
    NSParameterAssert(annotationView.image);
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0)
{
    
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(10_9, 4_0)
{
    
}



@end
