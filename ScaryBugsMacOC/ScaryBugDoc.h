//
//  ScaryBugDoc.h
//  ScaryBugsMacOC
//
//  Created by Leo Yu on 9/26/15.
//  Copyright © 2015 Leo Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaryBugData;

@interface ScaryBugDoc : NSObject

@property(strong) ScaryBugData* data;
@property(strong) NSImage *thumbImage;
@property(strong) NSImage *fullImage;

-(id) initWithTitle:(NSString*)title    rating:(float)rating    thumbImage:(NSImage*)thumbImage fullImage:(NSImage*)fullImage;

@end
