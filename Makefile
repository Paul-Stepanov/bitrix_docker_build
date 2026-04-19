include .env

.PHONY: up down restart build shell logs mysql-shell nginx-reload redis-cli ps

# Запуск всех сервисов
up:
	docker compose up -d

# Остановка всех сервисов
down:
	docker compose down

# Перезапуск сервисов
restart:
	docker compose restart

# Пересборка образов (без кеша)
build:
	docker compose build --no-cache

# Войти в оболочку PHP-контейнера
shell:
	docker compose exec php bash

# Логи всех сервисов (или указать: make logs S=nginx)
logs:
	docker compose logs -f $(S)

# MySQL-консоль
mysql-shell:
	docker compose exec mysql mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE)

# Redis-консоль
redis-cli:
	docker compose exec redis redis-cli

# Перезагрузить конфиг nginx
nginx-reload:
	docker compose exec nginx nginx -s reload

# Статус сервисов
ps:
	docker compose ps