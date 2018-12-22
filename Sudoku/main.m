//
//  main.m
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SudokuSolver.h"

int main(int argc, const char * argv[]) {
    //*UNCOMENT BELOW TO SOLVE WITHOUT GRAPHICS!!!*
//     @autoreleasepool {
//
//         SudokuSolver *sudokuSolver = [[SudokuSolver alloc] initWithDifficulty:4]; //change puzzle difficulty here (between 1-4)
//
//         int searchMethod = 1; //change search method here: 0 is depth, 1 is breadth
//
//         if(searchMethod ==0){
//             [sudokuSolver solveBoardDepth];
//         }
//         if(searchMethod ==1){
//             [sudokuSolver solveBoardBreadth];
//         }
//     }
//    return 0;

    return NSApplicationMain(argc, argv); //comment out this line if solving without graphics
    
}
