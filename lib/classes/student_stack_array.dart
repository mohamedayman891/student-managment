import 'package:project_data/classes/students_data.dart';

class StudentStackArray {
  int maxSize;
  int top = -1;
  late List<Student?> stackArray;

  StudentStackArray(this.maxSize) {
    stackArray = List<Student?>.filled(maxSize, null);
  }

  Student? push(Student s) {
    if (isFull()) {
      return null;
    } else {
      top++;
      stackArray[top] = s;
      return stackArray[top];
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

  Student? peek() {
    if (isEmpty()) {
      return null;
    } else {
      return stackArray[top];
    }
  }

  bool isEmpty() {
    return top == -1;
  }

  bool isFull() {
    return top == maxSize - 1;
  }
}
