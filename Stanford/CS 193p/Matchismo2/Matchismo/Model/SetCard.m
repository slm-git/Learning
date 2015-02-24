//
//  SetCard.m
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/23/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "SetCard.h"

// "Set" rules:
//      81 cards in a deck
//      each card has four features:
//          Number (one, two, or three)
//          Symbol (diamond, squiggle, oval)
//          Shading (solid, striped, or open)
//          Color (red, green, or purple)

@implementation SetCard

// to start with draw the cards using attributed text
// initially use these characters for symbols: ▲ ● ■


// Matching rules for Set:
//      Set is a three card matching game
//
// Three cards match if:
//      They all have the same number, or they have three different numbers.
//      They all have the same symbol, or they have three different symbols.
//      They all have the same shading, or they have three different shadings.
//      They all have the same color, or they have three different colors.

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    // Set is purely a 3 card game
    if ([otherCards count] == 2) {
        SetCard *cardTwo = otherCards[0];
        SetCard *cardThree = otherCards[1];
        
        if ([SetCard typesMatch:@[@(self.number), @(cardTwo.number), @(cardThree.number)]]
         && [SetCard typesMatch:@[@(self.symbol), @(cardTwo.symbol), @(cardThree.symbol)]]
         && [SetCard typesMatch:@[@(self.shading), @(cardTwo.shading), @(cardThree.shading)]]
         && [SetCard typesMatch:@[@(self.color), @(cardTwo.color), @(cardThree.color)]]) {
            score = 1;
        }
    }
    return score;
}


+ (BOOL)typesMatch: (NSArray *) types{
    BOOL match = NO;
    
    if ([types count] == 3) {
        if (types[0] == types[1] && types[0] == types[2]) {
            match = YES;
        } else if (types[0] != types[1] && types[0] != types[2]
                   && types[1] != types[2]) {
            match = YES;
        }
    }
    return match;
}


- (NSString *)contents {
    return nil;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"(%lu, %lu, %lu, %lu)",
            self.number, self.symbol, self.shading, self.color];
}

@end
