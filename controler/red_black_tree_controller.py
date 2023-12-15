from backend.red_black_tree import RedBlackTree, Barang as rdbBarang
from backend.sql_backend import DataSource
from sqlite3 import Error

class RedBlackTreeController:
    def __init__(self):
        self.db = DataSource('rbt_db')
        self.rbt = RedBlackTree()
        
    def on_startsup(self):
        try:
            data = self.db.view_data()
            for i in data:
                barang = rdbBarang(i[0], i[1], i[2])
                self.rbt.insert(barang)
        except Error as e:
            print(f"Error during startup: {e}")

    def insert_item(self, barang):
        try:
            item = rdbBarang(barang.id_barang, barang.nama_barang, barang.harga)
            self.db.add_items(barang.id_barang,barang.nama_barang, barang.harga)
            self.rbt.insert(item)
        except Error as e:
            print(f"Error during insertion: {e}")

    def edit_item(self, id, new_barang):
        try:
            self.db.edit_data(new_barang.nama_barang, new_barang.harga, id)
            self.rbt.edit(id, new_barang)
        except Error as e:
            print(f"Error during editing: {e}")

    def delete_item(self, id):
        try:
            self.db.delete_item(id)
            self.rbt.delete_node(id)
        except Error as e:
            print(f"Error during deletion: {e}")

    def get_sorted_data(self):
        try:
            return self.rbt.sorted_data()
        except Error as e:
            print(f"Error while getting sorted data: {e}")
            return []
