# Лабораторна Робота №1

виконав роботу Чорний Ігор з групи ІО-44

в цій роботі треба зробити декілька OLTP-запитів для перевірки себе та бази данних

```
код під запити
-- 1. SELECT (Фільтрація демонів)
SELECT Full_name, Age 
FROM demon 
WHERE Status_a = 'lesser';

-- 2. SELECT (Фільтрація душ)
SELECT Full_name, Date_of_arrival 
FROM soul 
WHERE Sin = 'heresy';

-- 3. UPDATE (Зміна статусу демона)
UPDATE demon 
SET Status_a = 'greater' 
WHERE ID = 12312;

-- (тут результат)
SELECT * FROM demon WHERE ID = 12312;

-- 4. UPDATE (Зміна кількості душ на 1-му шарі)
UPDATE layer 
SET Amount_of_souls_inside = 13299200500 
WHERE Numerical_order = 1;

-- (тут результат)
SELECT * FROM layer WHERE Numerical_order = 1;

-- 5. DELETE (Видалення душі)
DELETE FROM soul 
WHERE ID = 54999491002345;

-- (аблиця всіх душ, щоб було видно що нема Maria)
SELECT * FROM soul;

--(тут insert про який я забув спочатку щоб додати нову душу)
INSERT INTO soul (ID, Full_name, Sin, Date_of_arrival) 
VALUES (742346234427, 'Illuseus', 'violence', '1924-04-21');

SELECT * FROM soul WHERE ID = 742346234427; 
```

і скріни результатів
![працює?](images/Снимок экрана 2026-04-29 194101.png)
![працює?](images/Снимок экрана 2026-04-29 194109.png)
![працює?](images/Снимок экрана 2026-04-29 194117.png)
![працює?](images/Снимок экрана 2026-04-29 194135.png)
![працює?](images/Снимок экрана 2026-04-29 194148.png)
![працює?](images/Снимок экрана 2026-04-29 194155.png)

все працюэ правильно
(і так це сайт який мені сказав хтось використати, я скачав pgAdmin але я не знаю як поставити туда той сервер бо мені каже що там не той пароль а який пароль я не знаю, сподіваюсь за це не - бали)