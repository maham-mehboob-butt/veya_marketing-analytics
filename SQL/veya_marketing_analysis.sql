CREATE DATABASE veya_marketing_analytics;
USE veya_marketing_analytics;
SHOW databases;
DROP TABLE IF EXISTS veya_marketing_analytics.tech_advertising_campaigns;
CREATE TABLE tech_advertising_campaigns (
    Campaign_Id VARCHAR(50),
    Campaign_Objective VARCHAR(100),
    Platform VARCHAR(50),
    Ad_Placement VARCHAR(100),
    Device_Type VARCHAR(50),
    Operating_System VARCHAR(50),
    Creative_Format VARCHAR(100),
    Creative_Size VARCHAR(50),
    Ad_Copy_Length VARCHAR(50),
    Has_Call_To_Action BOOLEAN,
    Creative_Emotion VARCHAR(100),
    Creative_Age_Days INT,
    Target_Audience_Age VARCHAR(50),
    Target_Audience_Gender VARCHAR(50),
    Audience_Interest_Category VARCHAR(100),
    Income_Bracket VARCHAR(50),
    Purchase_Intent_Score VARCHAR(50),
    Retargeting_Flag BOOLEAN,
    Start_Date DATE,
    Quarter INT,
    Day_Of_Week VARCHAR(30),
    Hour_Of_Day INT,
    Campaign_Day INT,
    Quality_Score INT,
    Actual_CPC DECIMAL(12,4),
    Impressions BIGINT,
    Clicks BIGINT,
    Conversions BIGINT,
    Ad_Spend DECIMAL(18,2),
    Revenue DECIMAL(18,2),
    Bounce_Rate DECIMAL(8,4),
    Avg_Session_Duration_Seconds INT,
    Pages_Per_Session DECIMAL(10,4),
    Industry_Vertical VARCHAR(100),
    Budget_Tier VARCHAR(50),
    CTR DECIMAL(10,6),
    Conversion_Rate DECIMAL(10,6),
    CPA DECIMAL(18,4),
    ROAS DECIMAL(12,6),
    Profit DECIMAL(18,2)
);
USE veya_marketing_analytics;

ALTER TABLE tech_advertising_campaigns
MODIFY COLUMN Has_Call_To_Action VARCHAR(50),
MODIFY COLUMN Retargeting_Flag VARCHAR(50),
MODIFY COLUMN Clicks VARCHAR(50),
MODIFY COLUMN Conversions VARCHAR(50),
MODIFY COLUMN Ad_Spend VARCHAR(50),
MODIFY COLUMN Revenue VARCHAR(50),
MODIFY COLUMN Bounce_Rate VARCHAR(50),
MODIFY COLUMN Avg_Session_Duration_Seconds VARCHAR(50),
MODIFY COLUMN Pages_Per_Session VARCHAR(50),
MODIFY COLUMN CTR VARCHAR(50),
MODIFY COLUMN Conversion_Rate VARCHAR(50),
MODIFY COLUMN CPA VARCHAR(50),
MODIFY COLUMN ROAS VARCHAR(50),
MODIFY COLUMN Profit VARCHAR(50);
SELECT COUNT(*) AS total_records
FROM tech_advertising_campaigns;
SELECT Campaign_Id, COUNT(*) AS record_count
FROM tech_advertising_campaigns
GROUP BY Campaign_Id
HAVING COUNT(*) > 1;
SELECT
    COUNT(*) AS total_records,
    SUM(Campaign_Id IS NULL) AS missing_campaign_id,
    SUM(Platform IS NULL) AS missing_platform,
    SUM(Impressions IS NULL) AS missing_impressions,
    SUM(Clicks IS NULL) AS missing_clicks,
    SUM(Conversions IS NULL) AS missing_conversions,
    SUM(Ad_Spend IS NULL) AS missing_ad_spend,
    SUM(Revenue IS NULL) AS missing_revenue,
    SUM(Profit IS NULL) AS missing_profit
