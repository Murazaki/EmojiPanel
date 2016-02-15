TARGET = emojipanelplatforminputcontextplugin

PLUGIN_TYPE = platforminputcontexts
PLUGIN_EXTENDS = -
PLUGIN_CLASS_NAME = EmojiPanelPlatformInputContextPlugin
load(qt_plugin)

QT += dbus gui-private
SOURCES += $$PWD/emojipanelplatforminputcontext.cpp \
           $$PWD/main.cpp

HEADERS += $$PWD/emojipanelplatforminputcontext.h

OTHER_FILES += $$PWD/emojipanel.json
