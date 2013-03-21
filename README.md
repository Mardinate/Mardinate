#Mardinate

China Map Coordinate Fix / WGS84 Coorindate to Mars Coordinate Conversion without database lookup.

##Usage

###C Interface

```
#include "Mardinate.h"

void MardinateConvertWGS84Coordinate(double wLatitude, double wLongitude, double* mLatitude, double* mLongitude);
```

###Objective-C Interface

```
#import "OMardinate.h"

+ (CLLocationCoordinate2D)convertWGS84Coordinate:(CLLocationCoordinate2D)coordinate;
+ (CLLocation*)convertWGS84Location:(CLLocation*)location;
```

###CLLocation Category

```
#import "CLLocation+Mardinate.h"

- (CLLocation*)mardinateFix;
```

##Comparsion with MapKit's result

MapKit has built-in China map coorindate fix when retriving user location from MKMapView.
Preliminary tests show the distance between MapKit's result and Mardinate's result is about 0.5 meters to 5 meters.

##Credits
This piece of code is just a port of the C# implementation found [here](https://on4wp7.codeplex.com/SourceControl/changeset/view/21455#353936).
All credits goes to the original, anonymous, author.
