#ifndef QEMOJIPANELPLATFORMINPUTCONTEXT_H
#define QEMOJIPANELPLATFORMINPUTCONTEXT_H

#include "qpa/qplatforminputcontext.h"

QT_BEGIN_NAMESPACE

class QDBusInterface;

class EmojiPanelPlatformInputContext : public QPlatformInputContext
{
    Q_OBJECT

public:
    EmojiPanelPlatformInputContext();
    ~EmojiPanelPlatformInputContext();

    bool isValid() const Q_DECL_OVERRIDE;
    void setFocusObject(QObject *object) Q_DECL_OVERRIDE;

    void showInputPanel() Q_DECL_OVERRIDE;
    void hideInputPanel() Q_DECL_OVERRIDE;
    bool isInputPanelVisible() const Q_DECL_OVERRIDE;

private slots:
    void emojiPressed(const QString &emoji);

private:
    QDBusInterface *m_panelInterface;

    QObject *m_focusObject;
};

QT_END_NAMESPACE

#endif
