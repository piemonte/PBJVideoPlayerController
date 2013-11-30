//
//  PBJVideoPlayerController.h
//
//  Created by Patrick Piemonte on 5/27/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PBJVideoPlayerPlaybackState) {
    PBJVideoPlayerPlaybackStateStopped = 0,
    PBJVideoPlayerPlaybackStatePlaying,
    PBJVideoPlayerPlaybackStatePaused,
    PBJVideoPlayerPlaybackStateFailed,
};

typedef NS_ENUM(NSInteger, PBJVideoPlayerBufferingState) {
    PBJVideoPlayerBufferingStateUnknown = 0,
    PBJVideoPlayerBufferingStateReady,
    PBJVideoPlayerBufferingStateDelayed,
};

typedef NS_ENUM(NSInteger, PBJVideoPlayerRepeatMode) {
    PBJVideoPlayerRepeatModeNone = 0,
    PBJVideoPlayerRepeatModeLoop,
};

// PBJVideoPlayerController.view provides us with an interface for playing/streaming videos
@protocol PBJVideoPlayerControllerDelegate;
@interface PBJVideoPlayerController : UIViewController
{
}

@property (nonatomic, weak) id<PBJVideoPlayerControllerDelegate> delegate;

@property (nonatomic) NSString *videoPath;
@property (nonatomic) PBJVideoPlayerRepeatMode repeatMode;

@property (nonatomic, readonly) PBJVideoPlayerPlaybackState playbackState;
@property (nonatomic, readonly) PBJVideoPlayerBufferingState bufferingState;

- (void)playFromBeginning;
- (void)play;
- (void)pause;
- (void)stop;

@end

@protocol PBJVideoPlayerControllerDelegate <NSObject>
@required
- (void)videoPlayerReady:(PBJVideoPlayerController *)videoPlayer;
- (void)videoPlayerPlaybackStateDidChange:(PBJVideoPlayerController *)videoPlayer;

- (void)videoPlayerPlaybackWillStartFromBeginning:(PBJVideoPlayerController *)videoPlayer;
- (void)videoPlayerPlaybackDidEnd:(PBJVideoPlayerController *)videoPlayer;

@end
