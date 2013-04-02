# lsocket Makefile, works on Linux and Mac OS X, everywhere else roll your own.

ifdef DEBUG
	DBG=-g
	OPT=
else
	DBG=
	OPT=-O2
endif

OS = $(shell uname -s)

CFLAGS=-Wall -fPIC $(OPT) $(DBG)
INCDIRS=-I/usr/local/include
LIBDIRS=-L/usr/local/lib
LDFLAGS=-shared $(DBG)

# OS specialities
ifeq ($(OS),Darwin)
	LDFLAGS=-bundle -undefined dynamic_lookup -all_load
endif

all: lsocket.so

debug:; make DEBUG=1

lsocket.so: lsocket.o
	gcc $(LDFLAGS) -o lsocket.so $(LIBDIRS) lsocket.o

lsocket.o: lsocket.c
	gcc $(CFLAGS) $(INCDIRS) -c lsocket.c -o lsocket.o

clean:
	find . -name "*~" -exec rm {} \;
	find . -name .DS_Store -exec rm {} \;
	find . -name ._* -exec rm {} \;
	rm -f *.o *.so core
