//
//  Status.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-12.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "Status.h"

@implementation Status

-(void)updateWithDictionary:(NSDictionary *)dict
{
    self.statusText = [dict objectForKey:@"text"];
    
    User *user = [[User alloc] init];
    [user updateWithDictionary:[dict objectForKey:@"user"]];
    self.user = user;
}

@end
