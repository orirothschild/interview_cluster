
from queue import LifoQueue

class Stack:
    def __init__(self):
        self.top = None
        self.count = 0
        self.maximum = None
    def getMax(self):
        if self.top is None:
            return ('empty stack')
        return(f'stack top is {self.maximum}')
    def isEmpty(self):
        True if self.top is None else False
    

def maxstack(s):
    s1 = s2 = LifoQueue(maxsize=5)
    while not s.qsize():
        if s1.top() <=  s.top():
            s1.push(s.pop())
        else:
            while s.top() > s1.top():
                s2.push(s1.pop())
            s1.push(s.pop())
            while not s2.empty():
                s1.push(s2.pop())
        
    return s1

if __name__ == "__main__":
    max_stack = maxstack([11,12,13,31,24,15])
    print(' '.join(max_stack))
    