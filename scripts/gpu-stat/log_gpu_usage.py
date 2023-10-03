import csv
import os
import pwd
import socket
import time

import psutil
from py3nvml.py3nvml import (
    nvmlDeviceGetComputeRunningProcesses,
    nvmlDeviceGetCount,
    nvmlDeviceGetHandleByIndex,
    nvmlInit,
    nvmlShutdown,
)


def get_gpu_usage():
    nvmlInit()
    gpu_usage = []

    device_count = nvmlDeviceGetCount()
    for i in range(device_count):
        device_handle = nvmlDeviceGetHandleByIndex(i)

        process_info_list = nvmlDeviceGetComputeRunningProcesses(device_handle)
        for process_info in process_info_list:
            pid = process_info.pid

            used_memory = process_info.usedGpuMemory

            ps_process = psutil.Process(pid)
            command = " ".join(ps_process.cmdline())

            process = psutil.Process(pid)
            user = pwd.getpwuid(process.uids().real).pw_name

            gpu_usage.append(
                {
                    "user": user,
                    "command": command,
                    "memory_usage": used_memory // 1024 // 1024,
                }
            )

    nvmlShutdown()
    return gpu_usage


def log_gpu_usage_to_csv(gpu_usage, file_path):
    header = ["date", "time", "user", "command", "memory_usage"]

    file_exists = os.path.isfile(file_path)

    with open(file_path, "a", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=header)

        if not file_exists:
            writer.writeheader()

        current_time = time.localtime()
        date_str = time.strftime("%Y-%m-%d", current_time)
        time_str = time.strftime("%H:%M:%S", current_time)

        for usage in gpu_usage:
            usage["date"] = date_str
            usage["time"] = time_str
            writer.writerow(usage)


s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
csv_file_path = (
    f"{os.path.dirname(os.path.abspath(__file__))}/{s.getsockname()[0]}_gpu_log.csv"
)
print(csv_file_path)
s.close()

gpu_usage = get_gpu_usage()
log_gpu_usage_to_csv(gpu_usage, csv_file_path)
