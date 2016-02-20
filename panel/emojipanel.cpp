#include "emojipanel.h"

#include <QQmlContext>
#include <QCursor>

EmojiPanel::EmojiPanel(QApplication *app) : QObject(app)
{
    m_engine.rootContext()->setContextProperty("cursorPos", QCursor::pos());
    m_engine.rootContext()->setContextProperty("emojiPanel", this);
    m_engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    QObject *topLevel = m_engine.rootObjects().value(0);
    m_window = qobject_cast<QQuickWindow *>(topLevel);

    hide();
}

EmojiPanel::~EmojiPanel() {
    if(m_window) {
        m_window->close();
    }
}

void EmojiPanel::show() {
    m_window->setProperty("x",QCursor::pos().x());
    m_window->setProperty("y",QCursor::pos().y());
    m_window->show();
}

void EmojiPanel::hide() {
    m_window->hide();
}

bool EmojiPanel::isVisible() const {
    return m_window->isVisible();
}
