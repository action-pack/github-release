# Github-Release-Action

[![Actions Status](https://github.com/elgohr/Github-Release-Action/workflows/Release/badge.svg)](https://github.com/elgohr/Github-Release-Action/actions)

Creates a plain Github release.

## Usage

```yaml
name: Publish Release
on:
  push:
    tags:
      - 'v*'
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Create a Release
      uses: elgohr/Github-Release-Action@v4
      env:
        GITHUB_TOKEN: ${{ secrets.RELEASE_TOKEN }}
      with:
        tag: MyReleaseTag
        title: MyReleaseMessage
```

## Notes

`${{ secrets.GITHUB_TOKEN }}` can't be used for publishing, as it isn't allowed to publish releases.

The ``title`` field is the release title. May not contain spaces. 

The ``tag`` field is the release tag. If not specified it will default to the current date.
