# github-release

[![Build](https://github.com/kroese/github-release/workflows/Build/badge.svg)](https://github.com/kroese/github-release/)
[![Version](https://img.shields.io/github/v/tag/kroese/github-release?label=version&color=066da5)](https://github.com/kroese/github-release/)
[![Size](https://img.shields.io/github/languages/code-size/kroese/github-release?label=size&color=066da5)](https://github.com/kroese/github-release/)

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
      uses: kroese/github-release@v5
      env:
        GITHUB_TOKEN: ${{ secrets.RELEASE_TOKEN }}
      with:
        tag: MyReleaseTag
        title: MyReleaseTitle
        body: MyReleaseMessage
```

## Notes

The ``title`` field is the release title. 

The ``tag`` field is the release tag (optional).

The ``body`` field is the release message (optional).

`${{ secrets.RELEASE_TOKEN }}` is the Repository [Access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)

