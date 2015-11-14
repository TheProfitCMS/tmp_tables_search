/*
  Полная композиция всех данных по Товарам
  Для составления большой сводной таблицы для поиска
*/
SELECT
  "products"."id",
  "products_brands_rels". "id" AS "brand_rels.id",
  "products_brands_rels". "brand_id",
  "brands"."title"

FROM
  "products"

LEFT JOIN
  "products_brands_rels"
  ON
    "products_brands_rels"."product_id" = "products"."id"

LEFT JOIN
  "brands"
  ON
    "products_brands_rels"."brand_id" = "brands"."id"

WHERE
  "products"."id" IN (1,4,99,2)
;