//
//  OfficesLoader.h
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef void(^OfficeLoaderCopmlition)(id data, BOOL success);

@interface OfficesLoader : AFHTTPRequestOperationManager

- (void)getofficesOfCount:(int)count complition:(OfficeLoaderCopmlition)complition;

@end
