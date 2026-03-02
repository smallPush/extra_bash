## 2025-03-02 - Insecure YAML Deserialization
**Vulnerability:** Python scripts (`deploy_server.py` and `get_enviroment.py`) were using `yaml.load(..., Loader=yaml.FullLoader)` to parse YAML files, which is vulnerable to arbitrary code execution if an attacker controls the YAML file.
**Learning:** `yaml.load` is unsafe even with `Loader=yaml.FullLoader` because it can construct arbitrary Python objects.
**Prevention:** Always use `yaml.safe_load()` which restricts the ability to construct complex objects during parsing and prevents arbitrary code execution vulnerabilities.
