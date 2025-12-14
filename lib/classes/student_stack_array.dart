import 'package:project_data/classes/students_data.dart';

class StudentStackArray {
  int maxSize;
  int top = -1;
  late List<Student?> stackArray;

  StudentStackArray(this.maxSize) {
    stackArray = List<Student?>.filled(maxSize, null);
  }

  bool push(Student s) {
    if (isFull()) {
      return false;
    } else {
      top++;
      stackArray[top] = s;
      return true;
    }
  }

  Student? pop() {
    if (isEmpty()) {
      return null;
    } else {
      Student? temp = stackArray[top];
      stackArray[top] = null;
      top--;
      return temp;
    }
  }

  bool isEmpty() => top == -1;
  bool isFull() => top == maxSize - 1;
}

class StudentQueue {
  final List<Student?> _queue;
  int _front = 0;
  int _rear = 0;
  int _size = 0;
  final int _capacity;

  StudentQueue(this._capacity) : _queue = List.filled(_capacity, null);

  bool isEmpty() => _size == 0;
  bool isFull() => _size == _capacity;

  // إضافة عنصر في نهاية الQueue
  void enqueue(Student student) {
    if (isFull()) {
      print("Queue is full");
      return;
    }
    _queue[_rear] = student;
    _rear = (_rear + 1) % _capacity;
    _size++;
  }

  // حذف أول عنصر (FIFO)
  Student? dequeue() {
    if (isEmpty()) {
      print("Queue is empty");
      return null;
    }
    Student? removed = _queue[_front];
    _queue[_front] = null;
    _front = (_front + 1) % _capacity;
    _size--;
    return removed;
  }

  Student? peek() {
    if (isEmpty()) return null;
    return _queue[_front];
  }
}
