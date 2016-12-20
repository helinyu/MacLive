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
@property (weak) IBOutlet NSTableColumn *tableColumn;

@property (strong, nonatomic) PlayerService *playerService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableColumn.title = @"视频列表";
    self.tableColumn.identifier = @"vedio list";
    //test
    _dataSourceList = [NSMutableArray new];
    for (NSInteger index = 0; index < 30; index ++ ) {
        [_dataSourceList addObject:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index%3]];
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

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *strIdt=[tableColumn identifier];
    NSTableCellView *aView = [tableView makeViewWithIdentifier:strIdt owner:self];
    if (!aView)
        aView = [[NSTableCellView alloc]initWithFrame:CGRectMake(0, 0, tableColumn.width, 58)];
    else
        for (NSView *view in aView.subviews)[view removeFromSuperview];
    
    NSTextField *textField = [[NSTextField alloc] initWithFrame:CGRectMake(15, 20, 156+50, 17)];
    textField.stringValue = [NSString stringWithFormat:@"视频%ld",(long)row];
    textField.font = [NSFont systemFontOfSize:15.0f];
    textField.textColor = [NSColor blackColor];
    textField.drawsBackground = NO;
    textField.bordered = NO;
    textField.focusRingType = NSFocusRingTypeNone;
    textField.editable = NO;
    textField.backgroundColor = [NSColor redColor];
    [aView addSubview:textField];
    return aView;
}

#pragma mark -- table delegate

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    // 播放选中的视频
    [self configureAPlayer:row];
    return YES;
}
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem {
    
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem {
    NSLog(@"select index item %@",tabViewItem);
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSLog(@"select notification : %@",notification);
}

@end
