//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/23/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        // loop through the attributes and create an the 81 card Set deck
        for (int number=firstType; number <= lastType; number++) {
            for (int symbol=firstType; symbol <= lastType; symbol++) {
                for (int shading=firstType; shading <= lastType; shading++) {
                    for (int color=firstType; color <= lastType; color++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                        NSLog(@"adding %@", card);
                    }
                }
            }
        }
    }
    return self;
}
@end
