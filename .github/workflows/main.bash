#!/bin/bash
bazel --output_base=/github/home/bazel_outputs test --test_output=all //src:all  || true
# chmod 777 /tmp/installer.sh
chmod +x /tmp/installer.sh
bazel --output_base=/github/home/bazel_outputs test --test_output=all //src:all