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
  lss.user_id,
  u.email,
  lss.os_name
FROM latest_session_start lss
LEFT JOIN `second-casing-278016.arcade_db_public.users` u ON lss.user_id = u.id
WHERE lss.rn = 1
  AND (lss.os_name LIKE "Mac OSX 10.%" OR lss.os_name LIKE "Mac OSX 11.%")
ORDER BY lss.os_name, lss.user_id
