//
//  PlayerService.h
//  MacLive
//
//  Created by felix on 2016/12/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerService : NSObject

@property (strong, nonatomic) AVPlayer *livePlayer;

@property (strong, nonatomic) AVPlayerItem *livePlayerItem;

- (instancetype)initWithURLString:(NSString *)urlstring;

@end
