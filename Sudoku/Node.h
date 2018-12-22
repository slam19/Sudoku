//
//  Node.h
//  LinkedList
//
//  Created by Simon Lam on 10/9/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef Node_h
#define Node_h
#import "Box.h"
@interface Node<ObjectType>: NSObject

@property Box *item;
@property Node *next;
@property Node *previous;

-(NSString *) itemName;
-(id) initWithItem: (Box *) f;
@end
#endif /* Node_h */
