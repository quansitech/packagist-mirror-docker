#!/bin/bash
set -e

pushd /var/www || exit 1

# 循环执行镜像创建操作
while sleep "$SLEEP"; do
  php bin/mirror create
done

popd || exit 1

exec /bin/bash