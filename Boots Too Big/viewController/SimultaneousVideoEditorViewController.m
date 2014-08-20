//
//  SimultaneousVideoEditorViewController.m
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-07.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import "SimultaneousVideoEditorViewController.h"

@interface SimultaneousVideoEditorViewController ()

@end

static void *SimultaneousVideoEditorViewControllerStatusObservationContext = &SimultaneousVideoEditorViewControllerStatusObservationContext;

@implementation SimultaneousVideoEditorViewController

@synthesize activityView;
@synthesize mPlayer, mPlaybackView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    [self setActivityView:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"Video2" withExtension:@"mp4"];
    
    [activityView startAnimating];
    AVURLAsset *firstAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"Video2" ofType: @"mp4"]] options:nil];
    AVURLAsset *secondAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"Video2" ofType: @"mp4"]] options:nil];

    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration) ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack *secondTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [secondTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, secondAsset.duration) ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    // AVMutableVideoCompositionInstruction : contains the array of AVMutableVideoCompositionLayerInstruction //
    // Set the duration of the layer equal to the length of the longest asset //
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, firstAsset.duration);
    
    // Layer Instructions //
    // track one //
    AVMutableVideoCompositionLayerInstruction *firstLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:firstTrack];
    CGAffineTransform Scale = CGAffineTransformMakeScale(0.5f, 0.5f);
    CGAffineTransform Move = CGAffineTransformMakeTranslation(firstTrack.naturalSize.width * .5, 0); //230, 230
    [firstLayerInstruction setTransform:CGAffineTransformConcat(Scale,Move) atTime:kCMTimeZero];
    
    // track two //
    AVMutableVideoCompositionLayerInstruction *secondLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:secondTrack];
    CGAffineTransform SecondScale = CGAffineTransformMakeScale(0.5f, 0.5f); //1.2f,1.5f
    CGAffineTransform SecondMove = CGAffineTransformMakeTranslation(0, 0);
    [secondLayerInstruction setTransform:CGAffineTransformConcat(SecondScale, SecondMove) atTime:kCMTimeZero];
    
    // add instructions to mainInstruction //
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:firstLayerInstruction, secondLayerInstruction,nil];
    
    /* 
     * Create the AVMutableVideoComposition: Multiple AVMutableVideoCompositionInstruction can be added: use multiple
     * AVMutableVideoCompositionInstruction objects to add multiple layers of effects, such as fade and transition but 
     * make sure that time ranges of the AVMutableVideoCompositionInstruction objects dont overlap.
     */
    AVMutableVideoComposition *mutableVideoComposition = [AVMutableVideoComposition videoComposition];
    mutableVideoComposition.instructions = [NSArray arrayWithObject:mainInstruction];
    mutableVideoComposition.frameDuration = CMTimeMake(1, 30);
    mutableVideoComposition.renderSize = CGSizeMake(640, 480);
    
    // Finally, add the newly created AVMutableComposition with multiple tracks to an AVPlayerItem and play it using AVPlayer. //
    AVPlayerItem *newPlayerItem = [AVPlayerItem playerItemWithAsset:mixComposition];

    newPlayerItem.videoComposition = mutableVideoComposition;
    mPlayer = [AVPlayer playerWithPlayerItem:newPlayerItem];
    [mPlayer addObserver:self forKeyPath:@"status" options:0 context:SimultaneousVideoEditorViewControllerStatusObservationContext];
    
    [mPlaybackView setPlayer:mPlayer];
    [self.view addSubview:mPlaybackView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:@"mergeVideo.mov"];
    
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
	
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=url;
    [exporter setVideoComposition:mutableVideoComposition];
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
	
	[exporter exportAsynchronouslyWithCompletionHandler:^
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self exportDidFinish:exporter];
         });
     }];
}

- (void)exportDidFinish:(AVAssetExportSession*)session
{
	NSURL *outputURL = session.outputURL;
	ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
	if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
        [library writeVideoAtPathToSavedPhotosAlbum:outputURL
									completionBlock:^(NSURL *assetURL, NSError *error){
                                        dispatch_async(dispatch_get_main_queue(), ^{
											if (error) {
												NSLog(@"writeVideoToAssestsLibrary failed: %@", error);
											}else{
                                                NSLog(@"Writing3");
                                            }
											
										});
										
									}];
	}
    [activityView stopAnimating];
}

- (void)observeValueForKeyPath:(NSString*) path ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (mPlayer.status == AVPlayerStatusReadyToPlay) {
        [mPlaybackView setPlayer:mPlayer];
        [mPlayer play];
    }
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
