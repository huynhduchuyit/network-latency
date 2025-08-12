from flask import Flask, Response
from ping3 import ping
import os
from datetime import datetime

app = Flask(__name__)

TARGET_HOST = os.getenv("TARGET_HOST")
RESULTS_FILE = "results.txt"

@app.route("/latency")
def get_latency():
    latency = ping(TARGET_HOST, timeout=2)
    latency_ms = round(latency * 1000, 2) if latency else None
    current_time = datetime.now().strftime("[%Y-%m-%d %H:%M:%S]")

    if latency_ms is not None:
        response = f"{current_time} Latency: {latency_ms} ms\n"
    else:
        response = f"{current_time} Latency: timeout\n"

    with open(RESULTS_FILE, "a") as file:
        file.write(response)

    return response

@app.route("/latency-results")
def read_latency_results():
    if os.path.exists(RESULTS_FILE):
        with open(RESULTS_FILE, "r") as file:
            content = file.read()
        return Response(content, mimetype='text/plain')
    else:
        return "No resutls found."

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
