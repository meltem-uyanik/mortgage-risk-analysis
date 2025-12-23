from pathlib import Path
import csv, re

# Project root = folder that contains this script's parent folder
PROJECT_ROOT = Path(__file__).resolve().parents[1]

CSV_PATH = PROJECT_ROOT / "data" / "raw" / "KB1H1DSPRFMYMCUFXT09_header.csv"
OUT_SQL  = PROJECT_ROOT / "sql" / "01_create_hmda_raw.sql"

def safe_col(name: str) -> str:
    n = name.strip().lower()
    n = re.sub(r"\s+", "_", n)
    n = re.sub(r"[^a-z0-9_]", "_", n)
    n = re.sub(r"_+", "_", n).strip("_")
    return n or "col"

OUT_SQL.parent.mkdir(parents=True, exist_ok=True)

with open(CSV_PATH, newline="", encoding="utf-8") as f:
    header = next(csv.reader(f, delimiter="|"))

cols = [safe_col(c) for c in header]

# make unique if duplicates
seen = {}
final_cols = []
for c in cols:
    if c not in seen:
        seen[c] = 1
        final_cols.append(c)
    else:
        seen[c] += 1
        final_cols.append(f"{c}_{seen[c]}")

lines = []
lines.append("-- sql/01_create_hmda_raw.sql")
lines.append("-- Auto-generated from CSV header")
lines.append(f"-- Source: {CSV_PATH.as_posix()}")
lines.append("")
lines.append("DROP TABLE IF EXISTS hmda_raw;")
lines.append("")
lines.append("CREATE TABLE hmda_raw (")
for i, c in enumerate(final_cols):
    comma = "," if i < len(final_cols) - 1 else ""
    lines.append(f'  "{c}" TEXT{comma}')
lines.append(");")
lines.append("")

OUT_SQL.write_text("\n".join(lines), encoding="utf-8")

print(f"✅ Wrote: {OUT_SQL}")
print(f"✅ Columns: {len(final_cols)}")
