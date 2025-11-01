includedir = @includedir@/libfap5vis

libdir = @libdir@/fap5/plugins

AM_CPPFLAGS = -D_PLAT_LINUX_

lib_LTLIBRARIES = libfap5vis.la

libfap5vis_la_SOURCES = \
		       plugin.cpp \
		       mwidget.h \
		       mscel.h \
		       mvisenv.h \
		       mwindow.h \
		       visenv.h \
		       visenv.cpp \
		       visprov.h \
		       visprov.cpp \
		       scene.h \
		       scene.cpp \
		       container.h \
		       container.cpp \
		       agentvr.h \
		       agentvr.cpp \
		       button.h \
		       button.cpp \
		       label.h \
		       label.cpp \
		       widget.h \
		       widget.cpp \
		       visprof_id.h

include_HEADERS = \
		  mwidget.h \
		  mvisenv.h \
		  mwindow.h \
		  visprof_id.h \
                  mscel.h


libfap5vis_la_LDFLAGS = -rdynamic -no-undefined -lrt
