//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Justin Lee on 6/17/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

// Abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (void)updateUI;

// protected
// for subclasses
- (Deck *)createDeck; // abstract
- (NSAttributedString *)titleForCard:(Card *)card; // abstract
- (UIImage *)backgroundImageForCard:(Card *)card; // abstract

@end

