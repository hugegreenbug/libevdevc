# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

include common.mk

install-header: CC_LIBRARY(src/libevdevc.so.0)
	set -e; \
	for h in libevdevc.h libevdevc_event.h libevdevc_mt.h libevdevc_log.h; do \
		install -D -m 0644 $(SRC)/include/libevdevc/$$h \
			$(DESTDIR)/usr/include/libevdevc/$$h; \
	done


setup-header-in-place:
	mkdir -p $(SRC)/in-place || true
	ln -sfn $(SRC)/include/libevdevc $(SRC)/in-place/libevdevc
