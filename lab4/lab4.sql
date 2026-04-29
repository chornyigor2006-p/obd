-- 1. Підрахунок кількості душ для кожного виду гріха
SELECT Sin, COUNT(*) AS souls_count
FROM soul
GROUP BY Sin;

-- 2. Середній вік демонів за їх статусом
SELECT Status_a, AVG(Age) AS average_age
FROM demon
GROUP BY Status_a;

-- 3. Мінімальний та максимальний вік демонів у базі
SELECT MIN(Age) AS youngest_demon, MAX(Age) AS oldest_demon
FROM demon;

-- 4. Гріхи, за якими закріплено більше 2 покарань
SELECT required_sin, COUNT(*) AS punishments_count
FROM punishment
GROUP BY required_sin
HAVING COUNT(*) >= 2;

-- 5.Список покарань та імена демонів, які їх виконують
SELECT p.name_of_punishment, d.Full_name AS demon_name, d.Status_a
FROM punishment p
INNER JOIN demon d ON p.performing_demon = d.ID;

-- 6. Всі демони та покарання, які вони виконують
SELECT d.Full_name, p.name_of_punishment
FROM demon d
LEFT JOIN punishment p ON d.ID = p.performing_demon;

-- 7. Які демони мучать душі з певним гріхом 
SELECT s.Full_name AS soul_name, s.Sin, p.name_of_punishment, d.Full_name AS demon_name
FROM soul s
JOIN punishment p ON s.Sin = p.required_sin
JOIN demon d ON p.performing_demon = d.ID;

-- 8. знайти душі, чий гріх збігається з гріхами в таблиці покарань
SELECT Full_name, Sin 
FROM soul 
WHERE Sin IN (SELECT required_sin FROM punishment);

-- 9. Вивести назву покарання та загальну кількість демонів того ж статусу, що й виконавець
SELECT name_of_punishment, 
       (SELECT COUNT(*) FROM demon d2 WHERE d2.Status_a = (SELECT Status_a FROM demon d1 WHERE d1.ID = p.performing_demon)) as peers_count
FROM punishment p;

-- 10. Знайти середню кількість душ на шарах, де популяція більша за 1 мільярд
SELECT AVG(sub.Amount) as avg_pop_large_layers
FROM (SELECT Amount_of_souls_inside as Amount FROM layer WHERE Amount_of_souls_inside > 1000000000) AS sub;