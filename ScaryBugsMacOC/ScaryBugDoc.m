//
//  ScaryBugDoc.m
//  ScaryBugsMacOC
//
//  Created by Leo Yu on 9/26/15.
//  Copyright © 2015 Leo Yu. All rights reserved.
//

#import "ScaryBugDoc.h"
#import "ScaryBugData.h"


@implementation ScaryBugDoc
-(id) initWithTitle:(NSString *)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage
{
    if ( self = [super init])
    {
        self.data = [[ScaryBugData alloc]initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    
    return self;
}

@end
