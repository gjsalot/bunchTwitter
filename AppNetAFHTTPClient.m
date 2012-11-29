//
//  AppNetAFHTTPClient.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-28.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "AppNetAFHTTPClient.h"

@implementation AppNetAFHTTPClient

- (NSURL *) baseURL {
    NSURL *url = [[NSURL alloc] initWithString:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
    return url;
}

@end
