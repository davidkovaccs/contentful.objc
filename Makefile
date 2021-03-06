WORKSPACE=ContentfulSDK.xcworkspace

.PHONY: all clean doc example example-static pod really-clean static-lib test

clean:
	rm -rf build Examples/UFO/build Examples/*.zip

really-clean: clean
	rm -rf Pods $(HOME)/Library/Developer/Xcode/DerivedData/*

all: test example-static

pod:
	pod install

example:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) \
		-scheme ContentfulDeliveryAPI \
		-sdk iphonesimulator | xcpretty -c
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) \
		-scheme 'UFO Example' \
		-sdk iphonesimulator | xcpretty -c

example-static: static-lib
	cd Examples/UFO; set -o pipefail && xcodebuild \
		-sdk iphonesimulator | xcpretty -c

static-lib:
	@sed -i '' -e 's/GCC_GENERATE_TEST_COVERAGE_FILES = YES/GCC_GENERATE_TEST_COVERAGE_FILES = NO/g' ContentfulSDK.xcodeproj/project.pbxproj
	@sed -i '' -e 's/GCC_INSTRUMENT_PROGRAM_FLOW_ARCS = YES/GCC_INSTRUMENT_PROGRAM_FLOW_ARCS = NO/g' ContentfulSDK.xcodeproj/project.pbxproj

	set -o pipefail && xcodebuild VALID_ARCHS='i386 x86_64 armv7 armv7s arm64' -workspace $(WORKSPACE) \
		-scheme Pods-ContentfulDeliveryAPI \
		-sdk iphonesimulator | xcpretty -c
	set -o pipefail && xcodebuild VALID_ARCHS='i386 x86_64 armv7 armv7s arm64' -workspace $(WORKSPACE) \
  	-scheme 'Static Framework' | xcpretty -c

	@cd Examples/UFO/Distribution; ./update.sh
	cd Examples; ./ship_it.sh

	@sed -i '' -e 's/GCC_GENERATE_TEST_COVERAGE_FILES = NO/GCC_GENERATE_TEST_COVERAGE_FILES = YES/g' ContentfulSDK.xcodeproj/project.pbxproj
	@sed -i '' -e 's/GCC_INSTRUMENT_PROGRAM_FLOW_ARCS = NO/GCC_INSTRUMENT_PROGRAM_FLOW_ARCS = YES/g' ContentfulSDK.xcodeproj/project.pbxproj

test: example
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) \
		-scheme ContentfulDeliveryAPI \
		-sdk iphonesimulator -destination 'name=iPhone Retina (4-inch)' \
		test | xcpretty -c

doc:
	appledoc --project-name 'Contentful Delivery API' \
		--project-version 1.0 \
		--project-company 'Contentful GmbH' \
		--company-id com.contentful \
		--output ./doc \
		--create-html \
		--no-create-docset \
		--no-install-docset \
		--no-publish-docset \
		--no-keep-intermediate-files \
		--no-keep-undocumented-objects \
		--no-keep-undocumented-members \
		--merge-categories \
		--warn-missing-output-path \
		--warn-missing-company-id \
		--warn-undocumented-object \
		--warn-undocumented-member \
		--warn-empty-description \
		--warn-unknown-directive \
		--warn-invalid-crossref \
		--warn-missing-arg \
		--logformat 1 \
		--verbose 2 ./Code
