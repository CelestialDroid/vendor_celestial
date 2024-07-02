# CelestialDroid System Version
#ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.celestial.releasetype=$(CELESTIAL_BUILDTYPE) \
    ro.modversion=$(CELESTIAL_VERSION) \

# CelestialDroid Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.celestial.display.version=$(CELESTIAL_DISPLAY_VERSION)

# CelestialDroid Platform SDK Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.celestial.build.version.plat.sdk=$(CELESTIAL_PLATFORM_SDK_VERSION)

# CelestialDroid Platform Internal Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.celestial.build.version.plat.rev=$(CELESTIAL_PLATFORM_REV)

# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%H%M)
CUSTOM_DEVICE ?= $(TARGET_DEVICE)
BUILD_SIGNATURE_KEYS := release-keys
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(CUSTOM_DEVICE)/$(CUSTOM_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
