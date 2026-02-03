-- Find users whose latest Session.Start event in last 90 days indicates macOS < 12
-- Date window: 90 days (configurable)

WITH latest_session_start AS (
  SELECT 
    user_id,
    JSON_VALUE(properties, "$.\"OS.Name\"") as os_name,
    server_timestamp,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY server_timestamp DESC) as rn
  FROM `second-casing-278016.arcade.events`
  WHERE title = "Session.Start"
    AND server_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
    AND user_id IS NOT NULL
    AND user_id != ""
    AND user_id != "0"
    AND user_id != "00000000-0000-0000-0000-000000000000"
)
SELECT 
  user_id,
  os_name,
  server_timestamp as latest_session_start_timestamp
FROM latest_session_start
WHERE rn = 1
  AND (os_name LIKE "Mac OSX 10.%" OR os_name LIKE "Mac OSX 11.%")
ORDER BY os_name, user_id
