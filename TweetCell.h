//
//  TweetCell.h
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-06.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
-(void)setTweetText:(NSString *)text;

@end
