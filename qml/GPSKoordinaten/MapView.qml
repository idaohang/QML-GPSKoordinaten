// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMobility.location 1.2

// http://qt-project.org/wiki/QML_Maps_with_Pinch_Zoom
// http://harmattan-dev.nokia.com/docs/library/html/guide/html/Developer_Library_Developing_for_Harmattan_Using_location_and_maps_in_applications_Example_of_displaying_location_data_and_a_map_in_your_application.html
// http://doc.qt.digia.com/qtmobility/qml-location-plugin.html

// http://www.developer.nokia.com/Community/Wiki/How_to_create_a_Page_Control_component_in_QML

Rectangle { id: mainRect
    color: "black"
    width: 800
    height: 400

    signal target(double latitude, double longitude, double altitude)

    property Coordinate centerPosition: Coordinate {
        latitude: (currentPosition.latitude + targetPosition.latitude) / 2.0
        longitude: (currentPosition.longitude + targetPosition.longitude) / 2.0
        altitude: 0.0
    }

    // Berlin - Germany
    property Coordinate currentPosition: Coordinate {
        latitude: 52.50568190
        longitude: 13.32320270
        altitude: 0.0
    }

    // Iserlohn - Germany
    property Coordinate targetPosition: Coordinate {
        latitude: 51.381111
        longitude: 7.695556
        altitude: 0.0
    }

    property int meter: 0
    property double lineLength: 0

    property int currentPositionX: 0
    property int currentPositionY: 0
    property int targetPositionX: 0
    property int targetPositionY: 0

    property double distance: 0
    property double bearing: 0

    property int fontSize: 14

    Component.onCompleted: {
        setTarget(targetPosition.latitude, targetPosition.longitude, targetPosition.altitude)
    }

    function toCenter() {
        var dx = (mainRect.width / 2.0) - map.toScreenPosition(centerPosition).x
        var dy = (mainRect.height / 2.0) - map.toScreenPosition(centerPosition).y
        map.pan(-dx, -dy)
    }

    // Optimize zoom level
    function optimizeZoom() {
        map.zoomLevel = map.maximumZoomLevel
        toCenter()
        adjustPositions()
        while(map.zoomLevel > map.minimumZoomLevel && (currentPositionX < 0 || currentPositionY < 0 || targetPositionX < 0 || targetPositionY < 0)) {
            map.zoomLevel--
            adjustPositions()
        }
    }

    function setTarget(latitude, longitude, altitude) {
        targetPosition.latitude = latitude
        targetPosition.longitude = longitude
        targetPosition.altitude = altitude

        optimizeZoom()
    }

    function calculateDistance(xA, yA, xB, yB) {
        var xD = xB - xA
        var yD = yB - yA
        return Math.sqrt(xD * xD + yD * yD)
    }

    function formatNumber(number) {
        var strNumber = new String(number)
        var pointPosition = strNumber.indexOf(".")
        if (pointPosition >= 0) {
            return strNumber.substring(0, strNumber.indexOf(".") + 3)
        } else {
            return strNumber
        }
    }

    function formatDistace(distance) {
        var unit = "m"
        if(distance >= 1000) {
            unit = "km"
            distance /= 1000
        }
        return formatNumber(distance) + unit
    }

    function zeroTail(meter) {
        var strMeter = new String(meter)
        meter = strMeter.charAt(0)
        for(var i = 1; i < strMeter.length; i++) {
            meter += "0"
        }
        return meter
    }

    // Return Bearing (degrees)
    // http://www.movable-type.co.uk/scripts/latlong.html
    // http://gis.stackexchange.com/questions/14670/how-to-calculate-bearing-between-two-gps-points
    function calculateBearing(lat1, lon1, lat2, lon2) {
        var dLon = lon2 - lon1;
        var y = Math.sin(dLon) * Math.cos(lat2);
        var x = Math.cos(lat1)*Math.sin(lat2)-Math.sin(lat1)*Math.cos(lat2)*Math.cos(dLon);
        return (180.0/Math.PI) * Math.atan2(y, x);
    }

    function adjustPositions() {
        currentPositionX = map.toScreenPosition(currentPosition).x
        currentPositionY = map.toScreenPosition(currentPosition).y

        targetPositionX = map.toScreenPosition(targetPosition).x
        targetPositionY = map.toScreenPosition(targetPosition).y

        // Distance
        distance = currentPosition.distanceTo(targetPosition)

        // Bearing
        bearing = calculateBearing(targetPosition.latitude, targetPosition.longitude, currentPosition.latitude, currentPosition.longitude)

        // Scale
        var coordDistance = currentPosition.distanceTo(targetPosition)
        console.log("coordDistance: " + coordDistance)
        var screenPositionA = map.toScreenPosition(currentPosition)
        var screenPositionB = map.toScreenPosition(targetPosition)
        var screenDistance = calculateDistance(screenPositionA.x,
                                               screenPositionA.y,
                                               screenPositionB.x,
                                               screenPositionB.y)
        console.log("screenDistance: " + screenDistance)
        var pixelPerMeter = screenDistance / coordDistance
        console.log("pixelPerMeter: " + pixelPerMeter)
        meter = (mainRect.width / 2.0) / pixelPerMeter
        meter = zeroTail(meter)
        lineLength = pixelPerMeter * meter
        console.log("lineLength: " + lineLength)
    }

    //! We stop retrieving position information when component is to be destroyed
    Component.onDestruction: positionSource.stop()

    //! Check if application is active, stop position updates if not
    Connections {
        target: Qt.application
        onActiveChanged: {
            if (Qt.application.active) {
                adjustPositions()
                positionSource.start()
            } else
                positionSource.stop()
        }
    }

    Map { id: map
        plugin: Plugin { name: "nokia" }
        zoomLevel: 15
        mapType: Map.StreetMap
        anchors.fill: parent

        center: Coordinate {
            latitude: centerPosition.latitude
            longitude: centerPosition.longitude
        }

        //        MapCircle {
        //            center: centerPosition
        //            radius: 20
        //            color: "blue"
        //        }

        // Line
        Rectangle {
            width: calculateDistance(currentPositionX, currentPositionY, targetPositionX, targetPositionY)
            height: 3
            color: "red"
            transform: Rotation {
                axis { x: 0; y: 0; z: 1 } angle: Math.atan2(currentPositionY - targetPositionY, currentPositionX - targetPositionX) * 180 / Math.PI;
            }
            x: targetPositionX
            y: targetPositionY
        }

        // Current position
        Rectangle {
            width: 20
            height: width
            color: "red"
            border.color: "black"
            border.width: 1
            radius: width * 0.5
            x: currentPositionX - width / 2
            y: currentPositionY - width / 2
        }

        // Target position
        Rectangle {
            width: 20
            height: width
            color: "green"
            border.color: "black"
            border.width: 1
            radius: width * 0.5
            x: targetPositionX - width / 2
            y: targetPositionY - width / 2
        }

        // Distance
        Text {
            color: "black"
            text: "Distance: " + formatDistace(distance)
            x: 5
            y: 5
        }

        // Bearing
        Text {
            color: "black"
            text: "Bearing: " + formatNumber(bearing)
            x: 5
            y: 25
        }

        // Scale
        Text {
            color: "black"
            text: formatDistace(meter)
            x: mainRect.width - lineLength - 10
            y: mainRect.height - 35
        }

        Rectangle {
            color: "black"
            width: lineLength
            height: 4
            x: mainRect.width - lineLength - 10
            y: mainRect.height - 10
        }
    }

    // Target
    Rectangle { id: targetRect
        width: 60
        height: 20 // 100
        color: "white"
        border.color: "black"
        border.width: 1
        radius: 10
        x: mainRect.width - width - 5
        y: 5
        z: 1

        Text {
            width: targetRect.width
            height: fontSize
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: fontSize
            text: "Target"
        }

        MouseArea { id: mouseArea
            anchors.fill: parent

            onPressed: {
                target(targetPosition.latitude, targetPosition.longitude, targetPosition.altitude)
            }
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
        currentPosition.latitude = currentCoord.latitude
        currentPosition.longitude = currentCoord.longitude
        currentPosition.altitude = currentCoord.altitude

        optimizeZoom()
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
            adjustPositions()
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
            adjustPositions()
        }

        onCanceled: {
            __isPanning = false
        }
    }
}
