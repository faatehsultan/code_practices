class MyNode:
    def __init__(self, data):
        self.data = data
        self.next = None


class MyLinkedList:
    def __init__(self):
        self.head = None

    def insert(self, data):
        if self.head == None:
            self.head = MyNode(data)
        else:
            cur = self.head
            while cur.next != None:
                cur = cur.next
            cur.next = MyNode(data)

    def display(self):
        if self.head == None:
          return
        cur = self.head
        while(cur.next != None):
            print(cur.data)
            cur = cur.next
        print(cur.data)

    def reverse(self):
      if self.head == None:
        return
      
      cur = self.head
      prev = None

      while cur != None:
        next = cur.next
        cur.next = prev
        prev = cur
        cur = next
      self.head = prev


# main program

l = MyLinkedList()

l.display()
l.insert(10)
l.insert(21)
l.insert(6)
l.display()
print("----")
l.reverse()
l.display()
