fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### create_app

```sh
[bundle exec] fastlane create_app
```

Create on Developer portal and AppStore Connect

----


## iOS

### ios signing

```sh
[bundle exec] fastlane ios signing
```

Sync signing

### ios build

```sh
[bundle exec] fastlane ios build
```

Build binary

### ios release

```sh
[bundle exec] fastlane ios release
```

Release

### ios uploadTest

```sh
[bundle exec] fastlane ios uploadTest
```

Uploads to TestFlight

### ios version_bump_major

```sh
[bundle exec] fastlane ios version_bump_major
```

Increments major app version

### ios version_bump_minor

```sh
[bundle exec] fastlane ios version_bump_minor
```

Increments minor app version

### ios version_bump_patch

```sh
[bundle exec] fastlane ios version_bump_patch
```

Increments patch app version

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
