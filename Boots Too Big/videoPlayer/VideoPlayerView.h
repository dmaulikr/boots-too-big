//
//  VideoPlayerView.h
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-04.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayer;

@interface VideoPlayerView : UIView

@property (nonatomic, retain) AVPlayer *player;

- (void)setPlayer:(AVPlayer*)player;
- (void)setVideoFillMode:(NSString *)fillMode;

@end
