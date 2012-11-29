//
//  Engine.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-29.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "Engine.h"
#import "AppNetAFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation Engine

AppNetAFHTTPClient *_client;

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
        _client = [[AppNetAFHTTPClient alloc] init];
        [_client registerHTTPOperationClass:[AFJSONRequestOperation class]];
	}
    
	return self;
}

-(void) getPostsWithCompletion:(void (^)(NSError *, NSArray *))completionHandler
{
    [_client getPath:@"posts.json"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSArray *objects;
                 NSLog(@"Success");
                 
                 // Construct model objects from the parsed JSON in responseObject
                 // ...
                 
                 if (completionHandler) {
                     completionHandler(nil, objects);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (completionHandler) {
                     NSLog(@"Failure");
                     completionHandler(error, nil);
                 }
             }
     ];
}

@end
