#!/bin/bash

# Добавляем задачу в crontab
(crontab -l 2>/dev/null; echo "*/1 * * * * /usr/local/bin/php -d xdebug.mode=off -f /var/www/html/bitrix/php_interface/cron_events.php >> /var/log/php/cron.log 2>&1") | crontab -

# Запускаем cron в фоновом режиме
service cron start

# Запускаем php-fpm (основной процесс)
exec php-fpm
