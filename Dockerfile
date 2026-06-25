# syntax=docker/dockerfile:1
FROM docker.io/library/ruby:4@sha256:cc78012c8c6faaa2cd698535fff3b1c042301b8d49becec6691dd5c1af687d3a
WORKDIR /license-generator

RUN <<eot bash
  set -eux
  mkdir -p lib /tmp/gem
  cd /tmp/gem
  gem fetch gitlab-license -v 2.1.0
  tar -xf gitlab-license-2.1.0.gem data.tar.gz
  tar -xf data.tar.gz
  cp -r lib/gitlab/* /license-generator/lib/
  find /license-generator/lib -type f -name '*.rb' -exec sed -i "s|require 'gitlab/license/|require_relative 'license/|g" {} \;
  cd /
  rm -rf /tmp/gem
eot

COPY gen.sh generator.keys.rb generator.license.rb ./

CMD [ "./gen.sh" ]
