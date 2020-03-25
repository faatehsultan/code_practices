#ifndef MY_STACK_H
#define MY_STACK_H
#include <iostream>
#include <exception>
using namespace std;

template<typename T>
class Stack
{
private:
	T* data;
	int capacity;
	int top;
	void reSize(int);
public:
	Stack();
	Stack(const Stack<T>&);
	Stack& operator=(const Stack <T>&);
	~Stack();
	void push(T);
	T pop();
	T stackTop();
	bool isFull();
	bool isEmpty();
	int getCapacity();
	int getNumberOfElements();
};

#endif MY_STACK_H


//definitions

template<typename T>
Stack<T>::Stack() :capacity(0), data(nullptr), top(0)
{}

template<typename T>
void Stack<T>::push(T val)
{
	if (isFull())
		reSize(!capacity ? 1 : capacity * 2);
	data[top++] = val;
}

template<typename T>
T Stack<T>::pop()
{
	if (isEmpty())
		throw exception;
	T val = data[--top];
	if (top > 0 && top == capacity / 4)
		reSize(capacity / 2);
	return val;
}

template<typename T>
void Stack<T>::reSize(int newSize)
{
	T* temp = new T[newSize];
	for (int i = 0; i < top; i++)
		temp[i] = data[i];
	this->~Stack();
	data = temp;
	capacity = newSize;
}

template<typename T>
T Stack<T>::stackTop()
{
	if (isEmpty())
		throw exception;
	return data[top - 1];
}

template<typename T>
int Stack<T>::getCapacity()
{
	return capacity;
}

template<typename T>
int Stack<T>::getNumberOfElements()
{
	return top;
}

template<typename T>
Stack<T>::Stack(const Stack<T>& ref) :Stack()
{
	if (!data)
		return;
	capacity = ref.capacity;
	top = ref.top;
	data = new T[capacity];
	for (int i = 0; i < top; i++)
		data[i] = ref.data[i];
}

template<typename T>
Stack<T>& Stack<T>::operator=(const Stack<T>& ref)
{
	if (this == &ref)
		return;
	this->~Stack();
	capacity = ref.capacity;
	top = ref.top;
	data = new T[capacity];
	for (int i = 0; i < top; i++)
		data[i] = ref.data[i];
}

template<typename T>
Stack<T>::~Stack()
{
	if (!data)
		return;
	delete[]data;
	data = nullptr;
}

template<typename T>
bool Stack<T>::isEmpty()
{
	return top == 0;
}

template<typename T>
bool Stack<T>::isFull()
{
	return top == capacity;
}
