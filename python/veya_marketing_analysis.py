import pandas as pd

# Path to your fresh dataset
file_path = "data/processed/tech_advertising_campaigns_processed.xlsx"

df = pd.read_excel(file_path, engine="openpyxl")

print("Dataset Shape:")
print(df.shape)

print("\nColumn Names:")
print(df.columns.tolist())

print("\nFirst 5 Rows:")
print(df.head())

print("\nData Types:")
print(df.dtypes)

print("\nMissing Values:")
print(df.isnull().sum())

print("\nDuplicate Rows:")
print(df.duplicated().sum())
df.describe(include="all").T

total_impressions = df["Impressions"].sum()
total_clicks = df["Clicks"].sum()
total_conversions = df["Conversions"].sum()
total_spend = df["Ad_Spend"].sum()
total_revenue = df["Revenue"].sum()
total_profit = df["Profit"].sum()

overall_ctr = (total_clicks / total_impressions) * 100
overall_conversion_rate = (total_conversions / total_clicks) * 100
overall_cpa = total_spend / total_conversions
overall_roas = total_revenue / total_spend

kpi_summary = pd.DataFrame({
    "KPI": [
        "Total Impressions",
        "Total Clicks",
        "Total Conversions",
        "Total Ad Spend",
        "Total Revenue",
        "Total Profit",
        "Overall CTR (%)",
        "Overall Conversion Rate (%)",
        "Overall CPA",
        "Overall ROAS"
    ],
    "Value": [
        total_impressions,
        total_clicks,
        total_conversions,
        total_spend,
        total_revenue,
        total_profit,
        overall_ctr,
        overall_conversion_rate,
        overall_cpa,
        overall_roas
    ]
})

kpi_summary
kpi_summary["Value"] = kpi_summary["Value"].round(2)

print(kpi_summary)

