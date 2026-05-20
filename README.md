# dtools

Единая точка входа для инструментов через **порт `1640`** с reverse-proxy на Nginx.

## Маршруты

- Главная страница: `http://<host>:1640/home`
- Инструменты:
  - `http://<host>:1640/zr-plus-spectrum-calculator/`
  - `http://<host>:1640/optical-circuit-merger/`
  - `http://<host>:1640/oel-merger/`
  - `http://<host>:1640/pw-planner/`

`/` перенаправляет на `/home`.

## Источники

Код, статика и шаблоны приложений в `apps/*` синхронизированы из `raw/*`.
Домашняя страница и favicon взяты из `raw/homepage/html/*`.

## Запуск

```bash
docker compose up -d --build
```

## Остановка

```bash
docker compose down
```
