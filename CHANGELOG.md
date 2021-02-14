# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]

### Changed

- Ubuntu uses /mnt/runner/.opam for OPAMROOT, using faster Azure temporary
  storage.

## [1.1.6]

### Changed

- Windows installs Cygwin to `D:\cygwin`, using faster Azure temporary storage.

## [1.1.5] - 2020-12-15

### Changed

Reduce build time by exporting modified `OPAMJOBS` environment variable.

## [1.1.4] - 2020-12-07

### Changed

Windows installs `mingw64-x86_64-gcc-g++` so GitHub Action can build libraries
that require it.

## [1.1.3] - 2020-10-23 [YANKED]

### Security

- Update the `@actions/core` package to address
  [CVE-2020-15228](https://github.com/advisories/GHSA-mfwh-5m23-j46w).

## [1.1.2] - 2020-09-10

### Changed

- Add the Cygwin setup to a known location for later steps.

### Fixed

- Check if the switch exists before creating the switch.

## [1.1.1] - 2020-08-20

### Fixed

- OCaml installation errors on Windows are now properly propagated.

## [1.1.0] - 2020-07-04

### Added

- The default opam repository can now be set via input.

### Changed

- Linux VMs now use opam 2.0.7.

## [1.0.1] - 2020-04-21

### Changed

- `node_modules` are not exported anymore which reduces the size of the action

- The repository is initialised directly from the opam-repository git source, so
  that there is no lag in packages being available for CI

- Ubuntu installs `musl-tools` so that the GitHub Action can generate statically
  linked Linux binaries in conjunction with the
  `ocaml-variants.4.x.y+musl+flambda` switch

## [1.0] - 2019-11-21

- Initial release.

[unreleased]: https://github.com/avsm/setup-ocaml/compare/v1.1.6...HEAD
[1.1.6]: https://github.com/avsm/setup-ocaml/compare/v1.1.5...v1.1.6
[1.1.5]: https://github.com/avsm/setup-ocaml/compare/v1.1.4...v1.1.5
[1.1.4]: https://github.com/avsm/setup-ocaml/compare/v1.1.3...v1.1.4
[1.1.3]: https://github.com/avsm/setup-ocaml/compare/v1.1.2...v1.1.3
[1.1.2]: https://github.com/avsm/setup-ocaml/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/avsm/setup-ocaml/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/avsm/setup-ocaml/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/avsm/setup-ocaml/compare/v1.0...v1.0.1
[1.0]: https://github.com/avsm/setup-ocaml/releases/tag/v0.0.1
