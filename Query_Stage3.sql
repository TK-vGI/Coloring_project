/*
START STAGE 3
*/
SELECT s.id,
       255 - COALESCE(SUM(p.volume), 0) AS remaining_volume
FROM Spray AS s
LEFT JOIN Painting AS p
    ON s.id = p.spray_id
GROUP BY s.id
ORDER BY s.id;

/*
END STAGE 3
*/

/*
Other Solution
--

 */

/*
Other Solution
--

 */

/*
Other Solution
--

 */