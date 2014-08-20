//
//  RecordVideoViewController.h
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-01.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface RecordVideoViewController : UIViewController

- (IBAction)didTouchInsideButtonRecordVideo:(UIButton *)sender;

-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate;

-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;


@end
