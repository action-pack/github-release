<h1 align="center">Github Release<br />
<div align="center">
  
  [![Build](https://github.com/action-pack/github-release/workflows/Build/badge.svg)](https://github.com/action-pack/github-release/)
  [![Version](https://img.shields.io/github/v/tag/action-pack/github-release?label=version&sort=semver&color=066da5)](https://github.com/marketplace/actions/create-new-release)
  [![Size](https://img.shields.io/github/languages/code-size/action-pack/github-release?label=size&color=066da5)](https://github.com/action-pack/github-release/)
  
</div></h1>

Creates a Github release using a workflow action.

## Usage

```yaml
name: Publish Release
on:
  push:
    branches:
      - master
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Create a release
      uses: action-pack/github-release@v2
      with:
        tag: MyReleaseTag
        title: MyReleaseTitle
        body: MyReleaseMessage
```

## Notes

The ``title`` field is the release title. 

The ``tag`` field is the release tag (optional).

The ``body`` field is the release notes (optional).

The ``commit`` field is a commit or branch name to attach the release to (optional).

The ``token`` field is the repository access token (optional).
