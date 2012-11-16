//
//  User.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-12.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "User.h"

@implementation User

-(void)updateWithDictionary:(NSDictionary *)dict
{
    self.username = [dict objectForKey:@"username"];
    
    NSURL *avatarUrl = [[NSURL alloc] initWithString:[[dict objectForKey:@"avatar_image"] objectForKey:@"url"]];
    self.avatarUrl = avatarUrl;
}

@end
