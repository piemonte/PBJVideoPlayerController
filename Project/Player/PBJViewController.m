//
//  PBJViewController.m
//  Player
//
//  Created by Patrick Piemonte on 11/12/13.
//  Copyright (c) 2013-present, Patrick Piemonte, http://patrickpiemonte.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PBJViewController.h"
#import "PBJVideoPlayerController.h"

static NSString * const PBJViewControllerVideoPath = @"http://distilleryvesper7-3.ak.instagram.com/fdc51d8ea73611e3a15612e740d32ce3_101.mp4";

@interface PBJViewController () <
    PBJVideoPlayerControllerDelegate>
{
    PBJVideoPlayerController *_videoPlayerController;
    UIImageView *_playButton;
}

@end

@implementation PBJViewController

#pragma mark - UIViewController status bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    _videoPlayerController = [[PBJVideoPlayerController alloc] init];
    _videoPlayerController.delegate = self;
    _videoPlayerController.view.frame = self.view.bounds;
    
    [self addChildViewController:_videoPlayerController];
    [self.view addSubview:_videoPlayerController.view];
    [_videoPlayerController didMoveToParentViewController:self];

    _playButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_button"]];
    _playButton.center = self.view.center;
    [self.view addSubview:_playButton];
    [self.view bringSubviewToFront:_playButton];
    
    _videoPlayerController.videoPath = PBJViewControllerVideoPath;
}

#pragma mark - ConvertTime Helper Method

- (NSString *)convertTime:(Float64)second {
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

#pragma mark - PBJVideoPlayerControllerDelegate

- (void)videoPlayerReady:(PBJVideoPlayerController *)videoPlayer
{
    NSLog(@"Max duration of the video: %f", videoPlayer.maxDuration);
}

- (void)videoPlayerPlaybackStateDidChange:(PBJVideoPlayerController *)videoPlayer
{
}

- (void)videoPlayer:(PBJVideoPlayerController *)videoPlayer readDurationDidChange:(NSTimeInterval)readDuration {
    NSString *timeString = [self convertTime:readDuration];
    NSLog(@"%@", [NSString stringWithFormat:@"%@/%@", timeString, [self convertTime:videoPlayer.maxDuration]]);
}

- (void)videoPlayer:(PBJVideoPlayerController *)videoPlayer bufferDurationDidChange:(Float64)bufferDuration {
    NSLog(@"~~~~~~缓冲进度：%f", bufferDuration / videoPlayer.maxDuration);
}

- (void)videoPlayerPlaybackWillStartFromBeginning:(PBJVideoPlayerController *)videoPlayer
{
    _playButton.alpha = 1.0f;
    _playButton.hidden = NO;

    [UIView animateWithDuration:0.1f animations:^{
        _playButton.alpha = 0.0f;
    } completion:^(BOOL finished) {
        _playButton.hidden = YES;
    }];
}

- (void)videoPlayerPlaybackDidEnd:(PBJVideoPlayerController *)videoPlayer
{
    _playButton.hidden = NO;

    [UIView animateWithDuration:0.1f animations:^{
        _playButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

@end
