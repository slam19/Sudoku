//
//  GameScene.m
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import "GameScene.h"



@implementation GameScene {
    
    SKLabelNode *label;
    SKLabelNode *instructions;
    SKLabelNode *easyText;
    SKLabelNode *mediumText;
    SKLabelNode *hardText;
    SKLabelNode *aiescText;
    SKLabelNode *speedText;
    SKLabelNode *solveModeText;
    NSMutableArray *depthBoxes;
    NSMutableArray *breadthBoxes;
    int solveMode;
    int difficulty;
    bool begin;
    bool isSpacePressed;
    CFTimeInterval timePerMove;
    CFTimeInterval startTime;
    CFTimeInterval elapsed;
    bool isFinished;
    SudokuSolver *sudokuSolver;
    //
    //    SKLabelNode *
    
}


-(void) DepthView{
    for(int r=0;r<9;r++){
        for (int c=0; c<9; c++){
            label = [SKLabelNode labelNodeWithText:@"0"];
            [label setFontSize:60];
            [label setPosition:CGPointMake(-400.0 +80*c, 300 - 80*r)];
            [depthBoxes addObject:label];
        }
    }
    for(int i=0;i<81;i++){
        [self addChild:[depthBoxes objectAtIndex:i]];
    }
    [sudokuSolver addGraphics];
}

-(void) BreadthView{
    for(int a = 0; a<81;a++){
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        for(int i = 1; i<10; i++){
            NSString *s = [NSString stringWithFormat:@"%d",i];
            label = [SKLabelNode labelNodeWithText:s];
            [label setFontSize:20];
            [label setPosition:CGPointMake(-420.0 +20*((i-1)%3) + (a%9)*80, 330- 20*((i-1)/3) -(a/9)*80)];
            [numbers addObject:label];
            [self addChild:label];
        }
        [breadthBoxes addObject:numbers];
    }
    [sudokuSolver addGraphics];
}

-(void) setUp{
    depthBoxes = [[NSMutableArray alloc] init];
    breadthBoxes = [[NSMutableArray alloc] init];
    instructions = [SKLabelNode labelNodeWithText:@"Enter key: Breadth/Depth"];
    [instructions setFontSize:20];
    [instructions setPosition:CGPointMake(390,260)];
    [self addChild:instructions];
    
    instructions =[SKLabelNode labelNodeWithText:@"Up/Down key: +/- speed"];
    [instructions setFontSize:20];
    [instructions setPosition:CGPointMake(390,200)];
    [self addChild:instructions];
    
    instructions =[SKLabelNode labelNodeWithText:@"Space bar: start/stop search"];
    [instructions setFontSize:20];
    [instructions setPosition:CGPointMake(390,230)];
    [self addChild:instructions];
    
    instructions =[SKLabelNode labelNodeWithText:@"Left/Right key: difficulty"];
    [instructions setFontSize:20];
    [instructions setPosition:CGPointMake(390,170)];
    [self addChild:instructions];
    
    easyText =[SKLabelNode labelNodeWithText:@"Easy"];
    [easyText setFontSize:25];
    [easyText setPosition:CGPointMake(-400,355)];
    [self addChild:easyText];
    
    mediumText =[SKLabelNode labelNodeWithText:@"Medium"];
    [mediumText  setFontSize:25];
    [mediumText  setPosition:CGPointMake(-200,355)];
    [self addChild:mediumText];
    
    hardText =[SKLabelNode labelNodeWithText:@"Hard"];
    [hardText setFontSize:25];
    [hardText  setPosition:CGPointMake(0,355)];
    [self addChild:hardText];
    
    aiescText =[SKLabelNode labelNodeWithText:@"AI-Escargot"];
    [aiescText setFontSize:25];
    [aiescText setPosition:CGPointMake(200,355)];
    [self addChild:aiescText];
    
    switch (difficulty){
        case 1:
            [easyText setFontColor:[SKColor yellowColor]];
            break;
        case 2:
            [mediumText setFontColor:[SKColor yellowColor]];
            break;
        case 3:
            [hardText setFontColor:[SKColor yellowColor]];
            break;
        case 4:
            [aiescText setFontColor:[SKColor yellowColor]];
            break;
        default:
            break;
    }
    
    solveModeText = [SKLabelNode labelNodeWithText:@"Depth"];
    if(solveMode==1){
        [solveModeText setText:@"Breadth"];
    }
    [solveModeText setFontSize:60];
    [solveModeText setPosition:CGPointMake(400,300)];
    [self addChild:solveModeText];
}

- (void)didMoveToView:(SKView *)view {
    difficulty = 1;
    isFinished = false;
    sudokuSolver = [[SudokuSolver alloc] initWithDifficulty:difficulty ];
    sudokuSolver.delegate =self;
    timePerMove = 0.02;
    begin = false;
    solveMode = 0;
    [self setUp];
    [self DepthView];
}

