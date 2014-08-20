//
//  VideoEditor.h
//  Boots Too Big
//
//  Created by John Fraboni on 2014-05-04.
//  Copyright (c) 2014 John Fraboni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface VideoEditor : NSObject

typedef void (^OperationCompleteBlock)(NSDictionary *dict, NSError *error);

@property(nonatomic, strong) AVMutableComposition *composition;
@property(nonatomic, strong) NSMutableArray *listOfScenes;

- (void)compositeScene:(AVAsset *)scene withOverlayKey:(NSString *)overlayKey onComplete:(OperationCompleteBlock)callback;
- (void)exportDidFinish:(AVAssetExportSession*)session;

- (void)applyOverlayWithKey:(NSString *)key toComposition:(AVMutableVideoComposition *)composition withSize:(CGSize)size;
-(NSInteger)addScene:(AVAsset *)scene;

@end
