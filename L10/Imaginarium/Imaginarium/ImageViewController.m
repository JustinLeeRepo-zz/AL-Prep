//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Justin Lee on 7/1/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ImageViewController

- (void)setImageURL:(NSURL *)imageURL
{
	_imageURL = imageURL;
	//dataWithContentsOfURL WILL BLOCK MAIN QUEUE
	self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
	
	
}

- (UIImageView *)imageView
{
	if (!_imageView) _imageView = [[UIImageView alloc] init];
	return _imageView;
}

- (UIImage *)image
{
	return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
	self.imageView.image = image;
	[self.imageView sizeToFit];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.view addSubview:self.imageView];
}
@end
