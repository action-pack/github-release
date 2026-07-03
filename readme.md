<h1 align="center">GitHub Release<br />
<div align="center">
  
  [![Build](https://github.com/action-pack/github-release/workflows/Build/badge.svg)](https://github.com/action-pack/github-release/)
  [![Version](https://img.shields.io/github/v/tag/action-pack/github-release?label=version&sort=semver&color=066da5)](https://github.com/marketplace/actions/create-new-release)
  [![Size](https://img.shields.io/github/languages/code-size/action-pack/github-release?label=size&color=066da5)](https://github.com/action-pack/github-release/)
  
</div></h1>

Creates a GitHub release using a workflow action.

## Usage 🚀

```yaml
name: Publish Release

on:
  push:
    branches:
      - master
    tags:
      - "v*"

jobs:
  release:
    name: Publish Release
    runs-on: ubuntu-latest

    permissions:
      contents: write

    steps:
      - uses: actions/checkout@v4

      - name: Create release
        uses: action-pack/github-release@v2
        with:
          tag: MyReleaseTag
          title: MyReleaseTitle
          body: MyReleaseMessage
```

# Notes 📝

If a release with the same tag already exists, it will be deleted first and recreated.

When no `body` input is provided, the action automatically generates release notes.

The created release is marked as the latest release by default. Set `latest` to `false` to disable this.

The `tag` input is optional. When provided, it is used as the tag name for the release.

The `commit` input is optional. It can be a commit hash or branch name to attach the release to.

## FAQ 💬

  * ### Why do I get the error '*Resource not accessible by integration*'?

    This can happen when the workflow does not have permission to create or update releases.

    Add the following permissions to your workflow job:

    ```yaml
    permissions:
      contents: write
    ```

    Alternatively, enable read and write workflow permissions in your repository settings under:

    ```text
    Settings -> Actions -> General -> Workflow permissions
    ```

## Stars 🌟
[![Stargazers](https://raw.githubusercontent.com/star-stats/stars/refs/heads/data/charts/action-pack-github-release.svg)](https://github.com/action-pack/github-release/stargazers)
