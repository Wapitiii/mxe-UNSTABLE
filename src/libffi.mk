# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libffi
$(PKG)_WEBSITE  := https://sourceware.org/libffi/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.3.fixed
$(PKG)_CHECKSUM := ba998513d28c325d0c1ad6e4791bda87d2e7dafbb34ef2cbf3ddbb91ee3dca30
$(PKG)_GH_CONF  := atgreen/libffi/tags, v
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/armdevvel/libffi/releases/download/3.3-fix/libffi-3.3.fixed.tar.gz
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS     := cc

$(PKG)_DEPS_$(BUILD) :=

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS)
    $(SED) -i 's/-Wl,--version-script,libffi.map/ /g' '$(BUILD_DIR)/Makefile'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' \
        -W -Wall -Werror -std=c99 -pedantic \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-libffi.exe' \
        `'$(TARGET)-pkg-config' libffi --cflags --libs`
endef

define $(PKG)_BUILD_$(BUILD)
    # build and install the library
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
