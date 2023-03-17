### Оконные функции и CTE
| **Задача** | **Инструменты** | **SQL запрос** |
| -------------------- | :--------------------- | :--------------------- |
|Для каждого пользователя в таблице `user_actions` посчитайте порядковый номер каждого заказа. Отменённые заказы не учитывайте. Дополните запрос и с помощью оконной функции для каждого заказа каждого пользователя рассчитайте, сколько времени прошло с момента предыдущего заказа.  |`ROW_NUMBER`, `OVER(PARTITION BY ORDER BY)`|[Тык сюда](https://github.com/INLAE/SQL_karpov_course/blob/master/4.sql)|
|Сначала на основе таблицы `orders` сформируйте новую таблицу с общим числом заказов по дням. При подсчёте числа заказов не учитывайте отменённые заказы (их можно определить по таблице `user_actions`). Затем поместите полученную таблицу в подзапрос и расчитайте накопительную сумму числа заказов. В результате такой операции значение накопительной суммы для последнего дня должно получиться равным общему числу заказов за весь период.|`WITH t1 AS(), t2 AS()`, `OVER(ORDER BY date)` |[Тык сюда](https://github.com/INLAE/SQL_karpov_course/blob/master/3.sql)|
|Примените оконные функции к таблице `products` и с помощью ранжирующих функций упорядочьте все товары по цене — от самых дорогих к самым дешёвым. Добавьте в таблицу следующие колонки: `product_number` с порядковым номером товара. `product_rank` с рангом товара с пропусками рангов. `product_dense_rank` с рангом товара без пропусков рангов.|`ROW_NUMBER`, `RANK`, `DENSE_RANK`| [Тык сюда](https://github.com/INLAE/SQL_karpov_course/blob/master/1.sql)|
|В таблице `products`. Проставьте цену самого дорогого товара - max_price. Затем для каждого товара посчитайте долю его цены в стоимости самого дорогого товара price / max_price. Полученные доли округлите до двух знаков после запятой. Результат отсортируйте сначала по убыванию цены товара, затем по возрастанию id товара.|`MAX()` `OVER()`, `ROUND()`|[Тык сюда](https://github.com/INLAE/SQL_karpov_course/blob/master/2.sql)|
