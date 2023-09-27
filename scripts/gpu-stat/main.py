import streamlit as st
import pandas as pd
from datetime import datetime, timedelta


ip_list = [
    '172.17.240.73',
    '172.18.240.107',
    '172.18.240.119',
    '172.17.240.253',
    '172.18.240.231',
    '172.18.240.195',
    '172.18.240.100'
]


st.title("DeCLaRe Admin GPU Monitoring")
chart_option = st.selectbox( "Select Machine: ", ['Total']+ip_list )
per_user = st.checkbox('Show individual user usage', value=False)
time_span = st.radio('Usage History in Days', ('1', '3', '7', '30'))

def create_line_chart(ip):
    if ip == "Total":
        df = pd.concat([ pd.read_csv(f'{ip}_gpu_log.csv') for ip in ip_list ])
    else:
        df = pd.read_csv(f'{ip}_gpu_log.csv')

    if not per_user: df['user'] = 'All Users'

    df['datetime'] = pd.to_datetime(df['date'] + ' ' + df['time'])
    time_limit = datetime.today() - timedelta(days=int(time_span))
    df = df[df['datetime'] >= time_limit]

    grouped_df = df.groupby(
        [pd.Grouper(key='datetime', freq='1H'), 'user']
    ).size().reset_index(name='count')

    table = grouped_df.pivot_table(index='datetime', columns='user', values='count', fill_value=0)
    table = table.divide(12) # one hour have 12 five minutes interval

    return table


st.line_chart(
    create_line_chart(chart_option)
)

