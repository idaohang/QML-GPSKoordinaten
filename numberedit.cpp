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
//    editorText = text.remove(QRegExp("_"));
    editorText = text;
    emit textChanged(editorText);
    qDebug(qPrintable(editorText));
}

void NumberEdit::addText(QString text) {
    text.remove(QRegExp("<br>"));

    if(text.length() > 0) {
        if(text == "<-") {
            editorText.chop(1);
            setText(editorText);
        } else {
            QDateTime currentTime = QDateTime::currentDateTime();
            uint diffTime = lastHitTime.time().msecsTo( currentTime.time() );
            qDebug( "Time: %d", diffTime );

            if( text.length() > 1  && MultipleHitTime >= diffTime && text == lastKeyText ) {
                if( keyHits + 1 == text.length() ) {
                    keyHits = 0;
                } else {
                    keyHits++;
                }
                if(text.at(keyHits) != 'Î')
                    editorText.chop(1);
            } else {
                keyHits = 0;
            }

            qDebug("Hits: %d", keyHits);

            if(text.at(keyHits) == 'Î') {
                if(getCharacterMode() == getCharacterMode(LetterMode)) {
                    setCharacterMode("");
                } else {
                    setCharacterMode(getCharacterMode(LetterMode));
                }
                setText(editorText);
            } else {
                setText(editorText + text.at(keyHits));
            }
        }
    }

    lastKeyText = text;
    lastHitTime = QDateTime::currentDateTime();
    qDebug("--------------------");
}
