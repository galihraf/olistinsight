import duckdb
import os

# Koneksi ke DuckDB
con = duckdb.connect("data/duckdb/olist.duckdb")

# Folder data mentah 
raw_folder = "data/raw"

# Daftar file CSV
csv_files = {
    "customers": "olist_customers_dataset",
    "orders": "olist_orders_dataset",
    "order_items": "olist_order_items_dataset",
    "payments": "olist_order_payments_dataset",
    "reviews": "olist_order_reviews_dataset",
    "products": "olist_products_dataset",
    "sellers": "olist_sellers_dataset",
    "geolocation": "olist_geolocation_dataset",
    "category_translation": "product_category_name_translation",
}

# Load setiap CSV ke DuckDB
for table_name, file_name in csv_files.items():
    filepath = os.path.join(raw_folder, f"{file_name}.csv").replace("\\", "/")
    con.execute(f"CREATE OR REPLACE TABLE {table_name} AS SELECT * FROM read_csv_auto('{filepath}')")
    print(f"✅ Loaded: {table_name}")

con.close()
print("\n🎉 Semua data berhasil masuk ke DuckDB!")