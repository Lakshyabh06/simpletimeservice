from flask import Flask, request, jsonify, render_template
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def home():
    import pytz

    ist = pytz.timezone("Asia/Kolkata")
    timestamp = datetime.now(ist).isoformat()
    client_ip = request.remote_addr


    if "application/json" in request.headers.get("Accept", ""):
        return jsonify({
            "timestamp": timestamp,
            "ip": client_ip,
            "service": "SimpleTimeService",
            "author": "Lakshya Bhardwaj"
        })

    return render_template(
        "index.html",
        timestamp=timestamp,
        ip=client_ip
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
 
