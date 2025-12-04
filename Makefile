# OpenSMTPD filter-masquerade Makefile

PREFIX ?= /usr/local
LIBEXECDIR ?= ${PREFIX}/libexec/smtpd
MANDIR ?= ${PREFIX}/man

PROG = filter-masquerade

all:
	@echo "Nothing to build. Run 'make install' to install."

install:
	install -d -m 755 ${DESTDIR}${LIBEXECDIR}
	install -m 755 ${PROG} ${DESTDIR}${LIBEXECDIR}/${PROG}
	install -d -m 755 ${DESTDIR}${MANDIR}/man8
	install -m 644 ${PROG}.8 ${DESTDIR}${MANDIR}/man8/${PROG}.8

uninstall:
	rm -f ${DESTDIR}${LIBEXECDIR}/${PROG}
	rm -f ${DESTDIR}${MANDIR}/man8/${PROG}.8

test:
	cd tests && ./filter-test-harness "../filter-masquerade @example.com"
	cd tests && ./filter-test-harness "../filter-masquerade @example.com oldcompany.net" multi-domain

clean:
	@echo "Nothing to clean."

.PHONY: all install uninstall test clean
