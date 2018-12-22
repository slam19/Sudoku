//
//  SudokuSolver.h
//  Sudoku
//
//  Created by Simon Lam on 11/11/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef SudokuSolver_h
#define SudokuSolver_h

#import "SudokuBoard.h"
#import "Stack.h"
#import "Queue.h"

@interface SudokuSolver: NSObject

@property id delegate;
@property bool popping;
@property SudokuBoard *sudokuBoard;
@property Stack *stack;
@property Queue *queue;



-(id) initWithDifficulty: (int) difficulty;
-(void) solveBoardDepth;
-(void) solveBoardBreadth;
-(bool) pushAvailableNumbers: (Box *) b;
-(bool) enqueueAvailableNumbers: (Box *) b afterBox: (Box *) p;
-(bool) checkPossibleInteger: (int) bInt forBox: (Box *) b;
-(Box *) getNextFreeBox;
-(void) printBoard;
-(void) fillBoard: (Box *)tail;
-(void) clearBoard;
-(bool) oneDepthMove;
-(id) addGraphics;
-(bool) oneBreadthMove;


@end

@protocol SudokuSolverDelegate<NSObject>;
-(void)updateView:(id) x;

@end


#endif /* SudokuSolver_h */
