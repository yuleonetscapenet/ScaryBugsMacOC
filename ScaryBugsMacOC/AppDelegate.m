//
//  AppDelegate.m
//  ScaryBugsMacOC
//
//  Created by Leo Yu on 9/26/15.
//  Copyright © 2015 Leo Yu. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "ScaryBugDoc.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet MasterViewController *masterViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.masterViewController = [[MasterViewController alloc]initWithNibName:@"MasterViewController" bundle:nil];
    
    //set up sample data
    ScaryBugDoc *bug1 = [[ScaryBugDoc alloc]initWithTitle:@"Potato Bug" rating:4 thumbImage:[NSImage imageNamed:@"potatoBugThumb.jpg"] fullImage:[NSImage imageNamed:@"potatoBug.jpg"]];
    
      ScaryBugDoc *bug2 = [[ScaryBugDoc alloc]initWithTitle:@"House Centipede" rating:3 thumbImage:[NSImage imageNamed:@"centipedeThumb.jpg"] fullImage:[NSImage imageNamed:@"centipede.jpg"]];
    
      ScaryBugDoc *bug3 = [[ScaryBugDoc alloc]initWithTitle:@"Wolf Spider" rating:5 thumbImage:[NSImage imageNamed:@"wolfSpiderThumb.jpg"] fullImage:[NSImage imageNamed:@"wolfSpiderThumb.jpg"]];
    
      ScaryBugDoc *bug4 = [[ScaryBugDoc alloc]initWithTitle:@"Lady Bug" rating:4 thumbImage:[NSImage imageNamed:@"ladybugThumb.jpg"] fullImage:[NSImage imageNamed:@"ladybug.jpg"]];
    
    NSMutableArray *bugs = [NSMutableArray arrayWithObjects:bug1, bug2, bug3, bug4, nil];
    self.masterViewController.bugs = bugs;
    
    
    
    //The windows in OSX (NSWindow class) are always created with a default view, called contentView that is automatically resized to the window’s size. If you want to add your own views to a window, you will always need to add them to the contentView using addSubView.
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
