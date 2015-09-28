//
//  MasterViewController.m
//  ScaryBugsMacOC
//
//  Created by Leo Yu on 9/26/15.
//  Copyright © 2015 Leo Yu. All rights reserved.
//

#import "MasterViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"
#import "EDStarRating.h"
#import <Quartz/Quartz.h>
#import "NSImage+Extras.h"


@interface MasterViewController ()
@property (weak) IBOutlet NSTableView *bugsTableView;
@property (weak) IBOutlet NSTextField *bugTitleView;
@property (weak) IBOutlet NSImageView *bugImageView;
@property (weak) IBOutlet EDStarRating *bugRating;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

//only life cycle similar to iOS ;
-(void) loadView
{
    //call super or else view view will not be displayed
    [super loadView];
    
    self.bugRating.starImage = [NSImage imageNamed:@"star.png"];
    self.bugRating.starHighlightedImage = [NSImage imageNamed:@"shockedface2_full.png"];
    self.bugRating.starImage = [NSImage imageNamed:@"shockedface2_empty.png"];
    self.bugRating.maxRating = 5.0;
    self.bugRating.delegate = (id<EDStarRatingProtocol>) self;
    self.bugRating.horizontalMargin = 12;
    self.bugRating.editable=YES;
    self.bugRating.displayMode=EDStarRatingDisplayFull;
    self.bugRating.rating = 0.0;
  // fixedui3
  // fixedui32    
}

#pragma mark - data source
-(NSView*) tableView:(NSTableView*)tableView  viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    if ( [tableColumn.identifier isEqualToString: @"BugColumn"])
    {
        ScaryBugDoc *bugDoc = [self.bugs objectAtIndex:row];
        cellView.imageView.image = bugDoc.thumbImage;
        cellView.textField.stringValue = bugDoc.data.title;
        return cellView;
    }
    return cellView;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView*)tableView
{
    return [self.bugs count];
}

#pragma mark - delegate
-(void) tableViewSelectionDidChange:(NSNotification*)aNotification
{
    ScaryBugDoc *selectedDoc = [self selectedBugDoc];
    
    [self setDetailInfo:selectedDoc];
}

#pragma  mark - rating delegate
-(void)starsSelectionChanged: (EDStarRating*)control rating:(float)rating
{
    ScaryBugDoc *selectedDoc = [self selectedBugDoc];
    if ( selectedDoc)
    {
        selectedDoc.data.rating = self.bugRating.rating;
    }
}

#pragma  mark - textfield delegate
- (IBAction)bugTitleDidEndEdit:(id)sender {
    // 1. Get selected bug
    ScaryBugDoc *selectedDoc = [self selectedBugDoc];
    if ( selectedDoc)
    {
        // 2. Get the new name from the text field
        selectedDoc.data.title = [self.bugTitleView stringValue];
        
        // 3. Update the cell
        //The last step is to change the title in the table view. For that, you just tell the table view to reload the row for the current bug. This will cause viewForTableColumn to be called, which will then reload the table view cell appropriately.
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.bugs indexOfObject:selectedDoc]];
        
        NSIndexSet *columnSet = [NSIndexSet indexSetWithIndex:0];
        [self.bugsTableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
}

#pragma mark - helper
-(ScaryBugDoc*)selectedBugDoc
{
    NSInteger selectedRow = [self.bugsTableView selectedRow];
    if( selectedRow >=0 && self.bugs.count > selectedRow )
    {
        ScaryBugDoc *selectedBug = [self.bugs objectAtIndex:selectedRow];
        return selectedBug;
    }
    return nil;
}

-(void)setDetailInfo:(ScaryBugDoc*)doc
{
    NSString *title = @"";
    NSImage *image = nil;
    float rating=0.0;
    if( doc != nil )
    {
        title = doc.data.title;
        image = doc.fullImage;
        rating = doc.data.rating;
    }
    [self.bugTitleView setStringValue:title];
    [self.bugImageView setImage:image];
    [self.bugRating setRating:rating];
}

- (IBAction)adBug:(id)sender {
    ScaryBugDoc *newDoc = [[ScaryBugDoc alloc]initWithTitle:@"New Bug" rating:0.0 thumbImage:nil fullImage:nil];
    
    [self.bugs addObject:newDoc];
    NSInteger newRowIndex = self.bugs.count - 1 ;
    
    //insert a new row in the table view for that bug
    [self.bugsTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] withAnimation:NSTableViewAnimationEffectGap];
    
    //The last two lines are just cosmetic additions. You select the newly created row and you make the table view scroll to that
    //row so that the newly created row is visible.
    [self.bugsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
    [self.bugsTableView scrollColumnToVisible:newRowIndex];
}


- (IBAction)deleteBug:(id)sender {
    
    // 1. Get selected doc
    ScaryBugDoc *selectedDoc = [self selectedBugDoc ];
    if ( selectedDoc)
    {
        // 2. Remove the bug from the model
        [self.bugs removeObject:selectedDoc];
        
        // 3. Remove the selected row from the table view.
        [self.bugsTableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.bugsTableView.selectedRow] withAnimation:NSTableViewAnimationSlideRight ] ;
         
         //// Clear detail info
        //In the last line you just update the detail section with a nil value. That will actually clear all the information of the selected bug.
         [self setDetailInfo:nil];
    }
    
}

/*
 In this piece of code, you first check if you have a bug selected. If you find a bug, then you show the picture taker control
 so that the user can choose a picture.
 With this single line of code, we’re showing a window to select the new image. In the same method you tell the picture taker
 control that our view controller (self) is going to be it’s delegate.
 And that when it finished, it will call your delegate method pictureTakerDidEnd. In that method, you will collect the new
 image, and set it to the bug.
 */
- (IBAction)changePicture:(id)sender {
    
    ScaryBugDoc *selectedDoc = [self selectedBugDoc];
    if( selectedDoc )
    {
        [[IKPictureTaker pictureTaker]beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }
    
}

//call back when picture is selected
- (void) pictureTakerDidEnd:(IKPictureTaker *) picker
                 returnCode:(NSInteger) code
                contextInfo:(void*) contextInfo
{
    NSImage *image = [picker outputImage];
    
    //you check that the control returned OK (NSOKButton) and that you have a new image available.
    if ( image != nil && (code == NSModalResponseOK ))
    {
        [self.bugImageView setImage:image];
        
        //First you get the selected Bug
        ScaryBugDoc *selectedBugDoc = [self selectedBugDoc];
        if ( selectedBugDoc )
        {
            selectedBugDoc.fullImage = image;
            selectedBugDoc.thumbImage = [image imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
            
            //then the cell in the table view for the selected row.
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.bugs indexOfObject:selectedBugDoc]];
            NSIndexSet *columnSet = [NSIndexSet indexSetWithIndex:0];
            [self.bugsTableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
        }
    }
}
@end
