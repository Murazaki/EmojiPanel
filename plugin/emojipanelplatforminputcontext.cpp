#include "emojipanelplatforminputcontext.h"

#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusReply>
#include <QGuiApplication>
#include <QInputMethodEvent>
#include <QDebug>

EmojiPanelPlatformInputContext::EmojiPanelPlatformInputContext()
    : m_focusObject(0)
{
    m_panelInterface = new QDBusInterface("com.murazaki.emojipanel", "/EmojiPanel", "local.server.Keyboard", QDBusConnection::sessionBus(), this);

    connect(m_panelInterface, SIGNAL(emojiPressed(QString)), SLOT(emojiPressed(QString)));
}

EmojiPanelPlatformInputContext::~EmojiPanelPlatformInputContext()
{
}

bool EmojiPanelPlatformInputContext::isValid() const
{
    return m_panelInterface->isValid();
}

void EmojiPanelPlatformInputContext::setFocusObject(QObject *object)
{
    m_focusObject = object;
}

void EmojiPanelPlatformInputContext::showInputPanel()
{
    m_panelInterface->call("show");
}

void EmojiPanelPlatformInputContext::hideInputPanel()
{
    m_panelInterface->call("hide");
}

bool EmojiPanelPlatformInputContext::isInputPanelVisible() const
{
    const QDBusReply<bool> reply = m_panelInterface->call("isVisible");

    if (reply.isValid())
        return reply.value();
    else
        return false;
}

void EmojiPanelPlatformInputContext::emojiPressed(const QString &emoji)
{
    if (!m_focusObject)
        return;

    qDebug() << "emojiPressed : " << emoji;

    QInputMethodEvent event;
    event.setCommitString(emoji);

    QGuiApplication::sendEvent(m_focusObject, &event);
}
