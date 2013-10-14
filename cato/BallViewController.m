//
//  BallViewController.m
//  cato
//
//  Created by Samuel Wilson on 25/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BallViewController.h"
#import "BallView.h"
#import "Util.h"

@interface BallViewController()
@end


@implementation BallViewController
{
	NSMutableArray* images;
}
-(void)initView
{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(userDefaultsDidChange) name:NSUserDefaultsDidChangeNotification object:nil];
    
	images = [NSMutableArray array];
	
	NSArray* imageNames = [NSArray arrayWithObjects:
						   @"ball_blue",
						   @"ball_cyan",
						   @"ball_green",
						   @"ball_orange",
						   @"ball_purple",
						   @"ball_red",
						   @"ball_yellow",
						   @"eye_1", nil];
	
	BallView* view = (BallView*)self.view;
	for(int ctr = 0;ctr < imageNames.count;ctr++)
	{
		NSString* imageName = [NSString stringWithFormat:@"%@.png",[imageNames objectAtIndex:ctr]];
		[images addObject:[UIImage imageNamed:imageName]];
	}
	
	BallViewObject* object;
	for(int ctr = 0;ctr < 10;ctr++)
	{
		object = [[BallViewObject alloc] init];
		object.position = CGPointMake(
									  [Util randomIntWithMax:self.view.bounds.size.width/2 min:0],
									  [Util randomIntWithMax:self.view.bounds.size.height/2 min:0]);
		object.image = [images objectAtIndex:[Util randomIntWithMax:images.count-1]];
		object.xVel = [Util randomIntWithMax:5];
		object.yVel = [Util randomIntWithMax:5];
		
		[view addBallViewObject:object];
	}
    
    [self userDefaultsDidChange];
    
	[view start];
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initView];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
//	[self.timer invalidate];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)userDefaultsDidChange
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    ((BallView*)self.view).soundEnabled = [defaults boolForKey:@"sound_enabled"];
}

@end
