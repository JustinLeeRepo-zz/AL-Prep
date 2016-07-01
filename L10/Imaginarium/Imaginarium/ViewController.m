//
//  ViewController.m
//  Imaginarium
//
//  Created by Justin Lee on 7/1/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue destinationViewController] isKindOfClass:[ImageViewController class]]) {
		ImageViewController *imageViewController = (ImageViewController *)segue.destinationViewController;
		imageViewController.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier]];
		imageViewController.title = segue.identifier;
	}
}
@end
