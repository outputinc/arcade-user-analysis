# BigQuery: macOS Pre-12 User Queries

Queries to find users whose latest Session.Start event indicates macOS earlier than version 12.

**Table:** `second-casing-278016.arcade.events`

## Queries

### query_users_macos_pre12.sql
Main query returning user_id, os_name, and timestamp for users on macOS < 12.

```bash
bq query --use_legacy_sql=false --format=prettyjson < query_users_macos_pre12.sql
```

### query_user_ids_only.sql
Returns user_id and os_name only (for CSV export).

```bash
bq query --use_legacy_sql=false --format=csv --max_rows=10000 < query_user_ids_only.sql > results/user_ids.csv
```

### query_users_by_os_version_summary.sql
Summary breakdown: count of users per OS version.

```bash
bq query --use_legacy_sql=false --format=prettyjson < query_users_by_os_version_summary.sql
```

### query_total_user_count.sql
Returns total count of users on macOS < 12.

```bash
bq query --use_legacy_sql=false --format=prettyjson < query_total_user_count.sql
```

### query_distinct_os_names.sql
Exploration query: all distinct OS.Name values (limited to last 1 day).

```bash
bq query --use_legacy_sql=false --format=prettyjson < query_distinct_os_names.sql
```

### query_property_keys.sql
Exploration query: available JSON keys in properties column (limited to last 1 day).

```bash
bq query --use_legacy_sql=false --format=prettyjson < query_property_keys.sql
```

## Configuration

- **Date window:** Edit `INTERVAL 90 DAY` in queries to adjust the lookback period
- **Excluded IDs:** Empty string, "0", and "00000000-0000-0000-0000-000000000000"

## macOS Version Mapping

| Version Pattern | macOS Name |
|-----------------|------------|
| 10.9.x | Mavericks |
| 10.10.x | Yosemite |
| 10.11.x | El Capitan |
| 10.12.x | Sierra |
| 10.13.x | High Sierra |
| 10.14.x | Mojave |
| 10.15.x | Catalina |
| 10.16 | Big Sur (compat) |
| 11.x | Big Sur |
| 12.x+ | Monterey and later (excluded) |
