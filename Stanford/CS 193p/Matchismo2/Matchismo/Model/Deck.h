//
//  Deck.h
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
