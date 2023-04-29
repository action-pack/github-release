# github-release

[![Actions Status](https://github.com/kroese/github-release/workflows/Release/badge.svg)](https://github.com/kroese/github-release/actions)

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
      uses: kroese/github-release@v4
      env:
        GITHUB_TOKEN: ${{ secrets.RELEASE_TOKEN }}
      with:
        tag: MyReleaseTag
        title: MyReleaseTitle
        body: MyReleaseMessage
```

## Notes

The ``title`` field is the release title. 

The ``body`` field is the release message (optional).

The ``tag`` field is the release tag. If not specified it will default to the current date.

`${{ secrets.GITHUB_TOKEN }}` can't be used for publishing, as it isn't allowed to publish releases.
