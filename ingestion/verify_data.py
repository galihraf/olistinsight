import duckdb

con = duckdb.connect("data/duckdb/olist.duckdb")

tables = ["customers", "orders", "order_items", "payments", "reviews", "products", "sellers", "geolocation", "category_translation"]

for table in tables:
    count = con.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
    print(f"✅ {table}: {count:,} baris")

con.close()