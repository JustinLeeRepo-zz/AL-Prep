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

// protected
// for subclasses
- (Deck *)createDeck; //abstract

@end

