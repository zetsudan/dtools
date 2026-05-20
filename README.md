# dtools

Единая точка входа для 4 инструментов через один порт `1640`.

## Что сделано

- На порту `1640` поднимается `nginx`-gateway.
- Каждый инструмент запускается как отдельный контейнер в одной `docker-compose` сети.
- Маршрутизация (reverse proxy):
  - `/zr-plus-spectrum-calculator/` -> `zr_plus_spectrum_calculator:3000`
  - `/optical-circuit-merger/` -> `optical_circuit_merger:3000`
  - `/oel-merger/` -> `oel_merger:3000`
  - `/pw-planner/` -> `pw_planner:3000`

## Структура

- `docker-compose.yml` — оркестрация контейнеров.
- `nginx/nginx.conf` — проксирование по path-prefix.
- `scripts/bootstrap_apps.sh` — скрипт для клонирования/обновления 4 репозиториев в `apps/`.

## Быстрый старт

### 1) Клонировать инструменты в `apps/`

```bash
./scripts/bootstrap_apps.sh
```

### 2) Запустить все сервисы

```bash
docker compose up -d --build
```

### 3) Проверить

- http://localhost:1640/zr-plus-spectrum-calculator/
- http://localhost:1640/optical-circuit-merger/
- http://localhost:1640/oel-merger/
- http://localhost:1640/pw-planner/

## Важно

1. Конфигурация рассчитана на то, что внутри каждого сервиса приложение слушает `3000` порт.
2. Если конкретный инструмент слушает другой порт, поменяйте целевой порт в `nginx/nginx.conf` и/или Dockerfile соответствующего проекта.
3. Для SPA-приложений иногда нужно задать `basePath`/`publicPath` под соответствующий префикс маршрута.

## Команды обслуживания

Остановить:

```bash
docker compose down
```

Обновить исходники инструментов:

```bash
./scripts/bootstrap_apps.sh
```

Пересобрать после обновления:

```bash
docker compose up -d --build
```
