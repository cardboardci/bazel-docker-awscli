# Docker AWSCLI Built with Bazel

> The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services. With just one tool to download and configure, you can control multiple AWS services from the command line and automate them through scripts.

CardboardCI aims to create a collection of docker images that can be used in continuous integration. These images will have all dependencies pinned, to ensure that any commit will produce the exact same image (or as close to as possible). The aim of this repository is to build [docker-awscli](https://github.com/cardboardci/docker-awscli) in Bazel, to evaluate whether it would help fit those goals.

Additionally it helps to test whether Bazel could work under GitHub Actions, or would require another service to build.

## Notes

If I were to use this for CardboardCI, I'd probably need to develop/use packer manager rules for the following:

- GitHub Releases
- NPM
- RubyGems
- AptGet

And potentially some edge cases with LaTeX and Lua (`luarocks`).

### Package Manager Rules

For the package managers that would need rules, they would follow the format of the existing `download_pkgs` (`f(deps[]) => tarball`). Most of the package managers used in CardboardCI have some way to download but not install the packages. Here are some examples of the rule usages:

```python
download_npm(
    name = "pkgs",
    image_tar = "@ubuntu//image",
    packages = [
        "surge:0.0.1",
    ],

    # Could we read all of the packages from a file?
    # packages_file = ":file"
)
```

If the rule could support a way of providing a file, then the same automated process as now could be used for upgrading the dependencies. The big problem I see with this is that if only 1 dependency changes, we must re-download all of the other dependencies. The option of bazel-ifying each dependency as a rule would create problems with updating (e.g. how to update version). This isn't too bad if there exists a file like so:

```python
load("@io_bazel_rules_docker//docker/package_managers:download_npm.bzl", "download_npm")

download_npm(
    name = "pkg_surge",
    image_tar = "@ubuntu//image",
    src = ":surge.dep"
)
```

With the `.dep` file looking something like this:

```toml
name="surge"
version="0.0.1"
```

## Conclusions

Below I have included jot notes for my conclusions on using Bazel to build docker images for CardboardCI:

- Most of the images can be built using Bazel
- Some images may require bazel-ifying the source projects
- Windows support is lacking, and the resulting errors are difficult to investigate
- The errors are sometimes opaque (e.g. `/tmp/installer OCI runtime error`)
- Bazel rules would be needed for other package managers (`npm`, `rubygems`, `luarocks`, etc)
- `container_run_and_commit` allows for half-in half-out development
- Having each image defined with bazel could have some benefits if it was all-in

I don't feel that there is a compelling reason to try and implement the docker images in Bazel, and more than enough reasons why it isn't worthwhile at the moment.
