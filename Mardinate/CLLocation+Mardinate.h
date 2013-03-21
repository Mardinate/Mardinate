//
//  CLLocation+Mardinate.h
//  Mardinate
//

#pragma once

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Mardinate)

- (CLLocation*)mardinateFix;

@end
