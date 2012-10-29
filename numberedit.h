#ifndef NUMBEREDIT_H
#define NUMBEREDIT_H
#include <QObject>
#include <QDateTime>
#include <QMetaObject>
#include <QMetaEnum>

/**
  * A Class to be used with the QML-Numberpad element.
  * When in letter mode, Numberedit works like a telephone keypad
  * with multiple letters per key.
  * Builds the text string and performs validation.
  */
class NumberEdit : public QObject
{
    Q_OBJECT
    Q_ENUMS(CharacterMode)
    Q_PROPERTY (QString editorText READ getText() WRITE setText() NOTIFY textChanged())
    Q_PROPERTY (QString characterMode READ getCharacterMode() WRITE setCharacterMode() NOTIFY characterModeChanged())

    // C++ Anbindung über Signals and Slots
    // Klassen müssen von QObject abgeleitet sein
    // Virsuelle Klassen müssen von QDeclarativeItem abgeleitet sein

    // http://www.developer.nokia.com/Community/Wiki/Connecting_Qt_signal_to_QML_function
    // http://www.developer.nokia.com/Community/Wiki/Calling_Qt_class_methods_from_QML
    // http://doc.qt.digia.com/qt/qtbinding.html
    // http://apidocs.meego.com/1.2/qt4/qml-extending-types.html
    // http://qt-project.org/doc/qt-4.8/qmlevents.html
    // http://doc.qt.digia.com/qt/declarative-tutorials-extending-chapter3-bindings.html

public:
    explicit NumberEdit( QObject *parent = 0);

    typedef enum {
        DigitMode,
        LetterMode
    }CharacterMode;

signals: //NO const references for QML! Use copies!
    void returnPressed (QString  text);
    void editorTextChanged (QString text);

    void characterModeChanged();
    void textChanged(QString text);
public slots:
    /**
      * Get a string representation of charcterMode
      */
    QString getCharacterMode();
    /**
      * Set characterMode. newVal may be "DigitMode" or "LetterMode"
      */
    void setCharacterMode(QString mode);
    /**
      * Sets an validates text using addText().
      */
    void setText(QString text);
    /**
      * Retun a copy of text.
      */
    QString getText(){
        return editorText; // + "_";
    } //for QML return a copy!
    /**
      * Add s to text and validate result.
      * If result would be invalid, nothing is added.
      */
    void addText(QString text);
protected slots:
private:
    CharacterMode getCharacterMode(QString mode) {
        int index = metaObject()->indexOfEnumerator("CharacterMode");
        QMetaEnum metaEnum = metaObject()->enumerator(index);

        return (CharacterMode) metaEnum.keyToValue(mode.toAscii());
    }

    QString getCharacterMode(CharacterMode mode) {
        int index = metaObject()->indexOfEnumerator("CharacterMode");
        QMetaEnum metaEnum = metaObject()->enumerator(index);

        return metaEnum.valueToKey(mode);
    }

    /**
      * Maximum time between key hits in a sequence
      */
    const static int MultipleHitTime = 1000;
    /**
      * Count the key hits to select letter from key text.
      */
    void processMultipleHits(const QString & s);
    CharacterMode characterMode;
    int keyHits;
    QString lastKeyText;
    QDateTime lastHitTime;
    QString editorText; //the text in the editor
    bool signIsSet;
    bool decimalIsSet;
};
#endif // NUMBEREDIT_H
