CONFIG += qt \
          plugin \
          x11 \
          warn_on

QT += svg

greaterThan(QT_MAJOR_VERSION, 4) {
  lessThan(QT_MAJOR_VERSION, 6) {
    lessThan(QT_MINOR_VERSION, 12) {
      error("Kvantum needs at least Qt 5.12.0")
    }
  }
  QT += x11extras
}

TARGET = kvantum
TEMPLATE = lib
CONFIG += c++11

VERSION = 0.1

greaterThan(QT_MAJOR_VERSION, 4) {
  QT += KWindowSystem
  SOURCES += Kvantum.cpp \
             eventFiltering.cpp \
             polishing.cpp \
             rendering.cpp \
             standardIcons.cpp \
             viewItems.cpp \
             KvantumPlugin.cpp \
             shortcuthandler.cpp \
             blur/blurhelper.cpp \
             animation/animation.cpp \
             themeconfig/ThemeConfig.cpp
  HEADERS += Kvantum.h \
             KvantumPlugin.h \
             shortcuthandler.h \
             blur/blurhelper.h \
             animation/animation.h \
             themeconfig/ThemeConfig.h \
             themeconfig/specs.h
  greaterThan(QT_MINOR_VERSION, 14) {
    SOURCES += drag/windowmanager.cpp
    HEADERS += drag/windowmanager.h
  } else {
    SOURCES += drag/windowmanager-old.cpp
    HEADERS += drag/windowmanager-old.h
  }
  OTHER_FILES += kvantum.json
} else {
  SOURCES += qt4/Kvantum4.cpp \
             qt4/KvantumPlugin4.cpp \
             qt4/shortcuthandler4.cpp \
             qt4/x11wmmove4.cpp \
             qt4/windowmanager4.cpp \
             qt4/blurhelper4.cpp \
             qt4/ThemeConfig4.cpp
  HEADERS += qt4/Kvantum4.h \
             qt4/KvantumPlugin4.h \
             qt4/shortcuthandler4.h \
             qt4/x11wmmove4.h \
             qt4/windowmanager4.h \
             qt4/blurhelper4.h \
             qt4/ThemeConfig4.h \
             qt4/specs4.h
}

RESOURCES += themeconfig/defaulttheme.qrc

unix:!macx: LIBS += -lX11

unix {
  #VARIABLES
  isEmpty(PREFIX) {
    PREFIX = /usr
  }
  COLORSDIR =$$PREFIX/share/kde4/apps/color-schemes
  KF5COLORSDIR =$$PREFIX/share/color-schemes
  DATADIR =$$PREFIX/share

  DEFINES += DATADIR=\\\"$$DATADIR\\\"

  #MAKE INSTALL
  target.path = $$[QT_INSTALL_PLUGINS]/styles
  colors.path = $$COLORSDIR
  colors.files += ../color/Kvantum.colors
  kf5colors.path = $$KF5COLORSDIR
  kf5colors.files += ../color/Kvantum.colors
  equals(QT_MAJOR_VERSION, 4): INSTALLS += target colors
  greaterThan(QT_MAJOR_VERSION, 4): INSTALLS += target kf5colors
}
