//
//  ScaryBugData.m
//  ScaryBugsMacOC
//
//  Created by Leo Yu on 9/26/15.
//  Copyright © 2015 Leo Yu. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

-(id) initWithTitle:(NSString *)title rating:(float)rating
{
    if ( self = [super init])
    {
        self.title = title;
        self.rating = rating;
    }
    return self;
}

@end
