//
//  AppNetAFHTTPClient.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-28.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "AppNetAFHTTPClient.h"

@implementation AppNetAFHTTPClient

-(id)init {
	self = [super initWithBaseURL:[NSURL URLWithString:@"https://alpha-api.app.net/stream/0/posts/stream/global"]];
	if (self != nil) {
	}
    
	return self;
}


@end
