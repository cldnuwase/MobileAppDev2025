/*
Arrow functions are a concise way to 
write functions that return a single expression
Syntax:
returnType functionName(parameters) => expression;

Usage:
To make code more concise and readable.
*/
//example
//int square(int x) => x * x;

int square(int x) {
  print (x*x);
  return x * x;
}

void main() {
  print(square(5)); // Output: 25
}
