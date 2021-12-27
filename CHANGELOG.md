# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2021-12-27
### Added
- `sshfs` for [pull mode](https://borgbackup.readthedocs.io/en/stable/deployment/pull-backup.html)

## [0.2.0] - 2021-09-08
### Changed
- no longer write command to stderr by default.
  may be re-enabled by setting the environment variable `SHOW_COMMAND`
  to an non-empty value.

## [0.1.0] - 2021-08-19
### Added
- alpine base image
- borgbackup
- openssh client
- netcat-openbsd for `ProxyCommand nc -x …`

[Unreleased]: https://git.hammerle.me/fphammerle/docker-borgbackup-client/compare/v0.3.0...HEAD
[0.3.0]: https://git.hammerle.me/fphammerle/docker-borgbackup-client/compare/v0.2.0...v0.3.0
[0.2.0]: https://git.hammerle.me/fphammerle/docker-borgbackup-client/compare/v0.1.0...v0.2.0
[0.1.0]: https://git.hammerle.me/fphammerle/docker-borgbackup-client/src/v0.1.0
