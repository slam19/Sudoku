//
//  Maze.m
//  Sudoku
//
//  Created by Simon Lam on 11/11/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SudokuBoard.h"
#import "Box.h"

@implementation SudokuBoard
-(id) init{
    self = [super init];
    if (self){
        self.sudokuBoard = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) loadBoard:(int) difficulty {
    NSString *puzzle;
    switch (difficulty){
        case 1:
            puzzle = @"EasyPuzzle";
            break;
        case 2:
            puzzle = @"MedPuzzle";
            break;
        case 3:
            puzzle = @"HardPuzzle";
            break;
        case 4:
            puzzle = @"AI Escargot Puzzle";
            break;
        default:
            puzzle = @"EasyPuzzle";
            break;
            
    }
    NSString *myFilePath = [[NSBundle mainBundle] pathForResource:puzzle ofType:@"txt"];
    NSString *linesFromFile = [[NSString alloc] initWithContentsOfFile:myFilePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", linesFromFile);
    
    int index = 0;
    for(int r = 0; r<9; r++){
        NSMutableArray *row = [[NSMutableArray alloc] init];
        for (int c = 0; c<9; c++){
            Box *b = [[Box alloc] initWithRow: r andCol: c];
            NSString *integer=[linesFromFile substringWithRange:NSMakeRange(index, 1)];
            b.value = [integer intValue];
            if(b.value !=0){
                b.fixed=true;
            }
            [row addObject:b];
            //           
            index +=2;
        }
        [self.sudokuBoard addObject:row];
    }
    
    //     NSArray *mazeArray = [linesFromFile componentsSeparatedByString:@"\n"];
    //
    //    [[self.sudokuBoard objectAtIndex:3] objectAtIndex: 1].value = 3;
}

-(Box *) getBoxAtRow:(int)r andColumn: (int)c{
    return [[self.sudokuBoard objectAtIndex:r] objectAtIndex:c];
}

-(int) getIntAtRow:(int)r andColumn: (int) c{
    Box *b =  [[self.sudokuBoard objectAtIndex:r] objectAtIndex:c];
    return b.value;
}
-(void) setInt:(int) v AtRow:(int)r andColumn: (int) c{
    Box *b =  [[self.sudokuBoard objectAtIndex:r] objectAtIndex:c];
    b.value = v;
}



@end

