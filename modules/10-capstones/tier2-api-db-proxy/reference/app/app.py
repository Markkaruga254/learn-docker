import os

import psycopg2
from flask import Flask, jsonify

app = Flask(__name__)


def get_conn():
    return psycopg2.connect(
        host=os.environ["DB_HOST"],
        dbname=os.environ["POSTGRES_DB"],
        user=os.environ["POSTGRES_USER"],
        password=os.environ["POSTGRES_PASSWORD"],
        connect_timeout=3,
    )


@app.get("/health")
def health():
    return jsonify(status="ok")


@app.get("/ready")
def ready():
    try:
        conn = get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute("SELECT 1")
        finally:
            conn.close()
        return jsonify(status="ready")
    except Exception as exc:  # noqa: BLE001
        return jsonify(status="db-unavailable", error=str(exc)), 503


@app.get("/visits")
def visits():
    conn = get_conn()
    try:
        with conn, conn.cursor() as cur:
            cur.execute(
                "CREATE TABLE IF NOT EXISTS visits (id SERIAL PRIMARY KEY, ts TIMESTAMPTZ DEFAULT now())"
            )
            cur.execute("INSERT INTO visits DEFAULT VALUES")
            cur.execute("SELECT count(*) FROM visits")
            total = cur.fetchone()[0]
        return jsonify(visits=total)
    finally:
        conn.close()
