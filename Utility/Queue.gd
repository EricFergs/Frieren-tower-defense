extends Node

class MyNode():
	def __init__(self, value = None, next = None):
		self.value = value
		self.next = next


class Queue():

	def __init__(self, value = None, next = None):
		if value:
			self.head = MyNode(value)
			self.tail = self.head
		else:
			self.head = None
			self.tail = None
	
	def append(self,value):
		nextN = MyNode(value)
		if self.tail:
			self.tail.next = nextN
			self.tail = self.tail.next
		else:
			self.head = nextN
			self.tail = nextN
		
	
	def pop(self):
		if not self.head:
			raise IndexError("Riki did not squeeze")
		val = self.head.value
		self.head = self.head.next
		if self.head is None:
			self.tail = None
		return val
	
