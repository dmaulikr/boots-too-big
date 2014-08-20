//
//  PlayMutlipleVideoViewController.m
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-04.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import "PlayMutlipleVideoViewController.h"
#import "VideoPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PlayMutlipleVideoViewController ()

@property (nonatomic, retain) MPMoviePlayerController *playerViewController;
@property (nonatomic, retain) VideoPlayerViewController *myPlayerViewController;

@end

@implementation PlayMutlipleVideoViewController

@synthesize playerViewController = _playerViewController;
@synthesize myPlayerViewController = _myPlayerViewController;

- (void)dealloc {
    self.playerViewController = nil;
    self.myPlayerViewController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Video2" withExtension:@"mp4"];
    
    // video player controller //
    MPMoviePlayerController *playerViewController = [[MPMoviePlayerController alloc] init];
    playerViewController.contentURL = url;
    playerViewController.view.frame = CGRectMake(0, 0, 500, 500);
    
    [self.view addSubview:playerViewController.view];
    [playerViewController play];
    
    self.playerViewController = playerViewController;
    
    // custom video player controller //
    VideoPlayerViewController *videoPlayerViewController = [[VideoPlayerViewController alloc] init];
    videoPlayerViewController.URL = url;
    videoPlayerViewController.view.frame = CGRectMake(0, 500, 500, 500);
    [self.view addSubview:videoPlayerViewController.view];
    self.myPlayerViewController = videoPlayerViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
