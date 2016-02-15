#ifndef EMOJIPANEL_H
#define EMOJIPANEL_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QApplication>

class EmojiPanel : public QObject
{
    Q_OBJECT
public:
    explicit EmojiPanel(QApplication *app = 0);
    ~EmojiPanel();

public slots:
    void show();
    void hide();
    bool isVisible() const;

signals:
    Q_INVOKABLE void emojiPressed(QString emoji);

private:
    QQmlApplicationEngine m_engine;
    QQuickWindow * m_window;
};

#endif // EMOJIPANEL_H