-(void) updateView: (SudokuBoard *) s{
    if(solveMode ==0){
        int x = 0;
        for (int r =0; r<9; r++){
            for(int c = 0; c<9; c++){
                Box* b = [s getBoxAtRow:r andColumn:c];
                NSString *y = [NSString stringWithFormat:@"%d",  b.value];
                SKLabelNode *k = [depthBoxes objectAtIndex: x];
                if(b.fixed){
                    k.fontColor = [SKColor redColor];
                }
                [k setText:y];
                x++;
            }
        }
    }
    
    if(solveMode == 1){
        int x = 0;
        for (int r =0; r<9; r++){
            for(int c = 0; c<9; c++){
                Box *b = [s getBoxAtRow: r andColumn: c];
                int pos = b.value -1;
                if(pos!= -1){
                    SKLabelNode *l = [[breadthBoxes objectAtIndex:x] objectAtIndex:pos];
                    if(b.fixed){
                        l.fontColor = [SKColor redColor];
                    }else{
                        if(isFinished){
                            l.fontColor = [SKColor yellowColor];
                        }else{
                            l.fontColor = [SKColor greenColor];
                        }
                    }
                }
                x++;
            }
        }
    }
}


- (void)keyDown:(NSEvent *)theEvent { //should not change solve mode or puzzle difficulty after search has started
    switch (theEvent.keyCode) {
        case 0x24  /* SPACE is 0x31 */:
            // Run 'Pulse' action from 'Actions.sks'
            if(!begin){
                if(solveMode ==1){
                    solveMode = 0;
                    [self removeAllChildren];
                    [self setUp];
                    [self DepthView];
                    [solveModeText setText:@"Depth"];
                }else{
                    solveMode = 1;
                    [self removeAllChildren];
                    [self setUp];
                    [self BreadthView];
                    [solveModeText setText: @"Breadth"];
                    
                }
            }
            break;
            
        case 0x31:
            isSpacePressed = !isSpacePressed;
            break;
            
        case 0x7B:
            if(!begin){
                if(difficulty==2){
                    [easyText setFontColor:[SKColor yellowColor]];
                    [mediumText setFontColor:[SKColor whiteColor]];
                }
                if(difficulty==3){
                    [mediumText setFontColor:[SKColor yellowColor]];
                    [hardText setFontColor:[SKColor whiteColor]];
                }
                if(difficulty ==4){
                    [hardText setFontColor:[SKColor yellowColor]];
                    [aiescText setFontColor:[SKColor whiteColor]];
                    
                }
                if(difficulty!=1){
                    difficulty--;
                    [self removeAllChildren];
                    isFinished = false;
                    sudokuSolver = [[SudokuSolver alloc] initWithDifficulty:difficulty ];
                    sudokuSolver.delegate =self;
                    timePerMove = 0.05;
                    begin = false;
                    [self setUp];
                    if(solveMode==0){
                        [self DepthView];
                    }else{
                        [self BreadthView];
                    }
                }
            }
            break;
            
        case 0X7C:
            if(!begin){
                if(difficulty==1){
                    [easyText setFontColor:[SKColor whiteColor]];
                    [mediumText setFontColor:[SKColor yellowColor]];
                }
                if(difficulty==2){
                    [mediumText setFontColor:[SKColor whiteColor]];
                    [hardText setFontColor:[SKColor yellowColor]];
                }
                if(difficulty ==3){
                    [hardText setFontColor:[SKColor whiteColor]];
                    [aiescText setFontColor:[SKColor yellowColor]];
                }
                if(difficulty!=4){
                    difficulty++;
                    [self removeAllChildren];
                    isFinished = false;
                    sudokuSolver = [[SudokuSolver alloc] initWithDifficulty:difficulty ];
                    sudokuSolver.delegate =self;
                    timePerMove = 0.05;
                    begin = false;
                    [self setUp];
                    if(solveMode==0){
                        [self DepthView];
                    }else{
                        [self BreadthView];
                    }
                }
            }
            break;
        case 0x7E:
            timePerMove = timePerMove/2;
            break;
            
        case 0x7D:
            timePerMove = timePerMove*2;
            break;
            
        default:
            NSLog(@"keyDown:'%@' keyCode: 0x%02X", theEvent.characters, theEvent.keyCode);
            break;
    }
}


- (void)mouseUp:(NSEvent *)theEvent {
    
    
    
}



-(void)update:(CFTimeInterval)currentTime {
    if(isSpacePressed && !isFinished){
        if(!begin){
            begin = true;
            startTime = currentTime;
        }
        else{
            elapsed = currentTime - startTime;
            if(elapsed >timePerMove){
                startTime = currentTime;
                if(solveMode==0){
                    if(![sudokuSolver oneDepthMove]){
                        isFinished = true;
                    }
                }
                if(solveMode ==1){
                    if(![sudokuSolver oneBreadthMove]){
                        isFinished = true;
                    }
                }
                
            }
        }
    }
    if(isFinished && solveMode==1){
        [sudokuSolver addGraphics];
    }
    
    
    
    // Called before each frame is rendered
    
    
    
}
@end
