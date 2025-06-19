bin_PROGRAMS = ut-fap5vis-lib

AM_CPPFLAGS = -D_PLAT_LINUX_ -g -O0

ut_fap5vis_lib_SOURCES = \
		       ut_main.cpp \
		       ut_container.cpp \
		       ut_wdg.cpp

ut_fap5vis_lib_LDFLAGS=-L../src/.libs/ -lfap5vis -lfap5  -lcppunit -lrt
ut_fap5vis_lib_CXXFLAGS=-I@srcdir@/../src

check: test_fap5vis_lib

test_fap5vis_lib:
	 ./ut-fap5vis-lib


