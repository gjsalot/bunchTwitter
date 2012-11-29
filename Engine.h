//
//  Engine.h
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-29.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Engine : NSObject

-(void) getPostsWithCompletion:(void (^)(NSError *, NSArray *))completionHandler;

@end
