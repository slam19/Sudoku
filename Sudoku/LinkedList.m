//
//  LinkedList.m
//  LinkedList
//
//  Created by Simon Lam on 10/9/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "LinkedList.h"
@implementation LinkedList

-(NSString *)readInputString{
    char cInputString[40]; //max length 40
    scanf("%s", cInputString); //scanf does not include spaces
    NSString *item = [NSString stringWithCString:cInputString encoding:1];
    return item;
}

-(void)printInstructions{
    NSString *instructions = [NSString stringWithFormat:@"\n Operations: \n"
                              "0: Quit \n"
                              "1: Add item (iterative) \n"
                              "2: Add item (recursive) \n"
                              "3: Add as first item \n"
                              "4: Clear list\n"
                              "5: Check if list contains item (iterative)\n"
                              "6: Check if list contains item (recursive) \n"
                              "7: Display list (iterative) \n"
                              "8: Display list (recursive) \n"
                              "9: Get item at index (iterative) \n"
                              "10: Get item at index (recursive) \n"
                              "11: Get first item \n"
                              "12: Get index of item (iterative)\n"
                              "13: Get index of item (recursive)\n"
                              "14: Remove item at index (iterative)\n"
                              "15: Remove item at index (recursive)\n"
                              "16: Remove first occurence of item (iterative) \n"
                              "17: Remove first occurence of item (recursive) \n"
                              "18: Calculate size of list (iterative)\n"
                              "19: Calculate size of list (recursive)\n"
                              "20: Check the count of an item in list (iterative) \n"
                              "21: Check the count of an item in list (recursive) \n"
                              "22: Print instructions \n"
                              "*items begin numbering from 1.\n"
                              ];
    NSLog(@"%@",instructions);
}

-(int) readOperation{ //returns user inputted operation
    int operation;
    NSLog(@"Input operation number:");
    scanf("%i", &operation);
    return operation;
}


-(void) iAdd: (id) i{ //stores i in a new node added to the end of list.
    Node *temp = self.first;
    Node *n = [[Node alloc] initWithItem: i];
    
    if(self.first == nil){
        self.first = n; //need to initialize first node if list is empty.
    }else{
        while (temp.next!= nil){
            temp = temp.next;
        }
        temp.next = n;
    }
}

-(void) rAdd: (id) i  withHolder : (Node *) n{ //stores i in a new node added to the end of list.
    if(!n){//check if first node exists
        Node *new = [[Node alloc] initWithItem: i];
        self.first = new; //initialize first node
    }else if(!n.next){
        Node *new = [[Node alloc] initWithItem: i];
        n.next=new;
    }else{
        [self rAdd: i withHolder: n.next];
    }
}


-(void) addFirst: (id) i{ //stores item in a new first node.
    Node *n = [[Node alloc] initWithItem: i];
    n.next = self.first;
    self.first = n;
}

-(void) clear {
    self.first = nil;
}

-(void) iDisplayList {
    Node *temp = self.first;
    if (!temp){
        NSLog(@"Shopping list is empty.");
    }else {
        while (temp){
            NSLog(@"Item: %@", [temp itemName]);
            temp = temp.next;
        }
    }
}

-(void) rDisplayList: (Node *) n {
    if(!n){ //if first node does not exist to begin with.
        NSLog(@"Shopping list is empty.");
    }else if(!n.next){ //base case, prints last item
        NSLog(@"Item: %@", [n itemName]);
    }else{
        NSLog(@"Item: %@", [n itemName]);
        [self rDisplayList: n.next];
    }
}

-(NSString *) getFirstItemName {
    NSString *itemName = [self.first itemName];
    return itemName;
}

-(int) iSize {
    int size = 0;
    Node *temp = self.first;
    while (temp){
        size++;
        temp = temp.next;
    }
    return size;
}

-(bool) iContainsObject:(id)i{
    Node *temp = self.first;
    while(temp){
        if([temp.item isEqual: i]){
            return true;
        }
        temp = temp.next;
    }
    return false;
}

-(bool) rContainsObject: (id) i withHolder: (Node *) n{
    if(!n){
        return false; //if traversed through entire list without ever returning true, return false.
    }else{
        if([n.item isEqual:i]){
            return true;
        }
        return [self rContainsObject: i withHolder: n.next];
    }
}

-(int) rSize: (int) counter withHolder : (Node *) n{
    if(!n.item){ //cover scenario in which first node exists, but has no item.
        return counter;
    }else{
        counter++;
        return [self rSize: counter withHolder: n.next];
    }
}

