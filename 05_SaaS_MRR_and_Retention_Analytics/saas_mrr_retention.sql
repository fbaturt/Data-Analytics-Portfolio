WITH monthly_revenue AS (
    SELECT 
        p.user_id,
        p.game_name,
        u.language,
        u.age,
        DATE_TRUNC('month', p.payment_date)::DATE AS payment_month,
        SUM(p.revenue_amount_usd) AS mrr
    FROM 
        project.games_payments p
    LEFT JOIN 
        project.games_paid_users u 
        ON p.user_id = u.user_id AND p.game_name = u.game_name
    GROUP BY 
        1, 2, 3, 4, 5
),
user_status AS (
    SELECT
        user_id,
        game_name,
        language,
        age,
        payment_month,
        mrr,
        LAG(mrr) OVER(PARTITION BY user_id, game_name ORDER BY payment_month) AS previous_mrr,
        LAG(payment_month) OVER(PARTITION BY user_id, game_name ORDER BY payment_month) AS previous_month
    FROM 
        monthly_revenue
),
revenue_metrics AS (
    SELECT
        user_id,
        game_name,
        language,
        age,
        payment_month,
        mrr,
        CASE 
            WHEN previous_mrr IS NULL OR previous_month < (payment_month - INTERVAL '1 month')::DATE THEN mrr 
            ELSE 0 
        END AS new_mrr,
        CASE 
            WHEN previous_mrr IS NOT NULL AND previous_month = (payment_month - INTERVAL '1 month')::DATE AND mrr > previous_mrr THEN mrr - previous_mrr 
            ELSE 0 
        END AS expansion_mrr,
        CASE 
            WHEN previous_mrr IS NOT NULL AND previous_month = (payment_month - INTERVAL '1 month')::DATE AND mrr < previous_mrr THEN previous_mrr - mrr 
            ELSE 0 
        END AS contraction_mrr
    FROM 
        user_status
),
churn_data AS (
    SELECT
        user_id,
        game_name,
        language,
        age,
        (payment_month + INTERVAL '1 month')::DATE AS churn_month,
        mrr AS churned_revenue
    FROM 
        monthly_revenue
    WHERE 
        NOT EXISTS (
            SELECT 1 FROM monthly_revenue mr2 
            WHERE mr2.user_id = monthly_revenue.user_id 
              AND mr2.game_name = monthly_revenue.game_name
              AND mr2.payment_month = (monthly_revenue.payment_month + INTERVAL '1 month')::DATE
        )
)
SELECT 
    COALESCE(r.payment_month, c.churn_month) AS report_month,
    COALESCE(r.game_name, c.game_name) AS game_name,
    COALESCE(r.language, c.language) AS language,
    COALESCE(r.age, c.age) AS age,
    COUNT(DISTINCT r.user_id) AS paid_users,
    SUM(r.mrr) AS mrr,
    SUM(r.new_mrr) AS new_mrr,
    SUM(r.expansion_mrr) AS expansion_mrr,
    SUM(r.contraction_mrr) AS contraction_mrr,
    COUNT(DISTINCT c.user_id) AS churned_users,
    SUM(c.churned_revenue) AS churned_revenue
FROM 
    revenue_metrics r
FULL OUTER JOIN 
    churn_data c ON r.user_id = c.user_id 
                AND r.game_name = c.game_name 
                AND r.payment_month = c.churn_month
GROUP BY 
    1, 2, 3, 4
ORDER BY 
    1 DESC;