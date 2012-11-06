// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMobility.location 1.2

// http://qt-project.org/wiki/QML_Maps_with_Pinch_Zoom
// http://harmattan-dev.nokia.com/docs/library/html/guide/html/Developer_Library_Developing_for_Harmattan_Using_location_and_maps_in_applications_Example_of_displaying_location_data_and_a_map_in_your_application.html

Rectangle { id: mainRect
    color: "black"
    width: 800
    height: 400

    // Iserlohn - Germany
    property double latitude: 51.381111
    property double longitude: 7.695556
    property int  defaultZoomLevel: 15

    //! We stop retrieving position information when component is to be destroyed
    Component.onDestruction: positionSource.stop();

    //! Check if application is active, stop position updates if not
    Connections {
        target: Qt.application
        onActiveChanged: {
            if (Qt.application.active)
                positionSource.start();
            else
                positionSource.stop();
        }
    }

    Map { id: map
        plugin: Plugin { name: "nokia" }
        zoomLevel: mainRect.defaultZoomLevel
        mapType: Map.StreetMap
        anchors.fill: parent

        center: Coordinate {
            latitude: mainRect.latitude
            longitude: mainRect.longitude
        }

        Rectangle { id: mapPlacer
            width: 20
            height: width
            color: "red"
            border.color: "black"
            border.width: 1
            radius: width*0.5
        }
    }

    //! Source for retrieving the positioning information
    PositionSource { id: positionSource

        //! Desired interval between updates in milliseconds
        updateInterval: 10000
        active: true

        //! When position changed, update the location strings
        onPositionChanged: {
            updateGeoInfo()
        }
    }

    function updateGeoInfo() {
        var currentCoord = positionSource.position.coordinate
        latitude = currentCoord.latitude
        longitude = currentCoord.longitude
    }

    PinchArea { id: pincharea
        property double __oldZoom

        anchors.fill: parent

        function calcZoomDelta(zoom, percent) {
            return zoom + Math.log(percent)/Math.log(2)
        }

        onPinchStarted: {
            __oldZoom = map.zoomLevel
        }

        onPinchUpdated: {
            map.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
        }

        onPinchFinished: {
            map.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
        }
    }

    MouseArea { id: mousearea
        property bool __isPanning: false
        property int __lastX: -1
        property int __lastY: -1

        anchors.fill : parent

        onPressed: {
            __isPanning = true
            __lastX = mouse.x
            __lastY = mouse.y
        }

        onReleased: {
            __isPanning = false
        }

        onPositionChanged: {
            if (__isPanning) {
                var dx = mouse.x - __lastX
                var dy = mouse.y - __lastY
                map.pan(-dx, -dy)
                __lastX = mouse.x
                __lastY = mouse.y
            }
        }

        onCanceled: {
            __isPanning = false;
        }
    }
}
