/*
START STAGE 2
*/
SELECT s.color,
       SUM(p.volume) AS total_paint_used
FROM Spray AS s
LEFT JOIN Painting AS p
    ON s.id = p.spray_id
GROUP BY s.color
ORDER BY total_paint_used;

/*
END STAGE 2
*/