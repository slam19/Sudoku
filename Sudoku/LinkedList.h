//
//  LinkedList.h
//  LinkedList
//
//  Created by Simon Lam on 10/9/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef LinkedList_h
#define LinkedList_h

#import "Node.h"
@interface LinkedList<ObjectType>: NSObject

@property Node *first;

-(NSString *)readInputString;
-(int) readOperation;
-(void)printInstructions;
-(void) iAdd: (ObjectType) i;
-(void) rAdd: (ObjectType) i  withHolder : (Node *) n;
-(void) addFirst: (ObjectType) i;
-(void) clear;
-(void) iDisplayList;
-(void) rDisplayList: (Node *) n;
-(NSString *) getFirstItemName;
-(int) iSize;
-(int) rSize: (int) counter withHolder : (Node *) n;
-(bool) iContainsObject: (ObjectType) i;
-(bool) rContainsObject: (ObjectType) i withHolder: (Node *) n;
-(int) iGetIndexOfItem: (ObjectType) i;
-(int) rGetIndexOfItem: (ObjectType) i withCounter: (int) index andHolder: (Node *) n;
-(ObjectType) rRemoveObjectAtIndex: (int) index withHolder: (Node *) n;
-(ObjectType) iRemoveObjectAtIndex: (int) index;
-(int) iRemoveFirstOccurenceOf: (ObjectType) i; //returns the index of the item, -1 if not in list.
-(int) rRemoveFirstOccurenceOf:(ObjectType)i withCounter: (int) c andHolder: (Node *) n;
-(NSString *) igetItemAtIndex: (int) index;
-(NSString *) rGetItemAtIndex: (int) index withHolder: (Node *) n;
-(int) rCheckCountOfItem: (ObjectType) i withCounter: (int) c andHolder: (Node *) n;
-(int) iCheckCountOfItem: (ObjectType) i;


@end
#endif /* LinkedList_h */
