//
//  OfficesLoader.m
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "OfficesLoader.h"

#import "PostOffice.h"

@implementation OfficesLoader

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"http://95.128.178.180:5432"]];
    if (self){
        self.responseSerializer = [AFJSONResponseSerializer new];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"application/json"
                                                                               ]];
    }
    return self;
}

- (void)getofficesOfCount:(int)count inLatitude:(double)latitude longitude:(double)longitude complition:(OfficeLoaderCopmlition)complition
{
    OfficeLoaderCopmlition copiedComplitiod = [complition copy];
    
    NSMutableDictionary *parameters = [self p_defaultParameters];
    
    int top                = count;//max offices count
    int radius             = 5000;
    NSString *type = @"ALL";
    [parameters addEntriesFromDictionary:@{
                                           @"top"              :@(top),
                                           @"latitude"         :@(latitude),
                                           @"longitude"        :@(longitude),
                                           @"searchRadius"     :@(radius),
                                           @"type"             :type
                                           }];
    
    [self GET:@"mobile-api/method/offices.find.nearby"
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
          NSArray *parsedOffices = [self updateOffices:responseObject];
          copiedComplitiod(parsedOffices,YES);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          copiedComplitiod(error,NO);
      }];
}

- (void)getofficesOfCount:(int)count complition:(OfficeLoaderCopmlition)complition
{
    [self getofficesOfCount:count
                 inLatitude:55.7522200
                  longitude:37.6155600 complition:complition];
}

- (NSArray *)updateOffices:(NSArray *)officesInfo
{
    NSMutableArray *offices = [NSMutableArray new];
    for (NSDictionary *anOfficeInfo in officesInfo){
        [offices addObject:[[PostOffice alloc]initWithInfo:anOfficeInfo]];
    }
    return [offices copy];
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    [request setValue:@"Accept"
   forHTTPHeaderField:@"application/json; charset=utf-8"];
    
    [request setValue:@"RussianPost/2.1"
   forHTTPHeaderField:@"User-Agent"];
    
    //  как хорошо, когда апи почты говорит в чем проблема
    //{"code":"1005","desc":"Request is not authorized: Access token was either missing or invalid."}
    [request setValue:@"Yi5GaWMTY8x27uEPte0/l9vfrZw="
   forHTTPHeaderField:@"MobileApiAccessToken"];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (NSMutableDictionary *)p_defaultParameters
{
    NSDateFormatter *formatter1 = [NSDateFormatter new];
    formatter1.dateFormat = @"yyyy-MM-dd";
    NSDateFormatter *formatter2 = [NSDateFormatter new];
    formatter2.dateFormat = @"HH:mm:ss";
    NSString *yearMonthday = [formatter1 stringFromDate:[NSDate date]];
    NSString *hourMoniteSecond = [formatter2 stringFromDate:[NSDate date]];
    
    NSString *time = [NSString stringWithFormat:@"%@T%@",yearMonthday,hourMoniteSecond];
    return [@{
              @"currentDateTime"  :time,
              } mutableCopy];
}

@end
