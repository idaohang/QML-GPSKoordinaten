#include "numberedit.h"

NumberEdit::NumberEdit(QObject *parent) :
    QObject(parent)
{
    characterMode = DigitMode;
}

QString NumberEdit::getCharacterMode() {
    qDebug("get");
    return getCharacterMode(characterMode);
}

void NumberEdit::setCharacterMode(QString mode) {
    characterMode = getCharacterMode(mode);
    emit characterModeChanged();
}

void NumberEdit::setText(QString newVal) {

}

void NumberEdit::addText(const QString & s) {

}
