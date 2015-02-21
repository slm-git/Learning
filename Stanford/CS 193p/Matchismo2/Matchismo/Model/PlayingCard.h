//
//  PlayingCard.h
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
