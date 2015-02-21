//
//  PlayingCard.m
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)validSuits {
    return @[@"♠︎", @"♥︎", @"♣︎", @"♦︎"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}

@synthesize suit = _suit;

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSString *)description {
    return self.contents;
}

- (int)calcScore:(PlayingCard *)otherCard {
    int score = 0;
    
    // this is either/or because we're dealing from a deck of 52 playing cards
    // and it's not possible to have cards with both the same suit and same rank
    if (otherCard.rank == self.rank) {
        score = 4;
    } else if ([otherCard.suit isEqualToString:self.suit]) {
        score = 1;
    }
    return score;
}

// compare this card against an array of other cards
// return a score representing how "similar" the cards are:
//      cards with the same suit are somewhat similar
//      cards with the same rank are very similar

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        score += [self calcScore:otherCard];
    } else {
        // compare this card against the rest of the array
        for (PlayingCard *card in otherCards) {
            score += [self calcScore:card];
        }
        // now we have to score the tail of the array
        PlayingCard *nextCard = [otherCards firstObject];
        NSRange theRange = {.location = 1, .length = [otherCards count] - 1};
        
        score += [nextCard match:[otherCards subarrayWithRange:theRange]];
    }
    
    return score;
}
@end
