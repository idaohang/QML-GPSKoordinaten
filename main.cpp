#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QGraphicsObject> // C++ connect
#include <QDeclarativeContext> // QML connect

//#include <QDeclarativeEngine>
//#include <QDeclarativeComponent>
//#include <QDeclarativeContext>

#include <numberedit.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    NumberEdit numberEdit;

//    qmlRegisterType<NumberEdit>("GpsGraphics", 1, 0, "NumberEdit");

    QmlApplicationViewer viewer;

    viewer.rootContext()->setContextProperty("numberEdit", &numberEdit); // QML connect
//    viewer.rootContext()->setContextObject(&numberEdit);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/GPSKoordinaten/main.qml"));
    viewer.showExpanded();

    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject()); // C++ connect
    QObject::connect(rootObject, SIGNAL(characterModeChanged(QString)), &numberEdit, SLOT(setCharacterMode(QString))); // C++ connect

    return app->exec();
}