FROM tech_advertising_campaigns;
SELECT
    SUM(Impressions < 0) AS negative_impressions,
    SUM(Clicks < 0) AS negative_clicks,
    SUM(Conversions < 0) AS negative_conversions,
    SUM(Ad_Spend < 0) AS negative_ad_spend,
    SUM(Revenue < 0) AS negative_revenue
FROM tech_advertising_campaigns;
SELECT DISTINCT Platform
FROM tech_advertising_campaigns
ORDER BY Platform;
SELECT DISTINCT Device_Type
FROM tech_advertising_campaigns
ORDER BY Device_Type;
SELECT DISTINCT Campaign_Objective
FROM tech_advertising_campaigns
ORDER BY Campaign_Objective;
SELECT
    MIN(CTR) AS min_ctr,
    MAX(CTR) AS max_ctr,
    MIN(Conversion_Rate) AS min_conversion_rate,
    MAX(Conversion_Rate) AS max_conversion_rate,
    MIN(CPA) AS min_cpa,
    MAX(CPA) AS max_cpa,
    MIN(ROAS) AS min_roas,
    MAX(ROAS) AS max_roas
FROM tech_advertising_campaigns;
SELECT *
FROM tech_advertising_campaigns
LIMIT 10;
SELECT
    COUNT(*) AS total_campaign_records,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Conversions) AS total_conversions,
    SUM(Ad_Spend) AS total_ad_spend,
    SUM(Revenue) AS total_revenue,
    SUM(Profit) AS total_profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS overall_ctr,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS overall_conversion_rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS overall_cpa,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS overall_roas

FROM tech_advertising_campaigns;
SELECT
    Platform,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Platform
ORDER BY ROAS DESC;
SELECT
    Platform,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Platform
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Platform,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Platform
ORDER BY ROAS ASC
LIMIT 1;
SELECT
    Campaign_Objective,

    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,

    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Campaign_Objective
ORDER BY ROAS DESC;
SELECT
    Campaign_Objective,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Campaign_Objective
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Campaign_Objective,
    ROUND(SUM(Profit), 2) AS Profit
FROM tech_advertising_campaigns
GROUP BY Campaign_Objective
ORDER BY Profit DESC
LIMIT 1;
SELECT
    Target_Audience_Age,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Target_Audience_Age
ORDER BY ROAS DESC;
SELECT
    Target_Audience_Gender,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Target_Audience_Gender
ORDER BY ROAS DESC;
SELECT
    Purchase_Intent_Score,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Purchase_Intent_Score
ORDER BY ROAS DESC;
SELECT
    Retargeting_Flag,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Retargeting_Flag
ORDER BY ROAS DESC;
SELECT
    Device_Type,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Device_Type
ORDER BY ROAS DESC;
SELECT
    Operating_System,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Operating_System
ORDER BY ROAS DESC;
SELECT
    Device_Type,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Device_Type
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Operating_System,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Operating_System
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Quarter,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Quarter
ORDER BY Quarter;
SELECT
    MONTH(Start_Date) AS Month_Number,
    MONTHNAME(Start_Date) AS Month_Name,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY
    MONTH(Start_Date),
    MONTHNAME(Start_Date)
ORDER BY Month_Number;
SELECT
    Day_Of_Week,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Day_Of_Week
ORDER BY ROAS DESC;
SELECT
    Hour_Of_Day,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Hour_Of_Day
ORDER BY Hour_Of_Day;
SELECT
    Creative_Format,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Creative_Format
ORDER BY ROAS DESC;
SELECT
    Ad_Placement,
    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY Ad_Placement
ORDER BY ROAS DESC;
SELECT
    Creative_Format,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Creative_Format
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Ad_Placement,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Ad_Placement
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Campaign_Id,
    Campaign_Objective,
    Platform,

    SUM(Impressions) AS Impressions,
    SUM(Clicks) AS Clicks,
    SUM(Conversions) AS Conversions,

    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns
GROUP BY
    Campaign_Id,
    Campaign_Objective,
    Platform
ORDER BY ROAS DESC;
SELECT
    Campaign_Id,
    Platform,
    Campaign_Objective,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY
    Campaign_Id,
    Platform,
    Campaign_Objective
