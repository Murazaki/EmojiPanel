TEMPLATE = app
TARGET = emojipanel

QT += qml quick widgets dbus

SOURCES += main.cpp \
    emojipanel.cpp

HEADERS += \
    emojipanel.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
