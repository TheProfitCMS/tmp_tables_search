/*
  Полная композиция всех данных по Товарам
  Для составления большой сводной таблицы для поиска
*/
SELECT
  "products".*,

  "product_params0_sets".*,
  "product_params1_sets".*

FROM
  "products"

LEFT OUTER JOIN
  "product_params0_sets"
  ON
    "products"."product_params_set_type" = "ProductParams0Set"
    AND
    "products"."product_params_set_id" = "product_params0_sets"."id"

LEFT OUTER JOIN
  "product_params1_sets"
  ON
    "products"."product_params_set_type" = "ProductParams1Set"
    AND
    "products"."product_params_set_id" = "product_params1_sets"."id"

WHERE
  "products"."id" = 1
;