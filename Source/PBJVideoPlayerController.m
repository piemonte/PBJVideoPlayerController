//
//  PBJVideoPlayerController.m
//
//  Created by Patrick Piemonte on 5/27/13.
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

#import "PBJVideoPlayerController.h"
#import "PBJVideoView.h"

@interface PBJVideoPlayerController () <
    UIGestureRecognizerDelegate>
{
}

@end

@implementation PBJVideoPlayerController

#pragma mark - init

- (void)dealloc
{
    _player = nil;
}

#pragma mark - view lifecycle

- (void)loadView
{
    self.view = _player.videoView;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_player.playbackState == PBJVideoPlayerPlaybackStatePlaying)
        [_player pause];
}

#pragma mark - UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_player.videoPath) {
        
        switch (_player.playbackState) {
            case PBJVideoPlayerPlaybackStateStopped:
            {
                [_player playFromBeginning];
                break;
            }
            case PBJVideoPlayerPlaybackStatePaused:
            {
                [_player playFromCurrentTime];
                break;
            }
            case PBJVideoPlayerPlaybackStatePlaying:
            case PBJVideoPlayerPlaybackStateFailed:
            default:
            {
                [_player pause];
                break;
            }
        }
        
    } else {
        [super touchesEnded:touches withEvent:event];
    }
    
}

- (void)_handleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (_player.playbackState == PBJVideoPlayerPlaybackStatePlaying) {
        [_player pause];
    } else if (_player.playbackState == PBJVideoPlayerPlaybackStateStopped) {
        [_player playFromBeginning];
    } else {
        [_player playFromCurrentTime];
    }
}

@end
