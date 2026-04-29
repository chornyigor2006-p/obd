-- Агрегаційні функції (GROUP BY, HAVING)
 =================================================
---

**Query #1**

    -- 1. Підрахунок кількості душ для кожного виду гріха
    SELECT Sin, COUNT(*) AS souls_count
    FROM soul
    GROUP BY Sin;

| sin       | souls_count |
| --------- | ----------- |
| heresy    | 3           |
| lust      | 2           |
| greed     | 1           |
| gluttony  | 1           |
| fraud     | 1           |
| violence  | 1           |
| treachery | 1           |

---
**Query #2**

    -- 2. Середній вік демонів за їх статусом
    SELECT Status_a, AVG(Age) AS average_age
    FROM demon
    GROUP BY Status_a;

| status_a | average_age           |
| -------- | --------------------- |
| lesser   | 3075.0000000000000000 |
| supreme  | 6032.0000000000000000 |
| greater  | 2546.0000000000000000 |

---
**Query #3**

    -- 3. Мінімальний та максимальний вік демонів у базі
    SELECT MIN(Age) AS youngest_demon, MAX(Age) AS oldest_demon
    FROM demon;

| youngest_demon | oldest_demon |
| -------------- | ------------ |
| 1183           | 6032         |

---
**Query #4**

    -- 4. Гріхи, за якими закріплено більше 2 покарань
    SELECT required_sin, COUNT(*) AS punishments_count
    FROM punishment
    GROUP BY required_sin
    HAVING COUNT(*) >= 2;

| required_sin | punishments_count |
| ------------ | ----------------- |
| heresy       | 2                 |
| wrath        | 2                 |
| greed        | 2                 |

---

 =================================================
--Об'єднання таблиць 
=================================================
**Query #5**

    -- 5.Список покарань та імена демонів, які їх виконують
    SELECT p.name_of_punishment, d.Full_name AS demon_name, d.Status_a
    FROM punishment p
    INNER JOIN demon d ON p.performing_demon = d.ID;

| name_of_punishment     | demon_name     | status_a |
| ---------------------- | -------------- | -------- |
| Penalty_of_the_Sack    | Aamon          | lesser   |
| The_Boats              | Obyzouth       | greater  |
| The_Brazen_Bull        | kallikantzaros | lesser   |
| Keelhauling            | Obyzouth       | greater  |
| Drawing_and_Quartering | Rūha           | lesser   |
| The_Breaking_Wheel     | Lamia          | lesser   |
| Slow_Slicing           | Raum           | greater  |
| The_Iron_Maiden        | Raum           | greater  |
| Damnatio_ad_Demonas    | Azazel         | supreme  |
| The_Stocks_and_Pillory | Jikininki      | lesser   |

---
**Query #6**

    -- 6. Всі демони та покарання, які вони виконують
    SELECT d.Full_name, p.name_of_punishment
    FROM demon d
    LEFT JOIN punishment p ON d.ID = p.performing_demon;

| full_name      | name_of_punishment     |
| -------------- | ---------------------- |
| Aamon          | Penalty_of_the_Sack    |
| Obyzouth       | The_Boats              |
| kallikantzaros | The_Brazen_Bull        |
| Obyzouth       | Keelhauling            |
| Rūha           | Drawing_and_Quartering |
| Lamia          | The_Breaking_Wheel     |
| Raum           | Slow_Slicing           |
| Raum           | The_Iron_Maiden        |
| Azazel         | Damnatio_ad_Demonas    |
| Jikininki      | The_Stocks_and_Pillory |
| Gharrār        |                        |
| Malphas        |                        |

---
**Query #7**

    -- 7. Які демони мучать душі з певним гріхом 
    SELECT s.Full_name AS soul_name, s.Sin, p.name_of_punishment, d.Full_name AS demon_name
    FROM soul s
    JOIN punishment p ON s.Sin = p.required_sin
    JOIN demon d ON p.performing_demon = d.ID;

| soul_name | sin       | name_of_punishment     | demon_name     |
| --------- | --------- | ---------------------- | -------------- |
| sisyphus  | greed     | Penalty_of_the_Sack    | Aamon          |
| sisyphus  | greed     | The_Brazen_Bull        | kallikantzaros |
| Giorgos   | gluttony  | Drawing_and_Quartering | Rūha           |
| Maria     | lust      | The_Breaking_Wheel     | Lamia          |
| Minos     | lust      | The_Breaking_Wheel     | Lamia          |
| Panayotis | heresy    | Slow_Slicing           | Raum           |
| Eleni     | heresy    | Slow_Slicing           | Raum           |
| Giannis   | heresy    | Slow_Slicing           | Raum           |
| Panayotis | heresy    | The_Iron_Maiden        | Raum           |
| Eleni     | heresy    | The_Iron_Maiden        | Raum           |
| Giannis   | heresy    | The_Iron_Maiden        | Raum           |
| Sophia    | treachery | Damnatio_ad_Demonas    | Azazel         |
| Kostas    | violence  | The_Stocks_and_Pillory | Jikininki      |

---
 =================================================
-- ЧАСТИНА 3: Підзапити (Subqueries)
 ================================================
**Query #8**

    -- 8. знайти душі, чий гріх збігається з гріхами в таблиці покарань
    SELECT Full_name, Sin 
    FROM soul 
    WHERE Sin IN (SELECT required_sin FROM punishment);

| full_name | sin       |
| --------- | --------- |
| Minos     | lust      |
| sisyphus  | greed     |
| Giorgos   | gluttony  |
| Giannis   | heresy    |
| Maria     | lust      |
| Eleni     | heresy    |
| Kostas    | violence  |
| Panayotis | heresy    |
| Sophia    | treachery |

---
**Query #9**

    -- 9. Вивести назву покарання та загальну кількість демонів того ж статусу, що й виконавець
    SELECT name_of_punishment, 
           (SELECT COUNT(*) FROM demon d2 WHERE d2.Status_a = (SELECT Status_a FROM demon d1 WHERE d1.ID = p.performing_demon)) as peers_count
    FROM punishment p;

| name_of_punishment     | peers_count |
| ---------------------- | ----------- |
| Penalty_of_the_Sack    | 7           |
| The_Boats              | 2           |
| The_Brazen_Bull        | 7           |
| Keelhauling            | 2           |
| Drawing_and_Quartering | 7           |
| The_Breaking_Wheel     | 7           |
| Slow_Slicing           | 2           |
| The_Iron_Maiden        | 2           |
| Damnatio_ad_Demonas    | 1           |
| The_Stocks_and_Pillory | 7           |

---
**Query #10**

    -- 10. Знайти середню кількість душ на шарах, де популяція більша за 1 мільярд
    SELECT AVG(sub.Amount) as avg_pop_large_layers
    FROM (SELECT Amount_of_souls_inside as Amount FROM layer WHERE Amount_of_souls_inside > 1000000000) AS sub;

| avg_pop_large_layers |
| -------------------- |
| 7844724125.00000000  |

---
