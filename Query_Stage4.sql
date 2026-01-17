/*
START STAGE 4
*/
SELECT square_id,
       COUNT(DISTINCT p.spray_id) AS num_sprays
FROM Painting p
JOIN Spray s
    ON p.spray_id = s.id
GROUP BY square_id
HAVING SUM(p.volume) = 765 AND
       COUNT(DISTINCT p.spray_id) >= 3 AND
       COUNT(DISTINCT s.color) >= 3
ORDER BY square_id;
/*
END STAGE 4
*/

/*
Other Solution
--
select
    square_id,
    count(distinct spray_id) as num_sprays
from Painting
group by square_id
having sum(volume) = 765
       and num_sprays >= 3;
 */

/*
Other Solution
--
SELECT square_id, COUNT(DISTINCT spray_id) AS num_sprays
FROM Painting
GROUP BY square_id
HAVING
    SUM(volume) = 765
    AND COUNT(DISTINCT(
            SELECT color
            FROM Spray s
            WHERE s.id = spray_id) >= 3)
 */