import os
from datetime import datetime, timedelta

import pandas as pd
import streamlit as st


def get_ip_list(directory="."):
    return [f.split("_")[0] for f in os.listdir(directory) if f.endswith(".csv")]


ip_list = get_ip_list()

st.title("DeCLaRe Admin GPU Monitoring")
chart_option = st.selectbox("Select Machine: ", ["Total"] + ip_list)
per_user = st.checkbox("Show individual user usage", value=False)
time_span = st.radio("Usage History in Days", ("1", "3", "7", "30"))


def main(ip):
    if ip == "Total":
        df = pd.concat([pd.read_csv(f"{ip}_gpu_log.csv", on_bad_lines='skip') for ip in ip_list])
        if per_user:
            user = st.selectbox("Select User: ", ["All User"] + list(set(df["user"])))
            if user != "All User":
                df = df[df["user"] == user]

    else:
        df = pd.read_csv(f"{ip}_gpu_log.csv", on_bad_lines='skip')

    if not per_user:
        df["user"] = "All Users"

    df["datetime"] = pd.to_datetime(df["date"] + " " + df["time"])
    time_limit = datetime.today() - timedelta(days=int(time_span))
    df = df[df["datetime"] >= time_limit]
    # previous full hour
    now = datetime.now()
    truncated_time = now.replace(minute=0, second=0, microsecond=0)
    df = df[df["datetime"] < truncated_time]

    grouped_df = (
        df.groupby([pd.Grouper(key="datetime", freq="1H"), "user"])
        .size()
        .reset_index(name="count")
    )

    table = grouped_df.pivot_table(
        index="datetime", columns="user", values="count", fill_value=0
    )
    table = table.divide(12)  # one hour have 12 five minutes interval

    st.line_chart(table)

    if ip != "Total":
        du_file = f"disk_usage_{ip}.txt"
        if os.path.exists(du_file):
            with open(du_file, 'r') as file: content = file.read()
            st.text_area("Disk Usage:", content, height=400)  # Adjust height as needed

main(chart_option)

