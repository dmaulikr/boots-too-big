//
//  SimultaneousVideoEditorView.m
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-07.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import "SimultaneousVideoEditorView.h"
#import <AVFoundation/AVFoundation.h>

@implementation SimultaneousVideoEditorView


+ (Class)layerClass
{
	return [AVPlayerLayer class];
}

- (AVPlayer*)player
{
	return [(AVPlayerLayer*)[self layer] player];
}

- (void)setPlayer:(AVPlayer*)player
{
	[(AVPlayerLayer*)[self layer] setPlayer:player];
}

/* Specifies how the video is displayed within a player layer’s bounds.
 (AVLayerVideoGravityResizeAspect is default) */
- (void)setVideoFillMode:(NSString *)fillMode
{
	AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
	playerLayer.videoGravity = fillMode;
}

@end
