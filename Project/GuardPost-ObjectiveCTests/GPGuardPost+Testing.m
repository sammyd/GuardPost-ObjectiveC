//
//  GPGuardPost+Testing.m
//  GuardPost-ObjectiveC
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "GPGuardPost+Testing.h"
#import "GPMailgunClient+Testing.h"

@implementation GPGuardPost (Testing)

+ (void)resetAPIKey
{
    [[GPMailgunClient sharedClient] resetAPIKey];
}

@end
