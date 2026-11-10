#!/bin/bash

git fetch https://github.com/NikoCat233/v2board.git 'refs/heads/feat/一个订阅可关联多个权限组' &&
git merge --ff-only FETCH_HEAD || exit 1

rm -rf composer.phar
wget https://github.com/composer/composer/releases/latest/download/composer.phar -O composer.phar
php composer.phar install -vvv

php_main_version=$(php -v | head -n 1 | cut -d ' ' -f 2 | cut -d '.' -f 1)
if [ $php_main_version -ge 8 ]; then
    php composer.phar require joanhey/adapterman
fi

php artisan v2board:install

if [ -f "/etc/init.d/bt" ]; then
  chown -R www $(pwd);
fi
