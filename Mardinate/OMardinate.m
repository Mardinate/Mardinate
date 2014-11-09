//
//  OMardinate.m
//  Mardinate
//

#import "OMardinate.h"
#include "Mardinate.h"

@implementation OMardinate

+ (CLLocationCoordinate2D)convertWGS84Coordinate:(CLLocationCoordinate2D)coordinate
{
    double marsLatitude;
    double marsLongitude;
    MardinateConvertWGS84Coordinate(coordinate.latitude, coordinate.longitude, &marsLatitude, &marsLongitude);
    return CLLocationCoordinate2DMake(marsLatitude, marsLongitude);
}

+ (CLLocation*)convertWGS84Location:(CLLocation*)location
{
    return [[CLLocation alloc] initWithCoordinate:[OMardinate convertWGS84Coordinate:location.coordinate]
                                         altitude:location.altitude
                               horizontalAccuracy:location.horizontalAccuracy
                                 verticalAccuracy:location.verticalAccuracy
                                           course:location.course
                                            speed:location.speed
                                        timestamp:location.timestamp];
}


+ (CLLocationCoordinate2D)addOffset:(CLLocationCoordinate2D)coordinate
{
    double offsetLat;
    double offsetLong;
    
    MardinateAddOffset(coordinate.latitude, coordinate.longitude, &offsetLat, &offsetLong);
    return CLLocationCoordinate2DMake(offsetLat, offsetLong);
}


@end
