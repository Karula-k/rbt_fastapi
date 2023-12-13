from fastapi import FastAPI
from pydantic import BaseModel
from controler.red_black_tree_controller import RedBlackTreeController as rdbc

app = FastAPI()

class Barang(BaseModel):
    id_barang : int
    nama_barang : str
    harga :int

global rdb_controller
rdb_controller = rdbc()

@app.on_event("startup")
async def startup_event():
    rdb_controller.on_startsup()
    
@app.get('/')
async def read_root():
    return rdb_controller.get_sorted_data()

@app.post("/barang/")
async def add_item(barang: Barang):
    rdb_controller.insert_item(barang)
    return {"added": barang.id_barang}

@app.put("/barang/{id}")
async def edit_barang(id: int, barang: Barang):
    rdb_controller.edit_item(id, barang)
    return {"added": barang.id_barang}

@app.delete("/barang/{id}")
async def delete_barang(id: int):
    rdb_controller.delete_item(id)
    return {"delete": id}
