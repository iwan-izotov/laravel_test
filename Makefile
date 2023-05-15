include ./docker/docker-compose/docker_env

## Объединяет все env файлы в одну команду
ENV_COMMAND = --env-file=./docker/docker-compose/docker_env

## Объединяет все docker-compose файлы в одну команду 
FILE_COMMAND = -f ./docker/docker-compose/docker-compose.yml

## Устанавливаем рабочую директорию
PD_COMMAND = --project-directory ./

DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: docker-prune
docker-prune: ## Удаляет неиспользуемые ресурсы докера с помощью 'docker system prune -a -f --volumes'
	docker system prune -a -f --volumes

.PHONY: docker-up
docker-up: ## Запускает все Docker-контейнеры в фоновом режиме
	docker-compose $(FILE_COMMAND) $(ENV_COMMAND) -p $(PROJECT) $(PD_COMMAND) up -d --build

.PHONY: docker-down
docker-down: ## Останавливает контейнеры и удаляет их
	docker-compose $(FILE_COMMAND) $(ENV_COMMAND) -p $(PROJECT) $(PD_COMMAND) down --remove-orphans

.PHONY: docker-down-volume
docker-down-volume: ## Останавливает контейнеры, удаляет контейнеры и ТОМА!!!
	docker-compose $(FILE_COMMAND) $(ENV_COMMAND) -p $(PROJECT) $(PD_COMMAND) down -v

.PHONY: console
console: ## Запускает bash на контейнере php-fpm (для запуска консольных команд)
	docker exec -it $(PROJECT)_php_fpm bash -c 'cd /var/www/project/ && bash'

.PHONY: console-nginx
console-nginx: ## Запускает bash на контейнере nginx
	docker exec -it $(PROJECT)_nginx bash

.PHONY: clear-cache
clear-cache: ## Очищает весь кеш в memcached
	docker exec -it $(PROJECT)_memcached bash -c 'echo flush_all > /dev/tcp/localhost/11211'
