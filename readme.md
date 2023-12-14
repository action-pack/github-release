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
    permissions:
      contents: write
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

The ``title`` input is the release name. 

The ``body`` input is the release notes (optional).

The ``tag`` input is the tagname to be created for the release (optional).

The ``commit`` input is a commit hash or branch name to attach the release to (optional).

The ``token`` input is the repository access token (optional), defaults to ```secrets.GITHUB_TOKEN```.

## FAQ

  * ### Why do I get the error '*Resource not accessible by integration*'?

    This can happen if the ```Workflow permissions``` in your repository settings ( Actions -> General ) are not set to the ```Read and write``` option.

    Either change that setting or otherwise add the following lines to your workflow job:
    
    ```yaml
    permissions:
      contents: write
    ```
    
