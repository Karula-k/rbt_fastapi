class Barang:
    def __init__(self, id_barang, nama_barang, harga):
        self.id_barang = id_barang
        self.nama_barang = nama_barang
        self.harga = harga

class Node:
    def __init__(self, barang):
        self.barang = barang
        self.parent = None
        self.left = None
        self.right = None
        self.color = 1  # Merah: 1, Hitam: 0


class RedBlackTree:
    def __init__(self):
        self.nil = Node(None)  # Sentinel node
        self.root = self.nil

    # Fungsi untuk menambahkan barang ke red-black tree
    def insert(self, barang):
        new_node = Node(barang)
        new_node.parent = None
        new_node.left = self.nil
        new_node.right = self.nil
        new_node.color = 1  # Set warna node baru menjadi merah

        y = None
        x = self.root

        while x != self.nil:
            y = x
            if new_node.barang.id_barang < x.barang.id_barang:
                x = x.left
            else:
                x = x.right

        new_node.parent = y
        if y is None:
            self.root = new_node
        elif new_node.barang.id_barang < y.barang.id_barang:
            y.left = new_node
        else:
            y.right = new_node

        if new_node.parent is None:
            new_node.color = 0  # Jika node baru adalah root, maka warnanya menjadi hitam
            return

        if new_node.parent.parent is None:
            return

        self.fix_insert(new_node)  # Memperbaiki red-black tree setelah penambahan

    # Fungsi untuk memperbaiki red-black tree setelah penambahan
    def fix_insert(self, k):
        while k.parent.color == 1:
            if k.parent == k.parent.parent.right:
                u = k.parent.parent.left  # Mendapatkan node uncle
                if u.color == 1:
                    u.color = 0
                    k.parent.color = 0
                    k.parent.parent.color = 1
                    k = k.parent.parent
                else:
                    if k == k.parent.left:
                        k = k.parent
                        self.right_rotate(k)

                    k.parent.color = 0
                    k.parent.parent.color = 1
                    self.left_rotate(k.parent.parent)
            else:
                u = k.parent.parent.right  # Mendapatkan node uncle

                if u.color == 1:
                    u.color = 0
                    k.parent.color = 0
                    k.parent.parent.color = 1
                    k = k.parent.parent
                else:
                    if k == k.parent.right:
                        k = k.parent
                        self.left_rotate(k)

                    k.parent.color = 0
                    k.parent.parent.color = 1
                    self.right_rotate(k.parent.parent)

            if k == self.root:
                break

        self.root.color = 0

    # Fungsi untuk rotasi ke kiri
    def left_rotate(self, x):
        y = x.right
        x.right = y.left
        if y.left != self.nil:
            y.left.parent = x

        y.parent = x.parent
        if x.parent is None:
            self.root = y
        elif x == x.parent.left:
            x.parent.left = y
        else:
            x.parent.right = y

        y.left = x
        x.parent = y

    # Fungsi untuk rotasi ke kanan
    def right_rotate(self, x):
        y = x.left
        x.left = y.right
        if y.right != self.nil:
            y.right.parent = x

        y.parent = x.parent
        if x.parent is None:
            self.root = y
        elif x == x.parent.right:
            x.parent.right = y
        else:
            x.parent.left = y

        y.right = x
        x.parent = y

    # Fungsi untuk mencari barang berdasarkan ID
    def search(self, root, id_barang):
        if root is None or root.barang.id_barang == id_barang:
            return root

        if root.barang.id_barang < id_barang:
            return self.search(root.right, id_barang)

        return self.search(root.left, id_barang)

    # Fungsi untuk menghapus barang berdasarkan ID
    def delete_node(self, id_barang):
        self.delete_helper(self.root, id_barang)

    # Fungsi helper untuk menghapus barang berdasarkan ID
    def delete_helper(self, root, id_barang):
        z = self.nil
        while root != self.nil:
            if root.barang.id_barang == id_barang:
                z = root

            if root.barang.id_barang <= id_barang:
                root = root.right
            else:
                root = root.left

        if z == self.nil:
            print("Barang tidak ditemukan")
            return

        y = z
        y_original_color = y.color
        if z.left == self.nil:
            x = z.right
            self.rb_transplant(z, z.right)
        elif z.right == self.nil:
            x = z.left
            self.rb_transplant(z, z.left)
        else:
            y = self.minimum(z.right)
            y_original_color = y.color
            x = y.right
            if y.parent == z:
                x.parent = y
            else:
                self.rb_transplant(y, y.right)
                y.right = z.right
                y.right.parent = y

            self.rb_transplant(z, y)
            y.left = z.left
            y.left.parent = y
            y.color = z.color

        if y_original_color == 0:
            self.fix_delete(x)

    # Fungsi untuk mentransplant node
    def rb_transplant(self, u, v):
        if u.parent == None:
            self.root = v
        elif u == u.parent.left:
            u.parent.left = v
        else:
            u.parent.right = v

        v.parent = u.parent

    # Fungsi untuk memperbaiki red-black tree setelah penghapusan
    def fix_delete(self, x):
        while x != self.root and x.color == 0:
            if x == x.parent.left:
                s = x.parent.right

                if s.color == 1:
                    s.color = 0
                    x.parent.color = 1
                    self.left_rotate(x.parent)

    def edit(self,id,barang):
        if id == barang.id_barang:
            self.delete_node(id)
            self.insert(barang)
            return "file succesfully edited"
        else:
            return "id not same"

    def in_order_traversal(self, root):
        result = []
        if root != self.nil:
            result = self.in_order_traversal(root.left)
            result.append(root.barang)
            result += self.in_order_traversal(root.right)
        return result

    def sorted_data(self):
        return self.in_order_traversal(self.root)

# rb_tree = RedBlackTree()
# # Menambahkan barang
# barang1 = Barang(1, "Buku", 10)
# barang2 = Barang(2, "Pensil", 5)
# barang3 = Barang(3, "Penghapus", 3)

# rb_tree.insert(barang1)
# rb_tree.insert(barang2)
# rb_tree.insert(barang3)

# print(rb_tree.sorted_data())
# # Mencari barang berdasarkan ID
# search_id = 2
# result = rb_tree.search(rb_tree.root, search_id)
# barangFake = Barang(3, "Penghapus fake", 3)
# rb_tree.edit(3,barangFake)
# print(rb_tree.sorted_data())

# if result:
#     print(f"Barang dengan ID {search_id} ditemukan: {result.barang.nama_barang}")
# else:
#     print(f"Barang dengan ID {search_id} tidak ditemukan")

# # Menghapus barang berdasarkan ID
# delete_id = 1
# rb_tree.delete_node(delete_id)
# rb_tree = RedBlackTree()
# data = [4, 2, 7, 1, 9, 32, 19, 20, 3]

# for value in data:
#     rb_tree.insert(value, "new_name", 15.5, 5)
# rb_tree.delete(4)
# # rb_tree.edit(1,10)
# rb_tree.edit(1, 10, "new_name", 15.5, 5)
# sorted_data = rb_tree.sorted_data()
# print(sorted_data)