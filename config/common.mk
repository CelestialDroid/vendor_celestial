PRODUCT_BRAND ?= CelestialDroid

# Overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/celestial/overlay
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/celestial/overlay/common

# Inherit from packages config
$(call inherit-product, vendor/celestial/config/packages.mk)

# Inherit from rro_overlays config
$(call inherit-product, vendor/celestial/config/rro_overlays.mk)

# Inherit from themes config
$(call inherit-product, vendor/celestial/config/themes.mk)
