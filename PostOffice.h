//
//  PostOffice.h
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface PostOffice : NSObject <MKAnnotation>

@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

@property (nonatomic,copy) NSString *name;

- (instancetype)initWithInfo:(NSDictionary *)info;

@end
