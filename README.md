# Docker images built with Bazel

Building docker images with Bazel on GitHub Actions.

I wanted to take a look at what it would take to use Bazel for the images defined in CardboardCI. My conclusions are that:

* Yes, it could work for building images
* It _potentially_ lacks windows support (maybe be missing in some cases, may not)
* Need new bazel rules for package managers (npm, RubyGems, AptGet)

## Notes

If I were to use this for CardboardCI, I'd probably need to develop/use packer manager rules for the following:

* GitHub Releases
* NPM
* RubyGems
* AptGet

And potentially some edge cases with LaTeX and Lua (`luarocks`).

For the rules that need development, the rules for each of the packages would work something like this (`f(deps[]) => tarball`):

```python
download_npm(
    name = "pkgs",
    image_tar = "@ubuntu//image",
    packages = [
        "surge:0.0.1",
    ],

    # packages_file = ":file"
)
```

Rule per dependency would require everything to be expressed in bazel, while a rule per package manager allows for the dependencies to be expressed in an external file. That makes it so an automated process can be done for upgrading the version pins for every package.

```json
{
    "package1": "1.0.0",
    "package2": "1.0.1",
    "package3": "1.1.0"
}
```
