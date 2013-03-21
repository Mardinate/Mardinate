//
//  CLLocation+Mardinate.m
//  Mardinate
//

#import "CLLocation+Mardinate.h"
#import "OMardinate.h"

@implementation CLLocation (Mardinate)

- (CLLocation*)mardinateFix
{
    return [OMardinate convertWGS84Location:self];
}

@end
