//
//  ViewController.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-10-10.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "TableViewController.h"
#import "StatusCell.h"
#import "UIImageView+AFNetworking.h"
#import "Status.h"
#import "Engine.h"
#import <Twitter/Twitter.h>

@interface TableViewController ()

@end

@implementation TableViewController

NSArray *statuses;
UIImage *placeholder;
Engine *engine;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup notification to reload tweets everytime the app is opened or re-enters foreground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStatuses) name:@"willEnterForeground" object:nil];
    engine = [[Engine alloc] init];
    [self loadStatuses];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Function to download a new set of tweets and refresh the page
- (void)loadStatuses
{
    // Load placeholder image for use later
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"noprofilepic" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    placeholder = [[UIImage alloc] initWithData:imageData];
    
    [engine getStatusesWithCompletion:^(NSError *error, NSArray *array)
     {
         statuses = array;
         [self.tableView reloadData];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell *)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    // Set alternating shades for rows
    cell.backgroundColor = indexPath.row % 2
    ? [UIColor colorWithWhite:0.8 alpha:1.000]
    : [UIColor colorWithWhite:0.7 alpha:1.000];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *currentStatus = [statuses objectAtIndex:indexPath.row];
    CGSize stringSize = [currentStatus.statusText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(239, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (stringSize.height + 22 < 70)
        return 70;
    else
        return stringSize.height + 22;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [statuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StatusCell";
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusCell" owner:self options:nil];
        cell = (StatusCell *) [topLevelObjects objectAtIndex:0];
    }
    
    // Get current tweet
    Status *currentStatus = [statuses objectAtIndex:indexPath.row];
    
    [cell setStatusText:currentStatus.statusText];
    
    // If profile picture available, otherwise default picture
    [cell.imageView setImageWithURL:currentStatus.user.avatarUrl placeholderImage:placeholder];
    
    return cell;
}

// Added for visual effect...
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
