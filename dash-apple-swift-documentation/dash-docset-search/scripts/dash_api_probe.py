#!/usr/bin/env python3
"""Probe local Dash API availability and schema."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any
from urllib.error import URLError
from urllib.request import urlopen


STATUS_FILE = (
    Path.home()
    / "Library"
    / "Application Support"
    / "Dash"
    / ".dash_api_server"
    / "status.json"
)


def _read_json_url(url: str, timeout: float = 2.0) -> tuple[bool, Any]:
    try:
        with urlopen(url, timeout=timeout) as response:
            return True, json.loads(response.read().decode("utf-8"))
    except (OSError, URLError, json.JSONDecodeError):
        return False, None


def main() -> int:
    result: dict[str, Any] = {
        "status_file_port": None,
        "health_ok": False,
        "schema_ok": False,
        "base_url": None,
        "schema_paths": [],
    }

    try:
        status_data = json.loads(STATUS_FILE.read_text(encoding="utf-8"))
        port = status_data.get("port")
        if isinstance(port, int):
            result["status_file_port"] = port
            result["base_url"] = f"http://127.0.0.1:{port}"
    except (FileNotFoundError, json.JSONDecodeError, OSError):
        print(json.dumps(result, indent=2, sort_keys=True))
        return 0

    base_url = result["base_url"]
    ok_health, health = _read_json_url(f"{base_url}/health")
    if ok_health and isinstance(health, dict) and health.get("status") == "ok":
        result["health_ok"] = True

    ok_schema, schema = _read_json_url(f"{base_url}/schema")
    if ok_schema and isinstance(schema, dict):
        result["schema_ok"] = True
        paths = schema.get("paths", {})
        if isinstance(paths, dict):
            result["schema_paths"] = sorted(paths.keys())

    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
