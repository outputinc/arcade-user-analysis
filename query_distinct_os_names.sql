SELECT DISTINCT JSON_VALUE(properties, "$.\"OS.Name\"") as os_name
FROM `second-casing-278016.arcade.events`
WHERE title = "Session.Start"
  AND server_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY)
ORDER BY os_name
