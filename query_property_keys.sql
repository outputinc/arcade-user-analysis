SELECT DISTINCT JSON_KEYS(PARSE_JSON(properties)) as property_keys
FROM `second-casing-278016.arcade.events`
WHERE title = "Session.Start"
  AND server_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY)
LIMIT 10
