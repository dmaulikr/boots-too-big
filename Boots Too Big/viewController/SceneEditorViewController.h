//
//  EditorViewController.h
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-04.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoEditor.h"

@interface SceneEditorViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnSelectSceneVideo;
@property (weak, nonatomic) IBOutlet UIButton *btnPrintSceneFinalCut;

- (IBAction)didTouchUpInsideBtnSelectSceneVideo:(UIButton *)sender;
- (IBAction)didTouchUpInsideBtnPrintSceneFInalCut:(UIButton *)sender;

@property(nonatomic, strong) VideoEditor *videoEditor;
@property(nonatomic, strong) AVAsset *videoAsset;

- (BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id)delegate;

@end
