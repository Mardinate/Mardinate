//
//  OMardinate.h
//  Mardinate
//

#pragma once

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OMardinate : NSObject

+ (CLLocationCoordinate2D)convertWGS84Coordinate:(CLLocationCoordinate2D)coordinate;
+ (CLLocation*)convertWGS84Location:(CLLocation*)location;

@end
