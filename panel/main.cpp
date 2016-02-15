#include <QtDBus/QDBusConnection>
#include <iostream>

#include <emojipanel.h>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    if (!QDBusConnection::sessionBus().registerService("com.murazaki.emojipanel")) {
        qFatal("Unable to register at DBus");
        return 1;
    }

    EmojiPanel emojiPanel(&app);

    if (!QDBusConnection::sessionBus().registerObject("/EmojiPanel", &emojiPanel, QDBusConnection::ExportAllSignals | QDBusConnection::ExportAllSlots)) {
        qFatal("Unable to register object at DBus");
        return 1;
    }

    return app.exec();
}
