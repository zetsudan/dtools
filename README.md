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