ORDER BY ROAS DESC
LIMIT 10;
SELECT
    Campaign_Id,
    Platform,
    Campaign_Objective,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY
    Campaign_Id,
    Platform,
    Campaign_Objective
HAVING SUM(Ad_Spend) > 0
ORDER BY ROAS ASC
LIMIT 10;
SELECT
    Campaign_Id,
    Platform,
    Campaign_Objective,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY
    Campaign_Id,
    Platform,
    Campaign_Objective
ORDER BY Profit DESC
LIMIT 10;
SELECT
    Platform,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS,
    RANK() OVER (
        ORDER BY SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0) DESC
    ) AS ROAS_Rank
FROM tech_advertising_campaigns
GROUP BY Platform
ORDER BY ROAS_Rank;
SELECT
    Campaign_Objective,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS,
    RANK() OVER (
        ORDER BY SUM(Profit) DESC
    ) AS Profit_Rank
FROM tech_advertising_campaigns
GROUP BY Campaign_Objective
ORDER BY Profit_Rank;
SELECT
    Target_Audience_Age,
    Target_Audience_Gender,
    Purchase_Intent_Score,
    Retargeting_Flag,

    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns

GROUP BY
    Target_Audience_Age,
    Target_Audience_Gender,
    Purchase_Intent_Score,
    Retargeting_Flag

HAVING SUM(Ad_Spend) > 0

ORDER BY ROAS DESC
LIMIT 10;
SELECT
    CASE
        WHEN Retargeting_Flag = 1 THEN 'Retargeting'
        ELSE 'Non-Retargeting'
    END AS Retargeting_Type,

    SUM(Conversions) AS Conversions,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS

FROM tech_advertising_campaigns

GROUP BY Retargeting_Flag
ORDER BY ROAS DESC;
SELECT
    Campaign_Id,
    Platform,
    Campaign_Objective,

    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS,

    CASE
        WHEN SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0) >= 8
            THEN 'High ROAS'
        WHEN SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0) >= 5
            THEN 'Medium ROAS'
        ELSE 'Low ROAS'
    END AS Performance_Category

FROM tech_advertising_campaigns

GROUP BY
    Campaign_Id,
    Platform,
    Campaign_Objective

ORDER BY ROAS DESC;
SELECT
    Platform,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS,

    CASE
        WHEN SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0) >= 8
            THEN 'Consider Increasing Investment'
        WHEN SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0) >= 5
            THEN 'Maintain & Optimize'
        ELSE 'Review / Optimize'
    END AS Budget_Action

FROM tech_advertising_campaigns

GROUP BY Platform

ORDER BY ROAS DESC;
SELECT
    Platform,
    ROUND(SUM(Ad_Spend), 2) AS Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Platform
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Campaign_Objective,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Campaign_Objective
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Target_Audience_Age,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Target_Audience_Age
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Purchase_Intent_Score,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Purchase_Intent_Score
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Device_Type,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Device_Type
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Quarter,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Quarter
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Creative_Format,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Creative_Format
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    Ad_Placement,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS ROAS
FROM tech_advertising_campaigns
GROUP BY Ad_Placement
ORDER BY ROAS DESC
LIMIT 1;
SELECT
    COUNT(*) AS Campaign_Records,
    SUM(Impressions) AS Total_Impressions,
    SUM(Clicks) AS Total_Clicks,
    SUM(Conversions) AS Total_Conversions,

    ROUND(SUM(Ad_Spend), 2) AS Total_Ad_Spend,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit,

    ROUND(
        SUM(Clicks) / NULLIF(SUM(Impressions), 0) * 100,
        2
    ) AS Overall_CTR,

    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Overall_Conversion_Rate,

    ROUND(
        SUM(Ad_Spend) / NULLIF(SUM(Conversions), 0),
        2
    ) AS Overall_CPA,

    ROUND(
        SUM(Revenue) / NULLIF(SUM(Ad_Spend), 0),
        2
    ) AS Overall_ROAS

FROM tech_advertising_campaigns;
