//
//  Maze.h
//  Sudoku
//
//  Created by Simon Lam on 11/9/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef Maze_h
#define Maze_h

#import "Box.h"

@interface SudokuBoard: NSObject

@property NSMutableArray *sudokuBoard;

-(void) loadBoard: (int) difficulty;
-(Box *) getBoxAtRow:(int)r andColumn: (int)c;
-(int) getIntAtRow:(int)r andColumn: (int)c;
-(void) setInt:(int) v AtRow:(int)r andColumn: (int)c;
@end
#endif /* Maze_h */
