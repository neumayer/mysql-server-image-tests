#!/bin/sh

set -e

cleanup()
{
  docker stop mysql-server
  docker rm -vf mysql-server
}

trap "ret=$?;cleanup;exit $ret" EXIT

docker run -d --name mysql-server mysql/mysql-server
inspec exec mysql-server-inspec.rb --controls container
inspec exec mysql-server-inspec.rb -t docker://mysql-server --controls server-package
