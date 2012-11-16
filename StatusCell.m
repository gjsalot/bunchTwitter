//
//  TweetCell.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-11-06.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "StatusCell.h"

@implementation StatusCell
@synthesize statusLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStatusText:(NSString *)text
{
    // Get the size of the tweet text
    CGSize stringSize = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(239, 9999) lineBreakMode:NSLineBreakByWordWrapping];

    // Create text label
    statusLabel.text = text;
    [statusLabel setFrame:CGRectMake(67, 11, 239, stringSize.height)];
    
    // Adjust location of imageview
    int y = 11 + (stringSize.height - 48) / 2;
    if (y < 11) y = 11;
    [imageView setFrame:CGRectMake(11, y, 48, 48)];
}

- (NSString *) reuseIdentifier {
    return @"StatusCell";
}

@end
