//
//  SudokuSolver.m
//  Sudoku
//
//  Created by Simon Lam on 11/11/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SudokuSolver.h"
@implementation SudokuSolver

-(id) initWithDifficulty:(int) difficulty{
    self = [super init];
    if (self){
        self.sudokuBoard = [[SudokuBoard alloc] init];
        [self.sudokuBoard loadBoard: difficulty];
        
        self.stack = [[Stack alloc] init];
        self.queue = [[Queue alloc] init];
        self.popping = false;
    }
    
    return self;
}
-(void) solveBoardDepth{ //continuous, used for solution without graphics
    while (true){
        Box *temp = [self getNextFreeBox];
        if(!temp){
            break;
        }
        [temp print];
        if(![self pushAvailableNumbers:temp]){
            while (true){
                Box * b = [self.stack pop];
                [self.sudokuBoard setInt:0 AtRow:b.rowPos andColumn:b.colPos];
                Box * p = [self.stack peek];
                if(b.rowPos==p.rowPos && b.colPos ==p.colPos){
                    [self.sudokuBoard setInt:p.value AtRow:p.rowPos andColumn:p.colPos];
                    [self printBoard];
                    break;
                }
                [self printBoard];
            }
            
        }
        [self printBoard];
        
    }
}

-(bool) oneDepthMove {
    Box *temp = [self getNextFreeBox];
    if(temp){
        [temp print];
        if(self.popping == false){
            if(![self pushAvailableNumbers:temp]){
                self.popping = true;
            } else{
                [self addGraphics];
                [self printBoard];
            }
        }
        if(self.popping == true){
            Box * b = [self.stack pop];
            [self.sudokuBoard setInt:0 AtRow:b.rowPos andColumn:b.colPos];
            Box * p = [self.stack peek];
            if(b.rowPos==p.rowPos && b.colPos ==p.colPos){
                [self.sudokuBoard setInt:p.value AtRow:p.rowPos andColumn:p.colPos];
                [self printBoard];
                self.popping = false;
            }
            [self addGraphics];
            [self printBoard];
            
        }
        return true;
    }else{
        return false;
    }
}



-(void) solveBoardBreadth{ //continuous, used for solution without graphics
    while (true){
        Box *temp = nil;
        if(![self.queue isEmpty]){
            temp = [self.queue dequeue];
            [self fillBoard: temp];
            
            [self printBoard];
            if ( ![self getNextFreeBox]){
                break;
            }
        }
        [self enqueueAvailableNumbers: [self getNextFreeBox] afterBox:temp];
    }
}

-(bool) oneBreadthMove{
    if([self getNextFreeBox]){
        Box *temp = nil;
        if(![self.queue isEmpty]){
            temp = [self.queue dequeue];
            [self fillBoard: temp];
            
            [self printBoard];
            [self addGraphics];
            if ( ![self getNextFreeBox]){
                return false;
            }
        }
        
        [self enqueueAvailableNumbers: [self getNextFreeBox] afterBox:temp];
        
        return true;
    }else{
        return false;
    }
}

-(Box *) getNextFreeBox{
    int r = 0;
    int c = 0;
    Box *temp = [self.sudokuBoard getBoxAtRow:0 andColumn:0];
    while(temp.value!=0){
        if(c<8){
            c++;
        }else{
            r++;
            if(r>8){
                return nil;
            }
            c=0;
        }
        temp =[self.sudokuBoard getBoxAtRow:r andColumn:c];
        
    }
    NSLog(@"%i,%i", r, c);
    return [self.sudokuBoard getBoxAtRow:r andColumn:c];
}

-(bool) pushAvailableNumbers: (Box *) b{
    bool numExists = false;
    for(int i = 9; i>0; i--){
        if([self checkPossibleInteger:i forBox:b]){
            Box *temp = [[Box alloc] initWithRow:b.rowPos andCol:b.colPos];
            temp.value = i;
            //            NSNumber *n = [NSNumber numberWithInt:i];
            [self.stack push:temp];
            [self.sudokuBoard setInt:i AtRow:b.rowPos andColumn:b.colPos];
            NSLog(@"pushed: %i", i);
            numExists = true;
        }
    }
    
    return numExists;
}

-(bool) enqueueAvailableNumbers: (Box *) b afterBox: (Box *) p{
    bool numExists = false;
    
    for (int i = 1; i<10; i++){
        if([self checkPossibleInteger:i forBox:b]){
            Box *temp = [[Box alloc] initWithRow:b.rowPos andCol:b.colPos];
            temp.value = i;
            temp.previous = p; //important
            //            NSNumber *n = [NSNumber numberWithInt:i];
            [self.queue enqueue:temp];
            [self.sudokuBoard setInt:i AtRow:b.rowPos andColumn:b.colPos];
            //            [self.sudokuBoard setLastCheckedVal:i AtRow:b.rowPos andColumn:b.colPos];
            NSLog(@"enqueued: %i", i);
            numExists = true;
        }
    }
    [self clearBoard];
    return numExists;
}

-(bool) checkPossibleInteger: (int) bInt forBox: (Box *) b{
    int bRow = b.rowPos;
    int bCol = b.colPos;
    for(int c = 0; c<9; c++){
        int temp = [self.sudokuBoard getIntAtRow:bRow andColumn:c];
        if(temp == bInt){
            return false;
        }
    }
    for(int r = 0; r<9; r++){
        int temp = [self.sudokuBoard getIntAtRow:r andColumn:bCol];
        if(temp == bInt){
            return false;
        }
    }
    int rowThreeByThree = bRow - (bRow%3);
    int colThreeByThree = bCol - (bCol%3);
    
    for(int r = 0; r<3; r++){
        for(int c= 0; c<3; c++){
            if(bInt == [self.sudokuBoard getIntAtRow:rowThreeByThree andColumn:colThreeByThree]){
                return false;
            }
            colThreeByThree++;
        }
        colThreeByThree = bCol - (bCol%3);
        rowThreeByThree++;
    }
    
    return true;
}

-(void) printBoard{
    for(int r=0;r<9;r++){
        for(int c = 0; c<9;c++){
            int i =[self.sudokuBoard getIntAtRow:r andColumn:c];
            printf("%i ",i);
            
        }
        printf("\n");
    }
}

-(void) fillBoard: (Box *)tail{
    Box *temp = tail;
    while(temp){
        [self.sudokuBoard setInt:temp.value AtRow:temp.rowPos andColumn:temp.colPos];
        temp=temp.previous;
    }
}

-(void) clearBoard{
    for(int r = 0; r<9; r++){
        for(int c= 0; c<9;c++){
            Box * b = [self.sudokuBoard  getBoxAtRow:r andColumn:c];
            if(!b.fixed){
                [self.sudokuBoard setInt:0 AtRow:r andColumn:c];
            }
        }
    }
}

-(id) addGraphics{
    [self.delegate updateView:self.sudokuBoard];
    return self.sudokuBoard;
}


@end
