//
//  Queue.m
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Queue.h"

@implementation Queue: NSObject {
    
}
-(void) enqueue: (id) value {
    Node *n = [[Node alloc] initWithItem: value];
    if (!self.head) {
        self.head = n;
        self.tail = n;
    } else {
        self.tail.next = n;
        n.previous = n;
        self.tail = n;
    }
}

-(id) dequeue {
    Node *head = self.head;
    self.head = self.head.next;
    self.head.previous = nil;
    return head.item;
}

-(bool) isEmpty {
    return !(self.head);
}

@end
