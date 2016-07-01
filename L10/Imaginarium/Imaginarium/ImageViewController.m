//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Justin Lee on 7/1/16.
//  Copyright © 2016 Justin Lee. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ImageViewController

- (void)setScrollView:(UIScrollView *)scrollView
{
	_scrollView = scrollView;
	_scrollView.minimumZoomScale = 0.2;
	_scrollView.maximumZoomScale = 2.0;
	_scrollView.delegate = self;
	self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

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
	self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.scrollView addSubview:self.imageView];
}
@end
