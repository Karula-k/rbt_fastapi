from typing import Union
from fastapi import FastAPI, Form, File, UploadFile
from pydantic import BaseModel

from test_black_tree import Node, RedBlackTree

app = FastAPI()

global RBT,lst
RBT = RedBlackTree()
lst = []
class Item(BaseModel):
    id : int #id 
    name :str
    quantity: int
    #optional
    harga :str

@app.get('/read')
async def read_root():
    
    return RBT.sorted_data()


@app.get('/')
async def home():
    return {"test": "test"}

@app.post("/items/")
async def add_item(item: Item):
    RBT.insert(item.id)
    lst.append(item)
    return {"added": item.id}
@app.put("/items/")
async def edit_item(item:Item):
    lst.append(item)
    RBT.edit(item.id)
    return {"added": item.id}
@app.delete("/items/")
async def edit_item(item:Item):
    RBT.delete(item.id)
    return {"added": item.id}