# Build and sign without owning a Mac

You can use a macOS CI runner (for example GitHub Actions) to compile the project.

## What you still need for an installable IPA
Apple signing requires:
- Apple Developer membership
- an App ID / bundle identifier
- signing certificate
- provisioning profile (or App Store Connect distribution credentials)

Store signing secrets in the CI provider, never in the repository.

## Development / personal device
For a direct personal-device build, Xcode and the appropriate Apple signing setup are required. The iPhone alone cannot run Xcode or create a signed native IPA.

## App Store / TestFlight
Use App Store Connect API key credentials in CI and export an archive using the appropriate distribution method.

## SQLite-AI
Pin SQLite-AI 1.0.8 and use the official Apple/iOS artifact. The upstream project documents Swift installation and extension loading.
