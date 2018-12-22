//
//  Stack.h
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef Stack_h
#define Stack_h
#import "Node.h"

@interface Stack<ObjectType>: NSObject 

@property Node<ObjectType> *first;

-(void) push: (ObjectType) value;
-(ObjectType) pop;
-(bool) isEmpty;
-(ObjectType) peek;

@end

#endif /* Stack_h */
