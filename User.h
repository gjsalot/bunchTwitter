//
//  User.h
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-12.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) NSString *username;

-(void)updateWithDictionary:(NSDictionary *)dict;

@end