-(int) iGetIndexOfItem:(id)i{
    int index = 1;
    Node *temp = self.first;
    while (temp.item){ //because first node exists, but doesnt necessarily have an item.
        if([temp.item isEqual: i]){
            return index;
        }
        index++;
        temp = temp.next;
    }
    return -1; //if item doesnt exist.
}

-(int) rGetIndexOfItem:(id)i withCounter: (int) index andHolder : (Node *) n{ 
    if(!n){
        return -1; //if item doesnt exist
    }else{
         //1 is the first item.
        if([n.item isEqual:i]){
            return index;
        }
        index++;

        return [self rGetIndexOfItem:i withCounter: index andHolder: n.next];
    }
}

-(NSString *) iRemoveObjectAtIndex:(int)index{ //returns name of removed item
    NSString *itemName;
    if(index == 1){
        itemName = [self.first itemName];
        self.first = self.first.next; //need to redefine self.first if the first item is removed.
        return itemName;
    }else{
        Node *temp = self.first;
        for(int i = 1; i<index-1; i++){ //end up on item before the one that will be removed.
            temp=temp.next;
        }
        itemName = [temp.next itemName];
        temp.next = temp.next.next;
        return itemName; //returns nil if index reaches beyond list.
    }
}

-(NSString *) rRemoveObjectAtIndex: (int) index withHolder: (Node *) n{ //returns name of removed item
    NSString * itemName;
    if(index == 1){ //need to redefine self.first if the first item is removed.
        itemName = [n itemName];
        self.first = n.next;
        return itemName;
    }else if (index == 2){
            itemName = [n.next itemName];
            n.next = n.next.next;
            return itemName;
    }else{
        index--; //treat index like a counter
        if(!n.next){ //checks if next node exists or not so that method does not need to over-run.
            return nil;
        }
        return [self rRemoveObjectAtIndex: index withHolder: n.next];
    }
}

-(int) iRemoveFirstOccurenceOf:(id)i{ //returns the index of the removed item.
    Node *temp = self.first;
    int counter = 1;
    if([temp.item isEqual: i]){//reset the first node if item is first.
        self.first = self.first.next;
        return counter;
    }
    
    while(temp){ //while the node that is checked is within list
        counter ++; //start checking from second item;
            if([temp.next.item isEqual: i]){
                temp.next = temp.next.next;
                return counter;
            }
        temp = temp.next;
    }
    
    return -1; //if nothing has been returned, then return -1 to indicate that item is not in list.
}

-(int) rRemoveFirstOccurenceOf:(id)i withCounter: (int) c andHolder: (Node *) n{ //returns index of removed item.
    if(!n){ //if reaches beyond the list without finding item and returning true, then return false.
        return -1;
    }else{
        if(c==1 && [n.item isEqual: i]){ //if first occurence is first item, need to reinitialize list.
                self.first = self.first.next;
                return c;
        }else{
            c++;
            if([n.next.item isEqual: i]){
                n.next = n.next.next;
                return c;
            }
            return [self rRemoveFirstOccurenceOf:i withCounter: c andHolder:n.next];
    }

    }
}

-(NSString *) igetItemAtIndex:(int)index{ //returns name of item
    Node *temp = self.first;
    for(int i =1; i<index; i++){ //first item has index 1.
        temp=temp.next;
    }
    if(!temp || index<1){ //if reaches beyond list on both ends (below index 1 or further than last item)
        return nil;
    }else{
        return [temp itemName];
    }
}

-(NSString *) rGetItemAtIndex: (int) index withHolder: (Node *) n{ //returns name of item
    if (!n){
        return nil;
    }else{
        if(index == 1){
            return[n itemName];
        }
        index--;
        return [self rGetItemAtIndex:index withHolder:n.next];
    }
}

-(int) rCheckCountOfItem:(id)i withCounter: (int) c andHolder:(Node *)n{ //counts the number of repetitions of any item in the list.
    if(!n){
        return c;
    }else{
        if([n.item isEqual:i]){
            c++;
        }
        return [self rCheckCountOfItem: i withCounter: c andHolder: n.next];
    }
}

-(int) iCheckCountOfItem:(id)i{
    int count = 0;
    Node *temp = self.first;
    while (temp){
        if([temp.item isEqual:i]){
            count++;
        }
        temp=temp.next;
    }
    return count;
}



@end
