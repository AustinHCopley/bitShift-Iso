# bitShift-Iso

Assembly bit shifter and bit isolater

## Pseudocode

~~~
while (end != yes) {
  cout << please enter a number
  userin = number
  cout << would you like to shift or isolate
  if userin == 0:
    take input for shift
    perform shift calculations
  else if userin == 1:
    take input for isolation
    perform isolate calculations
  cout << result
  stackpointer->result
  cout << stored, would you like to perform another calculation?
}
while stackpointer -> next != NULL {
  cout stackpointer->data
  stackpointer = stackpointer->next
}
~~~
