//
//  Status.h
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-12.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Status : NSObject

@property (strong, nonatomic) NSString *statusText;
@property (strong, nonatomic) User *user;
-(void)updateWithDictionary:(NSDictionary *)dict;

@end
