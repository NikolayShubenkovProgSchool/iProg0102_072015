//
//  PostOffice.m
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PostOffice.h"

@implementation PostOffice

- (instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self){
        _name = info[@"addressSource"];
        _latitude  = [info[@"latitude"] doubleValue];
        _longitude = [info[@"longitude"] doubleValue];
        NSParameterAssert(_name.length >  0);
        NSParameterAssert(info[@"latitude"]);
        NSParameterAssert(info[@"longitude"]);
        
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate
{
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (NSString *)title
{
    return self.name;
}

@end