platform_analysis = (
    df.groupby("Platform")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

# Calculate KPIs from aggregated values
platform_analysis["CTR (%)"] = (
    platform_analysis["Clicks"] /
    platform_analysis["Impressions"] * 100
)

platform_analysis["Conversion_Rate (%)"] = (
    platform_analysis["Conversions"] /
    platform_analysis["Clicks"] * 100
)

platform_analysis["CPA"] = (
    platform_analysis["Ad_Spend"] /
    platform_analysis["Conversions"]
)

platform_analysis["ROAS"] = (
    platform_analysis["Revenue"] /
    platform_analysis["Ad_Spend"]
)

# Round KPI values
platform_analysis = platform_analysis.round(2)

# Sort by ROAS
platform_analysis = platform_analysis.sort_values(
    "ROAS",
    ascending=False
)

print(platform_analysis)
best_platform = platform_analysis.iloc[0]

print("Best Platform by ROAS:")
print(best_platform["Platform"])
print("ROAS:", best_platform["ROAS"])
print("Profit:", best_platform["Profit"])
most_profitable_platform = platform_analysis.loc[
    platform_analysis["Profit"].idxmax()
]

print("Most Profitable Platform:")
print(most_profitable_platform["Platform"])
print("Profit:", most_profitable_platform["Profit"])
print("ROAS:", most_profitable_platform["ROAS"])

objective_analysis = (
    df.groupby("Campaign_Objective")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

# Calculate KPIs
objective_analysis["CTR (%)"] = (
    objective_analysis["Clicks"] /
    objective_analysis["Impressions"] * 100
)

objective_analysis["Conversion_Rate (%)"] = (
    objective_analysis["Conversions"] /
    objective_analysis["Clicks"] * 100
)

objective_analysis["CPA"] = (
    objective_analysis["Ad_Spend"] /
    objective_analysis["Conversions"]
)

objective_analysis["ROAS"] = (
    objective_analysis["Revenue"] /
    objective_analysis["Ad_Spend"]
)

objective_analysis = objective_analysis.round(2)

# Highest ROAS first
objective_analysis = objective_analysis.sort_values(
    "ROAS",
    ascending=False
)

print(objective_analysis)
best_objective = objective_analysis.iloc[0]

print("Best Campaign Objective by ROAS:")
print(best_objective["Campaign_Objective"])
print("ROAS:", best_objective["ROAS"])
print("Profit:", best_objective["Profit"])
most_profitable_objective = objective_analysis.loc[
    objective_analysis["Profit"].idxmax()
]

print("Most Profitable Campaign Objective:")
print(most_profitable_objective["Campaign_Objective"])
print("Profit:", most_profitable_objective["Profit"])
print("ROAS:", most_profitable_objective["ROAS"])

age_analysis = (
    df.groupby("Target_Audience_Age")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

age_analysis["CTR (%)"] = (
    age_analysis["Clicks"] /
    age_analysis["Impressions"] * 100
)

age_analysis["Conversion_Rate (%)"] = (
    age_analysis["Conversions"] /
    age_analysis["Clicks"] * 100
)

age_analysis["CPA"] = (
    age_analysis["Ad_Spend"] /
    age_analysis["Conversions"]
)

age_analysis["ROAS"] = (
    age_analysis["Revenue"] /
    age_analysis["Ad_Spend"]
)

age_analysis = age_analysis.round(2)
age_analysis = age_analysis.sort_values("ROAS", ascending=False)

print(age_analysis)

gender_analysis = (
    df.groupby("Target_Audience_Gender")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

gender_analysis["CTR (%)"] = (
    gender_analysis["Clicks"] /
    gender_analysis["Impressions"] * 100
)

gender_analysis["Conversion_Rate (%)"] = (
    gender_analysis["Conversions"] /
    gender_analysis["Clicks"] * 100
)

gender_analysis["CPA"] = (
    gender_analysis["Ad_Spend"] /
    gender_analysis["Conversions"]
)

gender_analysis["ROAS"] = (
    gender_analysis["Revenue"] /
    gender_analysis["Ad_Spend"]
)

gender_analysis = gender_analysis.round(2)
gender_analysis = gender_analysis.sort_values("ROAS", ascending=False)

print(gender_analysis)
best_age = age_analysis.iloc[0]

print("Best Age Group by ROAS:", best_age["Target_Audience_Age"])
print("ROAS:", best_age["ROAS"])
print("Profit:", best_age["Profit"])
best_gender = gender_analysis.iloc[0]

print("Best Gender by ROAS:", best_gender["Target_Audience_Gender"])
print("ROAS:", best_gender["ROAS"])
print("Profit:", best_gender["Profit"])

intent_analysis = (
    df.groupby("Purchase_Intent_Score")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

intent_analysis["CTR (%)"] = (
    intent_analysis["Clicks"] /
    intent_analysis["Impressions"] * 100
)

intent_analysis["Conversion_Rate (%)"] = (
    intent_analysis["Conversions"] /
    intent_analysis["Clicks"] * 100
)

intent_analysis["CPA"] = (
    intent_analysis["Ad_Spend"] /
    intent_analysis["Conversions"]
)

intent_analysis["ROAS"] = (
    intent_analysis["Revenue"] /
    intent_analysis["Ad_Spend"]
)

intent_analysis = intent_analysis.round(2)

print(intent_analysis)

retargeting_analysis = (
    df.groupby("Retargeting_Flag")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

retargeting_analysis["CTR (%)"] = (
    retargeting_analysis["Clicks"] /
    retargeting_analysis["Impressions"] * 100
)

retargeting_analysis["Conversion_Rate (%)"] = (
    retargeting_analysis["Conversions"] /
    retargeting_analysis["Clicks"] * 100
)

retargeting_analysis["CPA"] = (
    retargeting_analysis["Ad_Spend"] /
    retargeting_analysis["Conversions"]
)

retargeting_analysis["ROAS"] = (
    retargeting_analysis["Revenue"] /
    retargeting_analysis["Ad_Spend"]
)

retargeting_analysis = retargeting_analysis.round(2)

print(retargeting_analysis)
best_intent = intent_analysis.loc[
    intent_analysis["ROAS"].idxmax()
]

print("Best Purchase Intent Score:", best_intent["Purchase_Intent_Score"])
print("ROAS:", best_intent["ROAS"])
print("Profit:", best_intent["Profit"])
best_retargeting = retargeting_analysis.loc[
    retargeting_analysis["ROAS"].idxmax()
]

print("Best Retargeting Group:", best_retargeting["Retargeting_Flag"])
print("ROAS:", best_retargeting["ROAS"])
print("Profit:", best_retargeting["Profit"])

device_analysis = (
    df.groupby("Device_Type")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

device_analysis["CTR (%)"] = (
    device_analysis["Clicks"] /
    device_analysis["Impressions"] * 100
)

device_analysis["Conversion_Rate (%)"] = (
    device_analysis["Conversions"] /
    device_analysis["Clicks"] * 100
)

device_analysis["CPA"] = (
    device_analysis["Ad_Spend"] /
    device_analysis["Conversions"]
)

device_analysis["ROAS"] = (
    device_analysis["Revenue"] /
    device_analysis["Ad_Spend"]
)

device_analysis = device_analysis.round(2)
device_analysis = device_analysis.sort_values("ROAS", ascending=False)

print(device_analysis)

os_analysis = (
    df.groupby("Operating_System")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

os_analysis["CTR (%)"] = (
    os_analysis["Clicks"] /
    os_analysis["Impressions"] * 100
)

os_analysis["Conversion_Rate (%)"] = (
    os_analysis["Conversions"] /
    os_analysis["Clicks"] * 100
)

os_analysis["CPA"] = (
    os_analysis["Ad_Spend"] /
    os_analysis["Conversions"]
)

os_analysis["ROAS"] = (
    os_analysis["Revenue"] /
    os_analysis["Ad_Spend"]
)

os_analysis = os_analysis.round(2)
os_analysis = os_analysis.sort_values("ROAS", ascending=False)

print(os_analysis)
best_device = device_analysis.iloc[0]

print("Best Device by ROAS:", best_device["Device_Type"])
print("ROAS:", best_device["ROAS"])
print("Profit:", best_device["Profit"])
best_os = os_analysis.iloc[0]

print("Best Operating System by ROAS:", best_os["Operating_System"])
print("ROAS:", best_os["ROAS"])
print("Profit:", best_os["Profit"])

quarter_analysis = (
    df.groupby("Quarter")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

quarter_analysis["CTR (%)"] = (
    quarter_analysis["Clicks"] /
    quarter_analysis["Impressions"] * 100
)

quarter_analysis["Conversion_Rate (%)"] = (
    quarter_analysis["Conversions"] /
    quarter_analysis["Clicks"] * 100
)

quarter_analysis["CPA"] = (
    quarter_analysis["Ad_Spend"] /
    quarter_analysis["Conversions"]
)

quarter_analysis["ROAS"] = (
    quarter_analysis["Revenue"] /
    quarter_analysis["Ad_Spend"]
)

quarter_analysis = quarter_analysis.round(2)

print(quarter_analysis)

df["Start_Date"] = pd.to_datetime(df["Start_Date"])

monthly_analysis = (
    df.groupby(df["Start_Date"].dt.month)
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
      .rename(columns={"Start_Date": "Month"})
)

monthly_analysis["ROAS"] = (
    monthly_analysis["Revenue"] /
    monthly_analysis["Ad_Spend"]
)

monthly_analysis["CPA"] = (
    monthly_analysis["Ad_Spend"] /
    monthly_analysis["Conversions"]
)

monthly_analysis = monthly_analysis.round(2)

print(monthly_analysis)

day_analysis = (
    df.groupby("Day_Of_Week")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

day_analysis["CTR (%)"] = (
    day_analysis["Clicks"] /
    day_analysis["Impressions"] * 100
)

day_analysis["ROAS"] = (
    day_analysis["Revenue"] /
    day_analysis["Ad_Spend"]
)

day_analysis = day_analysis.round(2)

print(day_analysis)

hour_analysis = (
    df.groupby("Hour_Of_Day")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

hour_analysis["CTR (%)"] = (
    hour_analysis["Clicks"] /
    hour_analysis["Impressions"] * 100
)

hour_analysis["ROAS"] = (
    hour_analysis["Revenue"] /
    hour_analysis["Ad_Spend"]
)

hour_analysis = hour_analysis.round(2)

print(hour_analysis)
best_quarter = quarter_analysis.loc[
    quarter_analysis["ROAS"].idxmax()
]

print("Best Quarter:", best_quarter["Quarter"])
print("ROAS:", best_quarter["ROAS"])
print("Profit:", best_quarter["Profit"])

creative_analysis = (
    df.groupby("Creative_Format")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

creative_analysis["CTR (%)"] = (
    creative_analysis["Clicks"] /
    creative_analysis["Impressions"] * 100
)

creative_analysis["Conversion_Rate (%)"] = (
    creative_analysis["Conversions"] /
    creative_analysis["Clicks"] * 100
)

creative_analysis["CPA"] = (
    creative_analysis["Ad_Spend"] /
    creative_analysis["Conversions"]
)

creative_analysis["ROAS"] = (
    creative_analysis["Revenue"] /
    creative_analysis["Ad_Spend"]
)

creative_analysis = creative_analysis.round(2)
creative_analysis = creative_analysis.sort_values("ROAS", ascending=False)

print(creative_analysis)

placement_analysis = (
    df.groupby("Ad_Placement")
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

placement_analysis["CTR (%)"] = (
    placement_analysis["Clicks"] /
    placement_analysis["Impressions"] * 100
)

placement_analysis["Conversion_Rate (%)"] = (
    placement_analysis["Conversions"] /
    placement_analysis["Clicks"] * 100
)

placement_analysis["CPA"] = (
    placement_analysis["Ad_Spend"] /
    placement_analysis["Conversions"]
)

placement_analysis["ROAS"] = (
    placement_analysis["Revenue"] /
    placement_analysis["Ad_Spend"]
)

placement_analysis = placement_analysis.round(2)
placement_analysis = placement_analysis.sort_values("ROAS", ascending=False)

print(placement_analysis)
best_creative = creative_analysis.iloc[0]

print("Best Creative Format by ROAS:", best_creative["Creative_Format"])
print("ROAS:", best_creative["ROAS"])
print("Profit:", best_creative["Profit"])
best_placement = placement_analysis.iloc[0]

print("Best Ad Placement by ROAS:", best_placement["Ad_Placement"])
print("ROAS:", best_placement["ROAS"])
print("Profit:", best_placement["Profit"])

campaign_analysis = (
    df.groupby(["Campaign_Id", "Campaign_Objective", "Platform"])
      .agg(
          Impressions=("Impressions", "sum"),
          Clicks=("Clicks", "sum"),
          Conversions=("Conversions", "sum"),
          Ad_Spend=("Ad_Spend", "sum"),
          Revenue=("Revenue", "sum"),
          Profit=("Profit", "sum")
      )
      .reset_index()
)

campaign_analysis["CTR (%)"] = (
    campaign_analysis["Clicks"] /
    campaign_analysis["Impressions"] * 100
)

campaign_analysis["Conversion_Rate (%)"] = (
    campaign_analysis["Conversions"] /
    campaign_analysis["Clicks"] * 100
)

campaign_analysis["CPA"] = (
    campaign_analysis["Ad_Spend"] /
    campaign_analysis["Conversions"]
)

campaign_analysis["ROAS"] = (
    campaign_analysis["Revenue"] /
    campaign_analysis["Ad_Spend"]
)

campaign_analysis = campaign_analysis.round(2)

print(campaign_analysis.sort_values("ROAS", ascending=False).head(10))

top_10_roas = campaign_analysis.sort_values(
    "ROAS",
    ascending=False
).head(10)

print(top_10_roas)

bottom_10_roas = campaign_analysis.sort_values(
    "ROAS",
    ascending=True
).head(10)

print(bottom_10_roas)

top_10_profit = campaign_analysis.sort_values(
    "Profit",
    ascending=False
).head(10)

print(top_10_profit)
best_campaign = campaign_analysis.loc[
    campaign_analysis["ROAS"].idxmax()
]

print("Best Campaign by ROAS")
print("---------------------")
print("Campaign ID:", best_campaign["Campaign_Id"])
print("Platform:", best_campaign["Platform"])
print("Objective:", best_campaign["Campaign_Objective"])
print("ROAS:", best_campaign["ROAS"])
print("Profit:", best_campaign["Profit"])

import matplotlib.pyplot as plt

plt.figure(figsize=(10, 6))

plt.bar(
    platform_analysis["Platform"],
    platform_analysis["ROAS"]
)

plt.title("ROAS by Platform")
plt.xlabel("Platform")
plt.ylabel("ROAS")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

plt.figure(figsize=(10, 6))

plt.bar(
    platform_analysis["Platform"],
    platform_analysis["Profit"]
)

plt.title("Profit by Platform")
plt.xlabel("Platform")
plt.ylabel("Profit")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

plt.figure(figsize=(10, 6))

plt.bar(
    objective_analysis["Campaign_Objective"],
    objective_analysis["ROAS"]
)

plt.title("ROAS by Campaign Objective")
plt.xlabel("Campaign Objective")
plt.ylabel("ROAS")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

plt.figure(figsize=(10, 6))

plt.bar(
    age_analysis["Target_Audience_Age"].astype(str),
    age_analysis["ROAS"]
)

plt.title("ROAS by Audience Age Group")
plt.xlabel("Age Group")
plt.ylabel("ROAS")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

plt.figure(figsize=(8, 5))

plt.plot(
    quarter_analysis["Quarter"],
    quarter_analysis["ROAS"],
    marker="o"
)

plt.title("Quarterly ROAS Performance")
plt.xlabel("Quarter")
plt.ylabel("ROAS")
plt.tight_layout()
plt.show()

top_campaigns = campaign_analysis.sort_values(
    "Profit",
    ascending=False
).head(10)

plt.figure(figsize=(12, 6))

plt.bar(
    top_campaigns["Campaign_Id"].astype(str),
    top_campaigns["Profit"]
)

plt.title("Top 10 Campaigns by Profit")
plt.xlabel("Campaign ID")
plt.ylabel("Profit")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

print("========== VEYA MARKETING ANALYTICS ==========")

print("\n1. OVERALL PERFORMANCE")
print("--------------------------------")
print(f"Total Revenue: {total_revenue:,.2f}")
print(f"Total Ad Spend: {total_spend:,.2f}")
print(f"Total Profit: {total_profit:,.2f}")
print(f"Overall ROAS: {overall_roas:.2f}")
print(f"Overall CTR: {overall_ctr:.2f}%")
print(f"Overall Conversion Rate: {overall_conversion_rate:.2f}%")
print(f"Overall CPA: {overall_cpa:,.2f}")

print("\n2. BEST PLATFORM")
print("--------------------------------")
print(f"Platform: {best_platform['Platform']}")
print(f"ROAS: {best_platform['ROAS']:.2f}")
print(f"Profit: {best_platform['Profit']:,.2f}")

print("\n3. BEST CAMPAIGN OBJECTIVE")
print("--------------------------------")
print(f"Objective: {best_objective['Campaign_Objective']}")
print(f"ROAS: {best_objective['ROAS']:.2f}")
print(f"Profit: {best_objective['Profit']:,.2f}")

print("\n4. BEST AUDIENCE AGE")
print("--------------------------------")
print(f"Age Group: {best_age['Target_Audience_Age']}")
print(f"ROAS: {best_age['ROAS']:.2f}")
print(f"Profit: {best_age['Profit']:,.2f}")

print("\n5. BEST GENDER")
print("--------------------------------")
print(f"Gender: {best_gender['Target_Audience_Gender']}")
print(f"ROAS: {best_gender['ROAS']:.2f}")
print(f"Profit: {best_gender['Profit']:,.2f}")

print("\n6. BEST DEVICE")
print("--------------------------------")
print(f"Device: {best_device['Device_Type']}")
print(f"ROAS: {best_device['ROAS']:.2f}")
print(f"Profit: {best_device['Profit']:,.2f}")

print("\n7. BEST OPERATING SYSTEM")
print("--------------------------------")
print(f"OS: {best_os['Operating_System']}")
print(f"ROAS: {best_os['ROAS']:.2f}")
print(f"Profit: {best_os['Profit']:,.2f}")

print("\n8. BEST QUARTER")
print("--------------------------------")
print(f"Quarter: {best_quarter['Quarter']}")
print(f"ROAS: {best_quarter['ROAS']:.2f}")
print(f"Profit: {best_quarter['Profit']:,.2f}")

print("\n9. BEST CREATIVE FORMAT")
print("--------------------------------")
print(f"Creative: {best_creative['Creative_Format']}")
print(f"ROAS: {best_creative['ROAS']:.2f}")
print(f"Profit: {best_creative['Profit']:,.2f}")

print("\n10. BEST AD PLACEMENT")
print("--------------------------------")
print(f"Placement: {best_placement['Ad_Placement']}")
print(f"ROAS: {best_placement['ROAS']:.2f}")
print(f"Profit: {best_placement['Profit']:,.2f}")

final_summary = pd.DataFrame({
    "Analysis Area": [
        "Platform",
        "Campaign Objective",
        "Audience Age",
        "Gender",
        "Device",
        "Operating System",
        "Quarter",
        "Creative Format",
        "Ad Placement"
    ],
    "Best Performer": [
        best_platform["Platform"],
        best_objective["Campaign_Objective"],
        best_age["Target_Audience_Age"],
        best_gender["Target_Audience_Gender"],
        best_device["Device_Type"],
        best_os["Operating_System"],
        best_quarter["Quarter"],
        best_creative["Creative_Format"],
        best_placement["Ad_Placement"]
    ],
    "ROAS": [
        best_platform["ROAS"],
        best_objective["ROAS"],
        best_age["ROAS"],
        best_gender["ROAS"],
        best_device["ROAS"],
        best_os["ROAS"],
        best_quarter["ROAS"],
        best_creative["ROAS"],
        best_placement["ROAS"]
    ],
    "Profit": [
        best_platform["Profit"],
        best_objective["Profit"],
        best_age["Profit"],
        best_gender["Profit"],
        best_device["Profit"],
        best_os["Profit"],
        best_quarter["Profit"],
        best_creative["Profit"],
        best_placement["Profit"]
    ]
})

final_summary
# Format Profit to standard float/round format
final_summary["Profit"] = final_summary["Profit"].round(2)

# Print clean final table
print(final_summary.to_string(index=False))