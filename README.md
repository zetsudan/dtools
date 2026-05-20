# dtools

Единая точка входа для 4 инструментов через **внешний порт `1640`**.

## Что теперь есть

- Nginx gateway доступен снаружи на `http://<host>:1640`.
- На корне `/` отдается стартовая страница с кнопками на все инструменты (как вы просили).
- Инструменты доступны по path-prefix:
  - `/zr-plus-spectrum-calculator/`
  - `/optical-circuit-merger/`
  - `/oel-merger/`
  - `/pw-planner/`

## Быстрый старт

### 1) Клонировать/обновить приложения

```bash
./scripts/bootstrap_apps.sh
```

### 2) Запустить

```bash
docker compose up -d --build
```

### 3) Проверить

- Главная с кнопками: `http://<host>:1640/`
- Инструменты:
  - `http://<host>:1640/zr-plus-spectrum-calculator/`
  - `http://<host>:1640/optical-circuit-merger/`
  - `http://<host>:1640/oel-merger/`
  - `http://<host>:1640/pw-planner/`

## Файлы

- `docker-compose.yml` — контейнеры и публикация порта `1640`.
- `nginx/nginx.conf` — reverse proxy маршруты и root-страница.
- `nginx/index.html` — стартовая страница с кнопками.
- `scripts/bootstrap_apps.sh` — загрузка/обновление репозиториев в `apps/`.

## Обслуживание

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


## Диагностика 502 Bad Gateway

Если главная `/` открывается, а тулзы дают `502`, почти всегда причина — несовпадение upstream-порта в `nginx` и фактического порта внутри контейнера приложения.

В этой конфигурации выставлены такие upstream-порты:

- `zr_plus-spectrum-calculator` -> `400`
- `optical-circuit-merger` -> `8000`
- `oel_merger` -> `9002`
- `pw_planner` -> `8000`

После изменений обязательно перезапустите:

```bash
docker compose down
docker compose up -d --build
```


## Важный фикс для работы за path-prefix

Исправлены две проблемы:

1. `zr-plus-spectrum-calculator` проксируется на фактический внутренний порт `400`.
2. Для `pw-planner` добавлены rewrite/sub_filter, чтобы корректно открывались стили и ассеты при работе не из `/`, а из `/pw-planner/`.

После применения обновлений выполните полный перезапуск:

```bash
docker compose down
docker compose up -d --build
```
