//
//  BallView.m
//  cato
//
//  Created by Samuel Wilson on 25/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BallView.h"
#import "Util.h"
#import "AVFoundation/AVFoundation.h"
#include <AudioToolbox/AudioToolbox.h>

@implementation BallViewObject
@synthesize position = _position;
@synthesize xVel = _xVel;
@synthesize yVel = _yVel;
@synthesize image = _image;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end


@implementation BallView
{
	NSMutableArray* ballViewObjects;
	NSMutableArray* ballImages;
	int frameCtr;
	CFURLRef soundURL;
	SystemSoundID soundID;
	NSTimer* timer;
}

-(void)addImage:(UIImage*)image
{
	[ballImages addObject:image];
}

-(void)addBallViewObject:(BallViewObject*)object
{
	[ballViewObjects addObject:object];
}

-(void)initView
{
	frameCtr = 0;
	ballImages = [NSMutableArray array];
	ballViewObjects = [NSMutableArray array];
	
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"Boing" withExtension:@"aiff"];
	soundURL = (__bridge CFURLRef) url;
	AudioServicesCreateSystemSoundID(soundURL, &soundID);
}

-(void)awakeFromNib
{
	[self initView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self initView];
    }
    return self;
}

-(void)onTimer
{
	[self setNeedsDisplay];
}

-(void)dealloc
{
	AudioServicesDisposeSystemSoundID(soundID);
	CFRelease(soundURL);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	
	for(int ctr = 0;ctr < ballViewObjects.count;ctr++)
	{
		BallViewObject* o = [ballViewObjects objectAtIndex:ctr];
		
		CGPoint pt = o.position;
		if(pt.x < 0 || pt.x > (self.bounds.size.width - o.image.size.width))
		{
			o.xVel = -o.xVel;
            if(self.soundEnabled)
                AudioServicesPlaySystemSound(soundID);
		}
		if(pt.y < 0 || pt.y > (self.bounds.size.height - o.image.size.height))
		{
			o.yVel = -o.yVel;
            if(self.soundEnabled)
                AudioServicesPlaySystemSound(soundID);
		}
		
		pt.x += o.xVel;
		pt.y += o.yVel;
		
		o.position = pt;
	}
	
	CGContextRef  context = UIGraphicsGetCurrentContext();
	
	[[UIColor blackColor] set];
	CGContextFillRect(context, self.bounds);
	
	static UIFont* font = nil;
	if(!font)
	{
		font = [UIFont fontWithName:@"Helvetica" size:20.0];
	}
	
	
	for(int ctr = 0;ctr < ballViewObjects.count;ctr++)
	{
		BallViewObject* o = [ballViewObjects objectAtIndex:ctr];
		CGContextDrawImage(context,
						   CGRectMake(o.position.x, o.position.y, o.image.size.width, o.image.size.height),
									  [o.image CGImage]);
	}
	
	/*NSString* str = [NSString stringWithFormat:@"%d",frameCtr++];
	[[UIColor whiteColor] set];
	[str drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];*/
}

-(void)start
{
	timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

-(void)stop
{
	[timer invalidate];
}

@end
