//
//  ViewController.m
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deck;
@end

@implementation ViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                      forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
                          forState:UIControlStateNormal];
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [sender setTitle:[card contents] forState:UIControlStateNormal];
            if ([[card contents] rangeOfString:@"♠︎"].location == NSNotFound &&
                [[card contents] rangeOfString:@"♣︎"].location == NSNotFound) {
                [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            } else {
                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        else {
            // when done with the deck just disable the button
            [sender setEnabled:NO];
        }
    }
    self.flipCount++;
}


@end
