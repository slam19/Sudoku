//
//  Box.m
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"
@implementation Box
-(id) initWithRow:(int)r andCol:(int)c{
    self = [super init];
    if (self){
        self.rowPos =r;
        self.colPos = c;
        self.previous= nil;
        self.fixed = false;
    }
    return self;
}

-(void) print{
    NSLog(@"v: %i, f: %d (r:%i, c: %i) ", self.value, self.fixed, self.rowPos,self.colPos);
}


@end
