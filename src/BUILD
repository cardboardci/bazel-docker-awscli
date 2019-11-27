load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")

## Packages

download_pkgs(
    name = "pkgs_dwnld",
    image_tar = "@ci_core//image",
    packages = [
        "python",
        "python-dev",
        "python-pip",
        "python3",
        "python3-pip",
    ],
)

install_pkgs(
    name = "pkgs",
    image_tar = "@ci_core//image",
    installables_tar = ":pkgs_dwnld.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "pkgs",
)


## Container

container_image(
    name = "awscli",
    base = ":pkgs//image",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = [
        "//src/image_data:cardboardci",
    ],
    labels = {
        "maintainer": "CardboardCI",
        "org.label-schema.schema-version": "1.0",
        "org.label-schema.name": "awscli",
        "org.label-schema.version": "1.16",
        "org.label-schema.release=": "CardboardCI version:1.16",
        "org.label-schema.vendor": "cardboardci",
        "org.label-schema.architecture": "amd64",
        "org.label-schema.summary": "AWS CLI",
        "org.label-schema.description": "The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
        "org.label-schema.url": "https://github.com/cardboardci/docker-awscli",
        "org.label-schema.changelog-url": "https://github.com/cardboardci/docker-awscli",
        "org.label-schema.authoritative-source-url": "https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/awscli",
        "org.label-schema.distribution-scope": "public",
        "org.label-schema.vcs-type": "git",
        "org.label-schema.vcs-url": "https://github.com/cardboardci/docker-awscli",
        # "org.label-schema.vcs-ref": "{vcs_ref}",
    },

    # The path /workspace is made available for all development work
    volumes = [
        "/workspace",
    ],
)

# Tests

container_test(
    name = "awscli_metadata_test",
    configs = ["//src/test_configs:metadata.yaml"],
    image = ":awscli",
)
