//
//  Engine.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-29.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "Engine.h"
#import "AppNetAFHTTPClient.h"
#import "Status.h"
#import "AFJSONRequestOperation.h"

@implementation Engine

AppNetAFHTTPClient *_client;
//AFHTTPClient *_client;

-(id)init {
	self = [super init];
	if (self != nil) {
        _client = [[AppNetAFHTTPClient alloc] init];
        [_client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [_client setDefaultHeader:@"Accept" value:@"application/json"];
	}
    
    
	return self;
}

-(void) getStatusesWithCompletion:(void (^)(NSError *, NSArray *))completionHandler
{
    [_client getPath:@""
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSArray *data = [responseObject valueForKeyPath:@"data"];
                 
                 NSArray *statuses = [[NSArray alloc] init];
                 
                 for (int i = 0; i < [data count]; i++)
                 {
                     Status *status = [[Status alloc] init];
                     [status updateWithDictionary:[data objectAtIndex:i]];
                     statuses = [statuses arrayByAddingObject:status];
                 }
                 
                 if (completionHandler) {
                     completionHandler(nil, statuses);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (completionHandler) {
                     completionHandler(error, nil);
                 }
             }
     ];
}

@end
