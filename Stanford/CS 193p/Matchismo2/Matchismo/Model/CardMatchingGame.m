//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/18/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, readwrite) NSArray *lastCards;
@property (nonatomic) NSMutableArray *cards;    // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSArray *)lastCards {
    if (!_lastCards) {
        _lastCards = @[];
    }
    return _lastCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        // default to a two card match game
        self.matchCount = 2;
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

// this needs to communicate back to the controller the results of the choice
// however we haven't learned to do notification yet and we can't change the
// method signature to return a result (assignment restriction)
// so set some public properties to show:
//      how many points were scored
//          positive = a match was made
//          negative = a card was flipped face up w/o making a match
//          zero = a faceup card was flipped down
//      what cards were involved
//          array of up to self.matchCount cards


- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.lastScore = 0;
    self.lastCards = @[];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            // tapping a card that's already been flipped over is how you unchoose cards
            card.chosen = NO;
        }
        else {
            // build array of chosen cards
            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                }
            }
            // if we have the correct number of chosen cards then score them
            if (self.matchCount == (1 + [chosenCards count])) {
                int matchScore = [card match:chosenCards];
                if (matchScore) {
                    self.lastScore += matchScore * MATCH_BONUS;
                    // match all in array
                    for (Card *card in chosenCards) {
                        card.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    self.lastScore -= MISMATCH_PENALTY;
                    // unchoose all in array
                    for (Card *card in chosenCards) {
                        card.chosen = NO;
                    }
                }
            }
            // build the lastCards array
            [chosenCards addObject:card];
            self.lastCards = [chosenCards copy];
            
            self.score -= COST_TO_CHOOSE;
            self.score += self.lastScore;
            card.chosen = YES;
        }
    }
}

@end
