//
//  ViewController.h
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

// for subclasses
- (Deck *)createDeck;

@end

