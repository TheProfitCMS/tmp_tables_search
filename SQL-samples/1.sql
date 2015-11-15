/*
  SQL SAMPLE 1

  SQLITE: .read SQL-samples/1.sql
  PSQL:      \i SQL-samples/1.sql
*/
SELECT
  "products"."id",
  "products"."product_params_set_type",

  "product_params0_sets"."size_x",
  "product_params0_sets"."size_y",
  "product_params0_sets"."size_z",

  "product_params1_sets"."processor_type"

FROM
  "products"

LEFT OUTER JOIN
  "product_params0_sets"
  ON
  (
    "products"."product_params_set_type" = "ProductParams0Set"
    AND
    "products"."product_params_set_id" = "product_params0_sets"."id"
  )

LEFT OUTER JOIN
  "product_params1_sets"
  ON
  (
    "products"."product_params_set_type" = "ProductParams1Set"
    AND
    "products"."product_params_set_id" = "product_params1_sets"."id"
  )

WHERE
  "products"."product_params_set_type" IN ("ProductParams0Set", "ProductParams1Set")
  AND
  (
    "product_params1_sets"."processor_type" = 'A7'
    OR
    "product_params0_sets"."size_x" = '1'
  )

ORDER BY
  "products"."id" ASC,
  "product_params0_sets"."size_y" DESC

LIMIT 2 OFFSET 2
;