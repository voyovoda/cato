//
//  BallView.h
//  cato
//
//  Created by Samuel Wilson on 25/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallViewObject : NSObject
@property CGPoint position;
@property CGFloat xVel;
@property CGFloat yVel;
@property (nonatomic,strong) UIImage* image;
@end

@interface BallView : UIView
-(void)addImage:(UIImage*)image;
-(void)addBallViewObject:(BallViewObject*)object;

-(void)start;
-(void)stop;

@property BOOL soundEnabled;

@end
