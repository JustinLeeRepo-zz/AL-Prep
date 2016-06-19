//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Justin Lee on 6/17/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
//property is weak b/c label is held strongly by view itself
//view will keep the label in the heap, so no strong pointer is necessary to keep in label in heap
//if label ever leaves the view, it will leave the heap and pointer will be set to nil
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//Assignment 1 Required Task 3
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

@synthesize deck = _deck;

- (Deck *)deck
{
	//Assignment 1 Required Task 4
	if (!_deck) {
		//Assignment 1 Hint 1
		_deck = [[PlayingCardDeck alloc] init];
	}
	return _deck;
}

- (void)setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
	NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender
{
	if ([sender.currentTitle length]) {
		
		[sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
						  forState:UIControlStateNormal];
		[sender setTitle:@"" forState:UIControlStateNormal];
	} else {
		[sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
						  forState:UIControlStateNormal];
		Card *randomDrawnCard = [self.deck drawRandomCard];
		//Assignment 1 Task 5
		if(!randomDrawnCard){
			//Assignment 1 Hint 3
			self.deck = [[PlayingCardDeck alloc] init];
			[sender setTitle:[NSString stringWithFormat:@"%@", [self.deck drawRandomCard].contents] forState:UIControlStateNormal];
		} else {
			[sender setTitle:[NSString stringWithFormat:@"%@", randomDrawnCard.contents] forState:UIControlStateNormal];
		}
	}
	self.flipCount++;
}


@end
