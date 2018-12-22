//
//  Stack.m
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Node.h"
#import "Stack.h"

@implementation Stack: NSObject {
    
}

- (void)push:(id)value; {
    Node *n = [[Node alloc] initWithItem: value];
    n.next = self.first;
    self.first = n;
}

-(id) pop {
    Node *temp = self.first;
    self.first = self.first.next;
    NSLog(@"p: %@", temp.item);
    return temp.item;
}
-(id) peek{
    return self.first.item;
}
-(bool) isEmpty {
    return !self.first;
}

@end
