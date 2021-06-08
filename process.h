#ifndef PROCESS_H
#define PROCESS_H

#include <QProcess>
#include <QVariant>

class Process : public QProcess {
	Q_OBJECT
	Q_PROPERTY(QString program READ program WRITE setProgram)

public:
	Process(QObject *parent = 0) : QProcess(parent) { }

	Q_INVOKABLE void startDetached(const QStringList &args) {
		emit starting(program(), args);
		QProcess::setArguments(args);
		QProcess::startDetached();
	}

	Q_INVOKABLE void start(const QStringList &args) {
		emit starting(program(), args);
		QProcess::setProcessChannelMode(QProcess::MergedChannels);
		QProcess::start(program(), args);
	}

	Q_INVOKABLE QByteArray readAll() {
		return QProcess::readAll().trimmed();
	}

Q_SIGNALS:
	void starting(QString program, QStringList args);
};

#endif // PROCESS_H
