#include <iostream>
#include <string>
#include <stdio.h>

using namespace std;


int strlen(char* str_) {
  char* str = str_;
  int cont = 0;
  while (*str != '\0') {
    cont++;
    str++;
  }

  if (*(--str) == '\n') {
    *str = '\0';
    --cont;
  } 

  return cont;
}

bool reverse_str(char* str_, int length, bool& is_pal) {
  
  if (length == 0 || length == 1)
    return is_pal;
  
  //len = 4
  //h o l a
  //0 1 2 3

  //c    a   d e n a l a r   g    a
  //0    1   2 3 4 5 6 7 8   9    10


  --length;


  char aux = *str_;
  *str_ = *(str_ + length);
  
  if (aux != *str_)
    is_pal = false;
  
  *(str_ + length) = aux;

  reverse_str(++str_, --length, is_pal);
}

bool reverse(char* str_, int length) {
  bool is_pal = true;
  return reverse_str(str_, length, is_pal);
}



int main(void) {

  char str[50];
  cout << " > ";
  fgets(str, sizeof(str), stdin);
  cout << "length : " << strlen(str) << endl;
  bool is_pal = reverse(str, strlen(str));
  cout << str << endl;
  cout << (is_pal ? " " : "No ") << "es palíndromo" << endl;

  

  return 0; 
}