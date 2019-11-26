load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

## Container

container_image(
    name = "awscli",
    base = "@ci_core//image",
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
    configs = ["//src/test_configs:command.yaml"],
    image = ":awscli",
)
