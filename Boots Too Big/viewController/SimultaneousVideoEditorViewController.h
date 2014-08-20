//
//  SimultaneousVideoEditorViewController.h
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-07.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVVideoComposition.h>
#import "SimultaneousVideoEditorView.h"

@class SimultaneousVideoEditorView;
@class AVPlayer;

@interface SimultaneousVideoEditorViewController : UIViewController {
    AVPlayer* mPlayer;
    IBOutlet SimultaneousVideoEditorView  *mPlaybackView;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (readwrite, strong) AVPlayer* mPlayer;
@property (nonatomic, strong) IBOutlet SimultaneousVideoEditorView *mPlaybackView;

- (void)exportDidFinish:(AVAssetExportSession*)session;
- (void)observeValueForKeyPath:(NSString*) path ofObject:(id)object change:(NSDictionary*)change context:(void*)context;

@end
