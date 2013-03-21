/*
 * NOTE
 * -------------------------------------------------------------------------------------------------
 * This piece of code is derived from the C# implementation found at
 * https://on4wp7.codeplex.com/SourceControl/changeset/view/21455#353936
 *
 * Original author unknown.
 */

#include "Mardinate.h"

#include <math.h>

//
// Krasovsky 1940
//
// a = 6378245.0, 1 / f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
const double kA = 6378245.0;
const double kEE = 0.00669342162296594323;

double CalcLatitudeOffset(double x, double y)
{
    double ret;
    ret  = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

double CalcLongitudeOffset(double x, double y)
{
    double ret;
    ret  = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

int IsOutOfMainlandChina(double latitude, double longitude)
{
    if (latitude < 0.8293 || latitude > 55.8271)
    {
        return 1;
    }

    if (longitude < 72.004 || longitude > 137.8347)
    {
        return 1;
    }

    return 0;
}

void MardinateConvertWGS84Coordinate(double wLatitude, double wLongitude, double* mLatitude, double* mLongitude)
{
    if (IsOutOfMainlandChina(wLatitude, wLongitude))
    {
        if (mLatitude != 0)
        {
            *mLatitude = wLatitude;
        }
        
        if (mLongitude != 0)
        {
            *mLongitude = wLongitude;
        }
    
        return;
    }

    double radLatitude = wLatitude / 180.0 * M_PI;
    double magic = sin(radLatitude);
    magic = 1 - kEE * magic * magic;
    double sqrtMagic = sqrt(magic);

    if (mLatitude != 0)
    {
        double latitudeOffset = CalcLatitudeOffset(wLongitude - 105.0, wLatitude - 35.0);
        latitudeOffset = (latitudeOffset * 180.0) / ((kA * (1 - kEE)) / (magic * sqrtMagic) * M_PI);
        *mLatitude = wLatitude + latitudeOffset;
    }

    if (mLongitude != 0)
    {
        double longitudeOffset = CalcLongitudeOffset(wLongitude - 105.0, wLatitude - 35.0);
        longitudeOffset = (longitudeOffset * 180.0) / (kA / sqrtMagic * cos(radLatitude) * M_PI);
        *mLongitude = wLongitude + longitudeOffset;
    }
}
