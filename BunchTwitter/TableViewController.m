//
//  ViewController.m
//  BunchTwitter
//
//  Created by Grant Sutcliffe on 2012-10-10.
//  Copyright (c) 2012 Grant Sutcliffe. All rights reserved.
//

#import "TableViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import <Twitter/Twitter.h>

@interface TableViewController ()

@end

@implementation TableViewController

NSArray *tweets;
UIImage *placeholder;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup notification to reload tweets everytime the app is opened or re-enters foreground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTweets) name:@"willEnterForeground" object:nil];
    [self loadTweets];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Function to download a new set of tweets and refresh the page
- (void)loadTweets
{
    // Load placeholder image for use later
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"noprofilepic" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    placeholder = [[UIImage alloc] initWithData:imageData];
    
    // Get Tweets
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"59" forKey:@"rpp"];
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
                 
                 [self performSelectorOnMainThread:(@selector(setTweets)) withObject:nil waitUntilDone:NO];
             }
             else {
                 // Inspect the contents of jsonError
                 NSLog(@"%@", jsonError);
             }
         }
     }];
}

// Function to reload talblview in foreground
- (void)setTweets
{
    [self.tableView reloadData];
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
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TweetCell" owner:self options:nil];
        cell = (TweetCell *) [topLevelObjects objectAtIndex:0];
    }
    
    // Get current tweet
    NSDictionary *currentTweet = [tweets objectAtIndex:indexPath.row];
    
    [cell setTweetText:[currentTweet valueForKey:@"text"]];
    
    // If profile picture available, otherwise default picture
    NSString *urlString = [[currentTweet valueForKey:@"profile_image_url"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL * imageURL = [NSURL URLWithString:urlString];
    [cell.imageView setImageWithURL:imageURL placeholderImage:placeholder];
    
    return cell;
}

// Added for visual effect...
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
