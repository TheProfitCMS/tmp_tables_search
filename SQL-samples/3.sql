/*
  Выбрать все товары, из заданных категорий
  После выборки всех строк, получим из них только ID продуктов,
  путем группировки записей по "products"."id"

  Сортировка и выборка дополнительных полей только для наглядности
*/
SELECT
  "products"."id",

  "product_category_relations"."id",
  "product_category_relations"."product_id",
  "product_category_relations"."product_category_id"
FROM
  "products"

INNER JOIN
  "product_category_relations"
  ON
  "products"."id" = "product_category_relations"."product_id"

WHERE
  "product_category_relations"."product_category_id" IN (1, 2, 3)

GROUP BY
  "products"."id"

ORDER BY
  "products"."id" ASC
;