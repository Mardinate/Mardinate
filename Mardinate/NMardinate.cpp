//
//  NMardinate.cpp
//  Mardinate
//

#include "NMardinate.h"
#include "Mardinate.h"

void NMardinate::ConvertWGS84Coordinate(double wLatitude,
                                        double wLongitude,
                                        double& mLatitude,
                                        double& mLongitude)
{
    MardinateConvertWGS84Coordinate(wLatitude, wLongitude, &mLatitude, &mLongitude);
}
