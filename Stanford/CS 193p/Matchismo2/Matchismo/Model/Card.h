//
//  Card.h
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
