# Bitrix Docker Build

Docker-окружение для разработки проектов на 1С-Битрикс.

## Состав

- **Nginx** — веб-сервер (Alpine)
- **PHP-FPM** — с поддержкой Node.js и xDebug
- **MySQL** — база данных
- **Redis** — кэширование и сессии

## Требования

- Docker
- Docker Compose

## Установка

1. Скопируйте файл переменных окружения:
   ```bash
   cp .env.example .env
   ```

2. Отредактируйте `.env` под свой проект:
   ```bash
   MYSQL_ROOT_PASSWORD='ваш_пароль'
   MYSQL_DATABASE='название_бд'
   MYSQL_USER='пользователь_бд'
   MYSQL_PASSWORD='пароль_бд'
   PROJECT_NAME='название_проекта'
   ```

3. Разместите файлы проекта в директории `src/`

## Управление

### Запуск сервисов
```bash
make up
```

### Остановка сервисов
```bash
make down
```

### Перезапуск
```bash
make restart
```

### Пересборка образов
```bash
make build
```

## Полезные команды

### Войти в PHP-контейнер
```bash
make shell
```

### Просмотр логов
```bash
# Все сервисы
make logs

# Конкретный сервис
make logs S=nginx
make logs S=php
make logs S=mysql
```

### MySQL-консоль
```bash
make mysql-shell
```

### Redis-консоль
```bash
make redis-cli
```

### Перезагрузка Nginx
```bash
make nginx-reload
```

### Статус сервисов
```bash
make ps
```

## Структура проекта

```
.
├── src/              # Файлы проекта Битрикс
├── nginx/            # Конфигурация Nginx
│   ├── conf.d/       # Основные конфиги
│   ├── snippets/     # Инклуды
│   └── cache/        # Кэш изображений
├── php/              # Конфигурация PHP
│   ├── Dockerfile
│   ├── php.ini
│   └── www.conf
├── mysql/            # Конфигурация MySQL
│   ├── Dockerfile
│   ├── my.cnf
│   └── db/           # Дампы БД
├── logs/             # Логи сервисов
│   ├── nginx/
│   ├── php/
│   └── db/
├── .env              # Переменные окружения
├── docker-compose.yml
└── Makefile
```

## Настройка xDebug

Для работы отладки в PhpStorm:
1. Установите имя сервера xDebug в настройках PhpStorm равным значению `PHP_IDE_CONFIG_SERVER_NAME` из `.env`
2. Проверьте, что порт 9003 доступен

## Порты

- **Nginx**: `80` (настраивается через `PORT_NGINX`)
- **MySQL**: `3306` (настраивается через `PORT_MYSQL`)

## Лицензия

MIT