#ifndef GPSTOOLS_H
#define GPSTOOLS_H

#include <QObject>
#include <QGeoPositionInfoSource>
using namespace QtMobility;

class GPSTools : public QObject
{
    Q_OBJECT
public:
    explicit GPSTools(QObject *parent = 0);

    void calculateValues() {
        QGeoPositionInfoSource * geoPositionInfoSource;

    }
    
signals:
    
public slots:
    
};

#endif // GPSTOOLS_H
