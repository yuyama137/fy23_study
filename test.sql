---- 特定変数を期間絞って日次xproduct_cdで集計
-- selectがwhereより後なので、dateで括るな前もって変換しておく必要がある
-- where句の中でcastする方法もあるが、selctとwhereで2回castが必要になり、個人的に嫌だ
with a as (
SELECT
    date(date_parse(sales_ymd, '%Y%m%d')) as sales_ymd,
    product_cd,
    quantity
FROM yamamura_database_test.receipt
)
select
    sales_ymd,
    product_cd,
    SUM(quantity) as quantity
FROM a
WHERE sales_ymd BETWEEN DATE('2018-01-01') AND DATE('2018-12-31') --""で括るとカラム名として認識されてしまってダメです。
group by sales_ymd, product_cd
order by sales_ymd;

-- 毎日の売上
with a as (
SELECT
    date(date_parse(sales_ymd, '%Y%m%d')) as sales_ymd,
    product_cd,
    amount
FROM yamamura_database_test.receipt
)
select
    sales_ymd,
    SUM(amount) as amount
FROM a
WHERE sales_ymd BETWEEN DATE('2018-01-01') AND DATE('2018-12-31') --""で括るとカラム名として認識されてしまってダメです。
group by sales_ymd
order by sales_ymd;