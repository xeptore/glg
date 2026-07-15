# syntax=docker/dockerfile:1
FROM docker.io/library/ruby:4@sha256:a30f43237b10af263f5056210860c9163601d6a921d44149cf87525d5022e380
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
