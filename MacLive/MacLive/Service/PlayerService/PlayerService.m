//
//  PlayerService.m
//  MacLive
//
//  Created by felix on 2016/12/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PlayerService.h"

@interface PlayerService()

@end

@implementation PlayerService

- (instancetype)initWithURLString:(NSString *)urlstring {
    self = [super init];
    if (self) {
        _livePlayerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlstring]];
        _livePlayer = [AVPlayer playerWithPlayerItem:_livePlayerItem];
    }
    return self;
}

@end
