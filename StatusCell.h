//
//  TweetCell.h
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-06.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, readonly, copy) NSString *reuseIdentifier;
-(void)setStatusText:(NSString *)text;

@end
