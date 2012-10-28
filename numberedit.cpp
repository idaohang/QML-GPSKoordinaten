#include "numberedit.h"
#include <QRegExp>

NumberEdit::NumberEdit(QObject *parent) :
    QObject(parent)
{
    characterMode = DigitMode;
    lastKeyText = "";
    editorText = "";
    lastHitTime = QDateTime::currentDateTime();
    keyHits = 0;
}

QString NumberEdit::getCharacterMode() {
    return getCharacterMode(characterMode);
}

void NumberEdit::setCharacterMode(QString mode) {
    characterMode = getCharacterMode(mode);
    emit characterModeChanged();
}

void NumberEdit::setText(QString text) {
    QRegExp rx("_");
    editorText = text.remove(rx);
    qDebug(qPrintable(editorText));
}

void NumberEdit::addText(QString text) {
    QDateTime currentTime = QDateTime::currentDateTime();
    uint diffTime = lastHitTime.time().msecsTo( currentTime.time() );
    qDebug( "Time: %d", diffTime );

    QRegExp rx("<br>");
    QString sign = "";
    text.remove(rx);

    if(text.length() > 0) {
        if(MultipleHitTime >= diffTime && text == lastKeyText) {
            qDebug("%s %s", qPrintable(text), qPrintable(lastKeyText));
            if(keyHits + 1 == text.length()) {
                keyHits = 0;
            } else {
                keyHits++;
            }
            qDebug("Hits: %d", keyHits);
        } else {
            keyHits = 0;
        }

        sign = text.at(keyHits);

        if(sign == "<") {
            editorText.chop(1);
            setText(editorText);
        } else {
            setText(editorText + sign);
        }
    }

    lastKeyText = text;
    lastHitTime = QDateTime::currentDateTime();
    qDebug("-----------");
}
