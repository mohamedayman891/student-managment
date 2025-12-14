import 'package:project_data/classes/students_data.dart';

class StudentQueue {
  final List<Student?> queue;
  int front = 0;
  int rear = -1;
  int size = 0;
  final int capacity;

  StudentQueue(this.capacity) : queue = List.filled(capacity, null);

  bool isEmpty() => size == 0;
  bool isFull() => size == capacity;

  // إضافة عنصر في نهاية الQueue
  void enqueue(Student student) {
    if (isFull()) {
      print("Queue is full");
      return;
    }
    rear = (rear + 1) % capacity;
    queue[rear] = student;
    size++;
  }

  // حذف أول عنصر (FIFO)
  Student? dequeue() {
    if (isEmpty()) {
      print("Queue is empty");
      return null;
    }
    Student? removed = queue[front];
    queue[front] = null;
    front = (front + 1) % capacity;
    size--;
    return removed;
  }

  Student? peek() {
    if (isEmpty()) {
      return null;
    } else {
      return queue[front];
    }
  }
}
