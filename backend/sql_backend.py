import sqlite3

class DataSource:
    def __init__(self, db_name, table_name="stockGudang"):
        self.db_name = db_name + ".db"
        self.table_name = table_name

        with sqlite3.connect(self.db_name) as con:
            cur = con.cursor()
            create_text = f"CREATE TABLE IF NOT EXISTS {self.table_name} (id INTEGER PRIMARY KEY, name TEXT, harga INTEGER)"
            cur.execute(create_text)

    def add_items(self,id, nama_barang, harga):
        with sqlite3.connect(self.db_name) as con:
            cur = con.cursor()
            cur.execute(f"INSERT INTO {self.table_name} VALUES (?, ?, ?)", (id,nama_barang, harga))
            con.commit()

    def view_data(self):
        with sqlite3.connect(self.db_name) as con:
            cur = con.cursor()
            cur.execute(f"SELECT * FROM {self.table_name}")
            rows = cur.fetchall()
        return rows

    def edit_data(self, name=None, harga=None, idbr=-1):
        with sqlite3.connect(self.db_name) as con:
            cur = con.cursor()
            dict_items = {"name": name, "harga": harga}
            text2 = {k: v for k, v in dict_items.items() if v is not None}
            placeholders = ', '.join([f"{i} = ?" for i in text2])
            cur.execute(f"UPDATE {self.table_name} SET {placeholders} WHERE id = ?", (*text2.values(), idbr))
            con.commit()

    def delete_item(self, id):
        with sqlite3.connect(self.db_name) as con:
            cur = con.cursor()
            cur.execute(f"DELETE FROM {self.table_name} WHERE id=?", (id,))
            con.commit()

    def order_by(self, type_cl):
        with sqlite3.connect(self.db_name) as con:
            cur = con.cursor()
            text = f"SELECT * FROM {self.table_name} ORDER BY {type_cl}"
            cur.execute(text)
            rows = cur.fetchall()
        return rows
