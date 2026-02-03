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
)
SELECT 
  os_name,
  COUNT(DISTINCT user_id) as user_count
FROM latest_session_start
WHERE rn = 1
  AND (os_name LIKE "Mac OSX 10.%" OR os_name LIKE "Mac OSX 11.%")
GROUP BY os_name
ORDER BY os_name
