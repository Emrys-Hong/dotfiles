import os
from datetime import datetime, timedelta

import pandas as pd
import streamlit as st


def get_ip_list(directory="."):
    return [f.split("_")[0] for f in os.listdir(directory) if f.endswith(".csv")]


def remove_slash(s):
    return "".join(x for i, x in enumerate(s) if i == 0 or x != s[i - 1])


def parse_content(du_file):
    with open(du_file, "r") as file:
        content = file.readlines()
    lst = [content[0]]  # execution time
    for i in range(1, len(content)):
        if content[i] != content[i - 1]:
            if len(content[i].strip()) > 0:
                du, user = content[i].split()
                if du == "0":
                    continue
                if "lost+found" in user:
                    continue
                if user == "total":
                    # content[i+1] : 4.0K	/mnt/data1/emrys
                    user = content[i + 1].split()[1]
                    user = "/".join(user.split("/")[:-1])
                    lst.append("\n")
                user = remove_slash(user)
                lst.append(du + "\t" + user)
    return "\n".join(lst).strip()


def main(ip):
    csvs = {
        ip: pd.read_csv(f"{ip}_gpu_log.csv", on_bad_lines="skip")
        for ip in ip_list
        if os.path.exists(f"{ip}_gpu_log.csv")
    }
    for k, v in csvs.items():
        v["machine"] = k

    if ip == "Total":
        df = pd.concat(list(csvs.values()))
        if per_user:
            user = st.selectbox("Select User: ", ["All User"] + list(set(df["user"])))
            if user != "All User":
                df = df[df["user"] == user]

    else:
        if os.path.exists(f"{ip}_gpu_log.csv"):
            df = csvs[ip]
        else:
            df = pd.concat(list(csvs.values()))

    if not per_user:
        df["user"] = "All Users"
    if per_machine:
        df["user"] = "All Users"

    df["datetime"] = pd.to_datetime(df["date"] + " " + df["time"], errors="coerce")
    time_limit = datetime.today() - timedelta(days=int(time_span))
    df = df[df["datetime"] >= time_limit]
    # previous full hour
    now = datetime.now()
    truncated_time = now.replace(minute=0, second=0, microsecond=0)
    df = df[df["datetime"] < truncated_time]

    if per_machine:
        grouped_df = (
            df.groupby([pd.Grouper(key="datetime", freq="1H"), "machine"])
            .size()
            .reset_index(name="count")
        )

        table = grouped_df.pivot_table(
            index="datetime", columns="machine", values="count", fill_value=0
        )

    else:
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
            content = parse_content(du_file)
            st.text_area("Disk Usage:", content, height=800)  # Adjust height as needed


if __name__ == "__main__":
    current_server_ip = "172.17.240.73"
    ip_list = get_ip_list() + [current_server_ip]

    st.title("DeCLaRe Admin GPU & Disk Monitoring")
    chart_option = st.selectbox(
        "Select Machine for gpu and disk usage: ", ["Total"] + ip_list
    )
    per_user = st.checkbox("Show individual user usage", value=False)
    per_machine = st.checkbox("Show individual machine usage", value=False)

    if per_user and per_machine:
        st.text(
            "Error: You cannot select individual user and machine at the same time!",
        )
    time_span = st.radio("Usage History in Days", ("1", "3", "7", "30"))

    main(chart_option)
