# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
include common.mk

CFLAGS += -std=gnu99 -fvisibility=default
CPPFLAGS += -I$(SRC)/include

CC_LIBRARY(src/libevdevc_hollow.so.0): CFLAGS += -DEVDEV_HOLLOW
CC_LIBRARY(src/libevdevc_hollow.so.0): src/libevdevc.o \
	src/libevdevc_mt.o \
	src/libevdevc_event.o

CC_LIBRARY(src/libevdevc.so.0): src/libevdevc.o \
	src/libevdevc_mt.o \
	src/libevdevc_event.o

install-lib: CC_LIBRARY(src/libevdevc.so.0) CC_LIBRARY(src/libevdevc_hollow.so.0)
	install -D -m 0755 src/libevdevc.so.0 $(DESTDIR)$(LIBDIR)/libevdevc.so.0
	ln -f -s libevdevc.so.0 $(DESTDIR)$(LIBDIR)/libevdevc.so
	install -D -m 0755 src/libevdevc_hollow.so.0 \
		$(DESTDIR)$(LIBDIR)/libevdevc_hollow.so.0
	ln -f -s libevdevc_hollow.so.0 $(DESTDIR)$(LIBDIR)/libevdevc_hollow.so
	install -D -m 0644 $(SRC)/libevdevc-cros.pc \
			$(DESTDIR)$(LIBDIR)/pkgconfig/libevdevc-cros.pc

setup-lib-in-place:
	mkdir -p $(SRC)/in-place || true
	ln -sf $(SRC)/src/libevdevc_hollow.so.0 $(SRC)/in-place/libevdevc_hollow.so
	ln -sf $(SRC)/src/libevdevc_hollow.so.0 $(SRC)/in-place/libevdevc_hollow.so.0
