//
//  Queue.h
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef Queue_h
#define Queue_h
#import "Node.h"

@interface Queue<ObjectType>: NSObject

@property Node<ObjectType> *head;
@property Node<ObjectType> *tail;

-(void) enqueue: (ObjectType) value;
-(ObjectType) dequeue;
-(bool) isEmpty;

@end


#endif /* Queue_h */
