# `zxe` <sub><sub><img src="https://zxe.io/software/Z80/assets/images/gentoo-icon.svg" height="48" width="48"></sub></sub> Gentoo Overlay

This is the [Gentoo](https://gentoo.org) [overlay](https://wiki.gentoo.org/wiki/Ebuild_repository) for [Manuel](https://github.com/redcode) and [Sofía](https://github.com/agaxia)'s software and other stuff that our packages depend on. We also maintain a Homebrew [tap](https://github.com/redcode/homebrew-zxe) and our own APT [repository](https://zxe.io/repos).

To add this overlay to Portage, type the following as `root`:

```shell
eselect repository add zxe git https://github.com/redcode/zxe-gentoo-overlay.git
emaint sync --repo zxe
```

If in doubt, read the [Gentoo documentation](https://www.gentoo.org/support/documentation/). For a list of the packages we distribute and other installation methods, visit our [repository](https://zxe.io/repos) page.
