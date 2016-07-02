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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

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
//	self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
	[self startDownloadingImage];
}

- (void)startDownloadingImage
{
	self.image = nil;
	if (self.imageURL) {
		[self.spinner startAnimating];
		NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
		NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
		NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
														completionHandler:^(NSURL * _Nullable localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
															if (!error) {
																if ([request.URL isEqual:self.imageURL]) {
																	//remote retrieval of data(internet) for above setImageURL
																	//local retrieval of data so no blocking
																	
																	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
																	
																	dispatch_async(dispatch_get_main_queue(), ^{
																		//this must be on main thread cause lots of UI manipulation
																		self.image = image;
																	});
																	//identical to above block
																	//[self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
																	
																}
															}
														}];
		[task resume];
	}
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
	[self.spinner stopAnimating];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.scrollView addSubview:self.imageView];
}
@end
