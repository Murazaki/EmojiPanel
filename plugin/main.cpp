#include "emojipanelplatforminputcontext.h"

#include <qpa/qplatforminputcontextplugin_p.h>
#include <QtCore/QStringList>

QT_BEGIN_NAMESPACE

class EmojiPanelPlatformInputContextPlugin : public QPlatformInputContextPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QPlatformInputContextFactoryInterface_iid FILE "emojipanel.json")

public:
    EmojiPanelPlatformInputContext *create(const QString&, const QStringList&) Q_DECL_OVERRIDE;
};

EmojiPanelPlatformInputContext *EmojiPanelPlatformInputContextPlugin::create(const QString& system, const QStringList& paramList)
{
    Q_UNUSED(paramList);

    if (system == QLatin1String("emojipanel")) {
        return new EmojiPanelPlatformInputContext;
    }

    return 0;
}

QT_END_NAMESPACE

#include "main.moc"
