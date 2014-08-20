//
//  MergeVideoViewController.h
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-01.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MergeVideoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate> {
    BOOL isSelectingAssetOne;
}

@property(nonatomic, strong) AVAsset *firstAsset;
@property(nonatomic, strong) AVAsset *secondAsset;
@property(nonatomic, strong) AVAsset *audioAsset;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


- (IBAction)didTouchInsideBtnLoadSceneOne:(UIButton *)sender;
- (IBAction)didTouchInsideBtnLoadSceneTwo:(UIButton *)sender;
- (IBAction)didTouchInsideBtnLoadAudio:(UIButton *)sender;
- (IBAction)didTouchInsideBtnPrintFinalCut:(id)sender;

@end
