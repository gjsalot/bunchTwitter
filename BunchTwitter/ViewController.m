//
//  ViewController.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-10-10.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "ViewController.h"
#import "TweetCell.h"
#import <Twitter/Twitter.h>

@interface ViewController ()

@end

@implementation ViewController

NSArray *tweets;
NSMutableArray *images;
UITableView *tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    tableView = [self.view.subviews objectAtIndex:0];
    
    // Setup notification to reload tweets everytime the app is opened or re-enters foreground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTweets) name:@"willEnterForeground" object:nil];
    [self loadTweets];
}

// Function to download a new set of tweets and refresh the page
- (void)loadTweets
{
    images = nil;
    tweets = nil;
    
    // Get Tweets
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"50" forKey:@"rpp"];
    [params setObject:@"a" forKey:@"q"];
    NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json"];
    TWRequest *request = [[TWRequest alloc]     initWithURL:url
                                                 parameters:params
                                              requestMethod:TWRequestMethodGET];
    [request performRequestWithHandler:
     ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
         
         if (responseData) {
             NSError *jsonError;
             NSDictionary *dict =
             [NSJSONSerialization JSONObjectWithData:responseData
                                             options:NSJSONReadingMutableLeaves
                                               error:&jsonError];
             
             if (dict) {
                 NSLog(@"%@", dict);
                 tweets = [dict objectForKey:@"results"];
                 
                 // Get profile pictures...
                 images = [[NSMutableArray alloc] init];
                 [self performSelectorInBackground:(@selector(loadImages)) withObject:nil];
                 
                 [self performSelectorOnMainThread:(@selector(setTweets)) withObject:nil waitUntilDone:NO];
             }
             else {
                 // Inspect the contents of jsonError
                 NSLog(@"%@", jsonError);
             }
         }
     }];
}

// Function to download images in background and alert foreground as image downloaded
- (void)loadImages
{
    for (int i = 0; i < [tweets count]; i++)
    {
        // Get url of current profile picture and download it
        NSString *urlString = [[[tweets objectAtIndex:i] valueForKey:@"profile_image_url"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSURL * imageURL = [NSURL URLWithString:urlString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        // If nothing returns, put a placeholder image in
        if ([imageData length] == 0)
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"noprofilepic" ofType:@"png"];
            imageData = [NSData dataWithContentsOfFile:filePath];
        }
        [images addObject:imageData];
        
        // Call foreground to update cell picture
        UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self performSelectorOnMainThread:(@selector(updateCell:)) withObject:cell waitUntilDone:NO];
        
        NSLog(@"Image added");
    }
}

// Function to update a specific cell in foreground
- (void)updateCell:(UITableViewCell *)cell
{
    [tableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects:[tableView indexPathForCell:cell], nil] withRowAnimation:NO];
}

// Function to reload talblview in foreground
- (void)setTweets
{
    [tableView reloadData];
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
    NSString *text = [[tweets objectAtIndex:indexPath.row] valueForKey:@"text"];
    CGSize stringSize = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(239, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (stringSize.height + 22 < 70)
        return 70;
    else
        return stringSize.height + 22;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController *temp = [[UIViewController alloc] initWithNibName:@"TweetCell" bundle:nil];
        cell = (TweetCell *)temp.view;
    }
    
    // Get current tweet
    NSDictionary *currentTweet = [tweets objectAtIndex:indexPath.row];
    
    [cell setTweetText:[currentTweet valueForKey:@"text"]];
    
    // If profile picture available, otherwise default picture
    if ([images count] > indexPath.row)
            [cell.imageView setImage:[[UIImage alloc] initWithData:[images objectAtIndex:indexPath.row]]];
    else
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"noprofilepic" ofType:@"png"];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        [cell.imageView setImage:[[UIImage alloc] initWithData:imageData]];
    }
    
    return cell;
}

// Added for visual effect...
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
