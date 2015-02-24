//
//  SetCard.h
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/23/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

typedef NS_ENUM(NSUInteger, SetCardType) {
    firstType = 1,
    SetCardTypeOne = firstType,
    SetCardTypeTwo,
    setCardTypeThree,
    lastType = setCardTypeThree
};

@property (nonatomic) SetCardType number;
@property (nonatomic) SetCardType symbol;
@property (nonatomic) SetCardType shading;
@property (nonatomic) SetCardType color;
@end
