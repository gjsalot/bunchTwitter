//
//  AppNetAFHTTPClient.h
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-28.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AppNetAFHTTPClient : AFHTTPClient

@property (readonly, nonatomic) NSURL *baseURL;

@end
