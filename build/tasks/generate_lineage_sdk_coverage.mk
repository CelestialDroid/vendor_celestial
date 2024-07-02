#
# Copyright (C) 2010 The Android Open Source Project
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Makefile for producing lineage sdk coverage reports.
# Run "make lineage-sdk-test-coverage" in the $ANDROID_BUILD_TOP directory.

celestial_sdk_api_coverage_exe := $(HOST_OUT_EXECUTABLES)/celestial-sdk-api-coverage
dexdeps_exe := $(HOST_OUT_EXECUTABLES)/dexdeps

coverage_out := $(HOST_OUT)/celestial-sdk-api-coverage

api_text_description := celestial-sdk/api/celestial_current.txt
api_xml_description := $(coverage_out)/api.xml
$(api_xml_description) : $(api_text_description) $(APICHECK)
	$(hide) echo "Converting API file to XML: $@"
	$(hide) mkdir -p $(dir $@)
	$(hide) $(APICHECK_COMMAND) -convert2xml $< $@

celestial-sdk-test-coverage-report := $(coverage_out)/celestial-sdk-test-coverage.html

celestial_sdk_tests_apk := $(call intermediates-dir-for,APPS,CelestialPlatformTests)/package.apk
celestialsettingsprovider_tests_apk := $(call intermediates-dir-for,APPS,CelestialSettingsProviderTests)/package.apk
celestial_sdk_api_coverage_dependencies := $(celestial_sdk_api_coverage_exe) $(dexdeps_exe) $(api_xml_description)

$(celestial-sdk-test-coverage-report): PRIVATE_TEST_CASES := $(celestial_sdk_tests_apk) $(celestialsettingsprovider_tests_apk)
$(celestial-sdk-test-coverage-report): PRIVATE_CELESTIAL_SDK_API_COVERAGE_EXE := $(celestial_sdk_api_coverage_exe)
$(celestial-sdk-test-coverage-report): PRIVATE_DEXDEPS_EXE := $(dexdeps_exe)
$(celestial-sdk-test-coverage-report): PRIVATE_API_XML_DESC := $(api_xml_description)
$(celestial-sdk-test-coverage-report): $(celestial_sdk_tests_apk) $(celestialsettingsprovider_tests_apk) $(celestial_sdk_api_coverage_dependencies) | $(ACP)
	$(call generate-celestial-coverage-report,"CELESTIAL-SDK API Coverage Report",\
			$(PRIVATE_TEST_CASES),html)

.PHONY: celestial-sdk-test-coverage
celestial-sdk-test-coverage : $(celestial-sdk-test-coverage-report)

# Put the test coverage report in the dist dir if "celestial-sdk" is among the build goals.
ifneq ($(filter celestial-sdk, $(MAKECMDGOALS)),)
  $(call dist-for-goals, celestial-sdk, $(celestial-sdk-test-coverage-report):celestial-sdk-test-coverage-report.html)
endif

# Arguments;
#  1 - Name of the report printed out on the screen
#  2 - List of apk files that will be scanned to generate the report
#  3 - Format of the report
define generate-celestial-coverage-report
	$(hide) mkdir -p $(dir $@)
	$(hide) $(PRIVATE_CELESTIAL_SDK_API_COVERAGE_EXE) -d $(PRIVATE_DEXDEPS_EXE) -a $(PRIVATE_API_XML_DESC) -f $(3) -o $@ $(2) -cm
	@ echo $(1): file://$@
endef

# Reset temp vars
celestial_sdk_api_coverage_dependencies :=
celestial-sdk-combined-coverage-report :=
celestial-sdk-combined-xml-coverage-report :=
celestial-sdk-verifier-coverage-report :=
celestial-sdk-test-coverage-report :=
api_xml_description :=
api_text_description :=
coverage_out :=
dexdeps_exe :=
celestial_sdk_api_coverage_exe :=
celestial_sdk_verifier_apk :=
android_celestial_sdk_zip :=
