//
//  ViewController.m
//  Matchismo
//
//  Created by Stephen L. Mitchell on 2/17/15.
//  Copyright (c) 2015 slm. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) BOOL started;
@property (nonatomic) NSMutableArray *history;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *startNewGameButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (weak, nonatomic) IBOutlet UISlider *histSlider;
@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (NSMutableArray *)history {
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchGameSelector:(UISegmentedControl *)sender {
    // toggling between two card matches and three card matches
}

- (IBAction)touchNewGame:(UIButton *)sender {
    // release the current game start a new game
    self.game = nil;

    self.started = NO;  // the game doesn't start until the first flip
    [self updateUI];    // this will create a new game via lazy instantiation
}

- (IBAction)touchCardButton:(UIButton *)sender {
    unsigned long chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    if (!self.started) {
        [self startGame];
    }

    [self updateUI];
}

- (void)startGame {
    // zero corresponds to 2 card game, 1 to 3 card game
    // is there a way to associate the numbers with the control?
    self.game.matchCount = self.gameTypeControl.selectedSegmentIndex + 2;
    self.started = YES;
    self.resultLabel.text = [NSString stringWithFormat:@"Starting a new %ld card match game",
                             (long)self.game.matchCount];
}

// from the instructions:
//      Examples: “Matched J♥ J♠ for 4 points.” or “6♦ J♣ don’t match! 2 point penalty!” or
//      “8♦” if only one card is chosen or even blank if no cards are chosen.

// determine the status of the last touch:
//      1) a chosen card was unchosen
//          status ex: "8♦” or blank if no cards chosen
//
//      2) an unchosen card was chosen, but not enough cards to make a match
//          status ex: "J♥ J♠" or "J♥"
//
//      3) an unchosen card was chosen and a match was made
//          status ex: "J♥ J♠" matched for %d points."
//
//      4) an unchosen card was chosen and a match failed
//          status ex: “6♦ J♣ don’t match! 2 point penalty!”

- (NSString *)buildStatus {
    NSInteger points = self.game.lastScore;
    
    // display the cards involved
    NSMutableString *status = [[NSMutableString alloc] init];
    for (Card *card in self.game.lastCards) {
        [status appendFormat:@"%@ ", card.contents];
    }
    
    if (points == 0) {
        // display all of the cards currently chosen, if any
        if ([self.game.lastCards count]) {
            [status appendFormat:@"chosen."];
        }
    } else if (points < 0) {
        // display all cards that didn't match and penalty amount
        [status appendFormat:@"don't match. %ld point penalty.", ABS((long)points)];
    } else {
        // display all cards that matched and points scored
        [status appendFormat:@"matched for %ld points.", (long)points];
    }
    
    [self.history addObject:status];
    return status;
}

- (void)updateUI {
    // draw all the card buttons
    for (UIButton *cardButton in self.cardButtons) {
        unsigned long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card  = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    
    // updating the status as the result of a touch means we're no longer
    // viewing history
    self.resultLabel.alpha = 1.0;
    self.histSlider.value = 0.96;
    self.resultLabel.text = [self buildStatus];
    
    // user is allowd to toggle the game type only if a game hasn't started
    self.gameTypeControl.enabled = !self.started;
}

// when the slider is moved display the history of the game in the status field
- (IBAction)historySlider:(UISlider *)sender {
    int index = sender.value * [self.history count];

    if ([self.history count]) {
        // gray out the text to indicate it's history
        self.resultLabel.alpha = 0.5;
        self.resultLabel.text = [self.history objectAtIndex:index];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardFront": @"cardBack"];
}
@end
