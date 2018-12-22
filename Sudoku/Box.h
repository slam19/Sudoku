//
//  Box.h
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#ifndef Box_h
#define Box_h
@interface Box: NSObject

@property int rowPos, colPos, value;
@property bool fixed;
@property Box *previous;


-(id) initWithRow: (int) r andCol: (int) c;
-(void) print;

@end
#endif /* Box_h */
