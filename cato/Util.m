//
//  Util.m
//  cato
//
//  Created by Samuel Wilson on 27/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util.h"

@implementation Util
+(int)randomIntWithMax:(int)max min:(int)min
{
	int ret = rand() % max + 1;
	if(ret < min)
		ret = min;
	//printf("\n%d",ret);
	return ret;
}

+(int)randomIntWithMax:(int)max
{
	return [self randomIntWithMax:max min:0];
}
@end
