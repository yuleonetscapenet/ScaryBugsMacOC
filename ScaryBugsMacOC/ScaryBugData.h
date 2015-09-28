//
//  ScaryBugData.h
//  ScaryBugsMacOC
//
//  Created by Leo Yu on 9/26/15.
//  Copyright © 2015 Leo Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject

@property (strong) NSString *title;
@property (assign) float rating;

-(id) initWithTitle: (NSString*)title rating:(float)rating;

@end
