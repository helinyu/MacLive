//
//  ViewController.m
//  MacLive
//
//  Created by felix on 2016/12/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayerService.h"
#import <AppKit/AppKit.h>


@interface ViewController()<NSTableViewDelegate,NSTableViewDataSource>
{
    NSMutableArray *_dataSourceList;
}
// IBOutlet
@property (weak) IBOutlet AVPlayerView *playerView;

@property (weak) IBOutlet NSScrollView *movieListScollView;
@property (weak) IBOutlet NSTableView *movieListTableView;

// strong uikit object
//@property (strong, nonatomic) AVPlayerViewController *playViewController; // is not for mac

@property (strong, nonatomic) PlayerService *playerService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //test
    _dataSourceList = [NSMutableArray new];
    for (NSInteger index = 0; index < 30; index ++ ) {
        [_dataSourceList addObject:@{[NSString stringWithFormat:@"test%ld",(long)index%3]:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index%3]}];
    }

}

- (BOOL)configureAPlayer:(NSInteger)index {
    _playerService = [[PlayerService alloc] initWithURLString:_dataSourceList[index]];
    _playerView.player = _playerService.livePlayer;
    [_playerService.livePlayer play];
    return true;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


#pragma mark -- table datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _dataSourceList.count;
}

-(NSView)tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn* )tableColumn row:(NSInteger)row{
    NSView* cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    //do something
    //cell.XX=XX;
    return cell;
}

#pragma mark -- table delegate

//- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem {
//}

- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem {
    
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem {
    NSLog(@"select index item %@",tabViewItem);
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSLog(@"select notification : %@",notification);
}

@end
