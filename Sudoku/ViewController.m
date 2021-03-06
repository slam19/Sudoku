//
//  ViewController.m
//  Sudoku
//
//  Created by Simon Lam on 11/8/18.
//  Copyright © 2018 Simon Lam. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "SudokuSolver.h"
@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
 
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
//
//    SudokuSolver.delegate = self;
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    
}

@end
