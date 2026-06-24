import duckdb
import os

con = duckdb.connect("data/duckdb/olist.duckdb")

export_folder = "data/exports"
os.makedirs(export_folder, exist_ok=True)

marts = [
    "mart_revenue",
    "mart_seller_performance",
    "mart_product_performance",
    "mart_customer_behavior",
    "mart_delivery_performance",
]

for mart in marts:
    filepath = os.path.join(export_folder, f"{mart}.csv").replace("\\", "/")
    con.execute(f"COPY {mart} TO '{filepath}' (HEADER, DELIMITER ',')")
    print(f"Exported: {mart}")

con.close()
print("\nSemua mart berhasil diexport!")