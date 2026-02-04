# Arcade User Analysis

BigQuery SQL project analyzing users on macOS versions < 12.

## Tech Stack
- BigQuery (project: `second-casing-278016`, table: `arcade.events`)
- `bq` CLI for query execution

## Structure
- `*.sql` - Query files
- `results/` - JSON/CSV output files

## Conventions
- Final queries use 90-day lookback window
- Exploratory queries use 1-day window to limit cost
- Tables are large; use LIMIT, short time windows, and other cost-reduction techniques
- Filter invalid user_ids: empty string, "0", null UUID
- Result filenames: `YYYYMMDD_HHMMSS_<description>.<ext>`
- Query filenames: `query_<description>.sql` (no timestamp)

## Running Queries
```bash
bq query --use_legacy_sql=false < query_file.sql
```

## Claude Usage
Read-only operations only. Do not execute queries or modify data.
