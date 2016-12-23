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
#import <ScreenSaver/ScreenSaver.h>
#import <ScreenSaver/ScreenSaverDefaults.h>
#import "VideoRecorderController.h"

@interface ViewController()<NSTableViewDelegate,NSTableViewDataSource>
{
    NSMutableArray *_dataSourceList;
    
/// video recorder and player so on
    AVCaptureSession  *_captureSession;
    AVCaptureDeviceInput *_captureDeviceInput;
    AVCaptureMovieFileOutput *_movieFileOutput;
    AVCaptureVideoPreviewLayer *_previewLayer;
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
    
    // 视频播放处理
    self.tableColumn.title = @"视频列表";
    self.tableColumn.identifier = @"vedio list";
    //test
    _dataSourceList = [NSMutableArray new];
    for (NSInteger index = 0; index < 30; index ++ ) {
        [_dataSourceList addObject:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index%3]];
    }
    
    NSArray *arrays = [[NSApp mainMenu] itemArray];
    NSMenu *subMenu = [[arrays objectAtIndex:2] submenu];
    NSArray *items = [subMenu itemArray];
    for (NSInteger index = 0;  index<items.count; index++) {
        NSMenuItem *menuItem = items[index];
        menuItem.enabled = true;
        menuItem.tag = index;
        [menuItem setTarget:self];
        [menuItem setAction:@selector(onBehaviorClicked:)];
    }
    
    // 视频录制初始化
    
    
    
    
}

- (void)onBehaviorClicked:(NSMenuItem*)menuItem {
    NSLog(@"menuItem is ; %ld",menuItem.tag);
    switch (menuItem.tag) {
        case 0:
        {
            NSLog(@"tag 0");
        }
            break;
        case 1:
        {
            NSLog(@"tag 1");
            VideoRecorderController *vc = [[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:NSStringFromClass([VideoRecorderController class])];
        }
            break;
        case 2:
            NSLog(@"tag 2");
            break;
        default:
            break;
    }
}

- (void)copyAction:(NSMenuItem*)item {
    NSLog(@"clicked");
}

- (BOOL)configureAPlayer:(NSInteger)index {
    _playerService = [[PlayerService alloc] initWithURLString:_dataSourceList[index]];
    _playerView.player = _playerService.livePlayer;
    [_playerService.livePlayer play];
    return true;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
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
